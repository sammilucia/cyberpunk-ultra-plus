UltraPlus = {
	__VERSION	 = '4.7.3',
	__DESCRIPTION = 'Better Path Tracing, Ray Tracing and Hotfixes for CyberPunk',
	__URL		 = 'https://github.com/sammilucia/cyberpunk-ultra-plus',
	__LICENSE	 = [[
	MIT No Attribution

	Copyright 2024 SammiLucia, Xerme, FireKahuna, WoaDmulL

	Permission is hereby granted, free of charge, to any person obtaining a copy of this
	software and associated documentation files (the "Software"), to deal in the Software
	without restriction, including without limitation the rights to use, copy, modify,
	merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}
local logger = require("logger")
local options = require("options")
local var = require("variables")
local ui = require("ui")
local config = {
	SetMode = require("setmode").SetMode,
	SetQuality = require("setquality").SetQuality,
	SetSceneScale = require("setscenescale").SetSceneScale,
	SetDLSS = require("setdlss").SetDLSS,
	SetVram = require("setvram").SetVram,
	AutoScale = require("perceptualautoscale").AutoScale,
	SetDaytime = require("daytimetasks").SetDaytime,
	DEBUG = false,
	PTNextActivated = false,
	WindowOpen = false,
	PreviousWeather = nil,
}
local stats = {
	fps = 0,
}
local timer = {
	lazy = 0,
	fast = 0,
	weather = 0,
	paused = false,
	FAST = 1.0,
	LAZY = 10.0,
	WEATHER = 910,		  -- 15:10 hours
}

local Detector = { isGameActive = false }
function Detector.UpdateGameStatus()
	-- check if in-game or not
	local player = Game.GetPlayer()
	local isInMenu = GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():IsPreGame()

	Detector.isGameActive = player and not isInMenu
end

function Debug(...)
	if not config.DEBUG then return end
	print("DEBUG:", table.concat(arg, " "))
end

local activeTimers = {}
function Wait(seconds, callback)
	-- non-blocking wait
	table.insert(activeTimers, { countdown = seconds, callback = callback })
end

function PushChanges()
	-- confirm menu changes and save UserSettings.json to try to prevent it getting out of sync
	-- currently crashes CP 2.0+ and idk why
	GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():RequestSaveUserSettings()

	if Game.GetSettingsSystem():NeedsConfirmation() then
		logger.info("> Confirming settings change to Cyberpunk")
		Game.GetSettingsSystem():ConfirmChanges()
	end
end

function SplitOption(string)
	-- splits an ini/CVar command into its constituents
	local category, item = string.match(string, "(.-)/([^/]+)$")

	return category, item
end

function GetOption(category, item)
	-- gets a live game setting
	if category == "internal" then
		if var.settings[item] == true then
			return true
		end

		return false
	end

	if string.sub(category, 1, 1) == "/" then
		return Game.GetSettingsSystem():GetVar(category, item):GetValue()
	end

	local value = GameOptions.Get(category, item)
	if tostring(value) == "true" then
		return true
	end

	if tostring(value) == "false" then
		return false
	end

	if tostring(value):match("^%-?%d+%.%d+$") then
		return tonumber(value)
	end

	if tostring(value):match("^%-?%d+$") then
		return tonumber(value)
	end

	logger.info("ERROR: Getting value for:", category, item..". Result returned:", value)
end

function SetOption(category, item, value, valueType)
	-- sets a live game setting, working out which method to use for different setting types
	if value == nil then
		logger.info("ERROR: Skipping nil value:", category .. "/" .. item)
		return
	end

	if category == "internal" then
		var.settings[item] = value
		return
	end

	if string.sub(category, 1, 1) == "/" then
		Game.GetSettingsSystem():GetVar(category, item):SetValue(value)
		return
	end
	
	if type(value) == "boolean" then
		GameOptions.SetBool(category, item, value)
		return
	end
	
	if tostring(value) == "false" or tostring(value) == "true" then
		GameOptions.SetBool(category, item, tostring(value) == "true")
		return
	end

	if tostring(value):match("^%-?%d+%.%d+$") or valueType == "float" then
		GameOptions.SetFloat(category, item, tonumber(value))
		return
	end

	if tostring(value):match("^%-?%d+$") then
		GameOptions.SetInt(category, item, tonumber(value))
		return
	end

	logger.info("ERROR: Unsupported GameOption:", category .. "/" .. item, "=", value)
end

function LoadIni(path)
	-- pushes an ini file into live game settings
	local iniData = {}
	local category

	local file = io.open(path, "r")
	if not file then
		logger.info("Failed to open file:", path)
		return
	end

	logger.info("	(Loading", path..")")
	for line in file:lines() do
		line = line:match("^%s*(.-)%s*$") -- trim whitespace

		if line == "" or string.sub(line, 1, 1) == ";" then
			goto continue
		end

		local currentCategory = line:match("%[(.+)%]") -- match category lines
		if currentCategory then
			category = currentCategory
			iniData[category] = iniData[category] or {}
			goto continue
		end

		local item, value = line:match("([^=]+)%s*=%s*([^;]+)") -- match items and values, ignore comments
		if item and value then
			item = item:match("^%s*(.-)%s*$")
			value = value:match("^%s*(.-)%s*$")
			iniData[category][item] = value
			local success, err = pcall(SetOption, category, item, value)
			if not success then
				logger.info("SetOption failed:", err)
			end
		end

		::continue::
	end
	file:close()
end

function LoadSettings()
	-- get game's live settings, then replace with config.json settings (if they exist and are valid)
	local settingsTable = {}
	local settingsCategories = {
		options.Tweaks,
		options.Features,
	}

	for _, category in pairs(settingsCategories) do
		for _, setting in ipairs(category) do
			local currentValue = GetOption(setting.category, setting.item)
			settingsTable[setting.item] = { category = setting.category, value = currentValue }
		end
	end

	local file = io.open("config.json", "r")
	if not file then
		return
	end

	local rawJson = file:read("*a")
	file:close()

	local success, result = pcall(json.decode, rawJson)

	if not success or not result.UltraPlus then
		logger.info("Could not read config.json:", result)
		return
	end

	logger.info("Loading user settings...")
	for item, value in pairs(result.UltraPlus) do
		if settingsTable[item] and not string.match(item, "^internal") then
			settingsTable[item].value = value
		elseif string.match(item, "^internal") then
			local key = string.match(item, "^internal%.(%w+)$")
			if key then
				logger.info("    Found user config", key..":", value)
				var.settings[key] = value
			end
		end
	end

	for item, setting in pairs(settingsTable) do
		SetOption(setting.category, item, setting.value)
	end
end

function SaveSettings()
	-- save Ultra+ settings to config.json
	local UltraPlus = {}
	local settingsCategories = {
		options.Tweaks,
		options.Features,
	}

	for _, currentCategory in pairs(settingsCategories) do
		for _, currentSetting in pairs(currentCategory) do
			UltraPlus[currentSetting.item] = GetOption(currentSetting.category, currentSetting.item)
		end
	end

	UltraPlus["internal.mode"] = var.settings.mode
	UltraPlus["internal.quality"] = var.settings.quality
	UltraPlus["internal.sceneScale"] = var.settings.sceneScale
	UltraPlus["internal.vram"] = var.settings.vram
	UltraPlus["internal.nsgddCompatible"] = var.settings.nsgddCompatible
	UltraPlus["internal.enableTargetFps"] = var.settings.enableTargetFps
	UltraPlus["internal.targetFps"] = var.settings.targetFps
	UltraPlus["internal.enableConsole"] = var.settings.enableConsole

	local settingsTable = { UltraPlus = UltraPlus }

	local success, result = pcall(json.encode, settingsTable)
	if not success then
		logger.info("Error saving config.json:", result)
		return
	end

	local rawJson = result
	local file = io.open("config.json", "w")
	if not file then
		logger.info("Error opening config.json for writing")
		return
	end
	file:write(rawJson)
	file:close()
end

function ForceDlssd()
	local testDlssd = GetOption('/graphics/presets', 'DLSS_D')

	while testDlssd == false do
		Debug("/graphics/presets/DLSS_D =", testDlssd)

		SetOption("/graphics/presets", "DLSS_D", true)

		Wait(1.0, function()
			testDlssd = GetOption('/graphics/presets', 'DLSS_D')
		end)
	end

	PushChanges()

	SetOption("RayTracing", "EnableNRD", false)
	SaveSettings()
end

function ResetEngine()
	logger.info("Reloading REDengine")
	GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():RequestSaveUserSettings()
end

function PreparePTNext()
	-- if not in PTNext mode, always disable ReGIR
	-- otherwise disable PTNext in preparation for loading
	if var.settings.mode ~= var.mode.PTNEXT then
		SetOption("Editor/ReGIR", "UseForDI", false)
		SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
		
		logger.info("    PTNext is not in use")
		config.PTNextActivated = false
		return
	end

	SetOption("Editor/ReGIR", "UseForDI", false)
	SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)

	logger.info("    PTNext is ready to load")
	config.PTNextActivated = false
	return
end

function EnablePTNext()
	if var.settings.mode ~= var.mode.PTNEXT then
		return
	end

	Wait(1.5, function()
		SetOption("Editor/ReGIR", "UseForDI", true)

		local usingNRD = GetOption("RayTracing", "EnableNRD")
		if not usingNRD then
			logger.info("    (RR is in use)")
			-- if we can work out why local lights/vegetation need separate denoiser info
			-- Dogtown we can remove this!! it looks horrible and only needed in Dogtown
			SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
		else
			logger.info("    (NRD is in use)")
		end
	end)

	config.PTNextActivated = true
	logger.info("    PTNext is active")
end

function DoRainFix()
	-- enable particle PT integration unless player is outdoors AND it's raining
	if var.settings.indoors or not var.settings.rain then
		logger.info("    (It's not raining: Enabling separate particle colour)")
		SetOption("Rendering", "DLSSDSeparateParticleColor", true)
		return
	end

	logger.info("    (It's raining: Disabling separate particle colour)")
	SetOption("Rendering", "DLSSDSeparateParticleColor", false)
end

function DoRRFix()
	-- while RR is enabled, continually disable NRD to work around CP FPS slowdown bug entering vehicles or cutscenes
	timer.paused = true
	if not GetOption("/graphics/presets", "DLSS_D") then
		return
	end

	Debug("Disabling NRD")
	SetOption("RayTracing", "EnableNRD", false)
	timer.paused = false
end

function GetGameHour()
    return Game.GetTimeSystem():GetGameTime():Hours()
end

function GetCurrentWeather()
    return Game.GetWeatherSystem():GetWeatherState().name
end

function BumpWeather()
    local weatherTypes = {"clear", "cloudy", "rain", "fog"}
    local randomWeather = weatherTypes[math.random(#weatherTypes)]
    Game.GetWeatherSystem():RequestNewWeather(randomWeather)
    logger.info("Changed weather to:", randomWeather)
end

function DoRefreshEngine()
	-- hack to force the engine to warm reload
	if var.settings.mode ~= var.mode.PTNEXT then
		return
	end

	logger.info("Refreshing Engine...")
	SetOption("Editor/ReGIR", "UseForDI", false)
	Wait(0.5, function()
		SetOption("Editor/ReGIR", "UseForDI", true)
		logger.info("Done")
	end)
end

function DoGameSessionStarted()
	-- do at game launch or start of loading a savegame
	if timer.paused then
		logger.info("    [Game started]")
		logger.info("    (Unpausing background functions)")
		timer.paused = false
	end

	config.SetDaytime(GetGameHour())

	PreparePTNext()
end

function DoGameSessionEnding()
	-- do at game session end or exiting to main menu
	logger.info("...")
	logger.info("[Game session ending]")
	logger.info("    (Pausing background functions)")
	timer.paused = true
	config.PTNextActivated = false
	stats.fps = 0

	InitUltraPlus()
end

function DoFastUpdate()
	-- runs every timer.FAST seconds
	DoRRFix()

	local testRain = Game.GetWeatherSystem():GetRainIntensity() > 0 and true or false
	local testIndoors = IsEntityInInteriorArea(GetPlayer())

	if testRain ~= var.settings.rain or testIndoors ~= var.settings.indoors then
		DoRainFix()
		var.settings.rain = testRain
		var.settings.indoors = testIndoors
	end

	if not config.PTNextActivated then
		EnablePTNext()
	end
end

function DoLazyUpdate()
	-- runs every timer.LAZY seconds

	-- begin time of day logic:
	config.SetDaytime(GetGameHour())

	-- begin targetFps logic:
	if not var.settings.enableTargetFps
	or var.settings.mode == var.mode.RTOnly then
		return
	end

	if stats.fps < var.settings.targetFps then
		if var.settings.autoScale > 1 then
			var.settings.autoScale = var.settings.autoScale - 1
			config.AutoScale(var.settings.autoScale)
		end
	else
		if var.settings.autoScale < 6 then
			var.settings.autoScale = var.settings.autoScale + 1
			config.AutoScale(var.settings.autoScale)
		end
	end
end

function DoWeatherUpdate()
	-- if the weather is stuck, change it
    local currentWeather = GetCurrentWeather()
    if currentWeather == config.PreviousWeather then
        config.BumpWeather(currentWeather)
    end
    config.PreviousWeather = currentWeather
end

--[[ this method crashes CP
function forcePTDenoiser()
	if GetOption("Developer/FeatureToggles", "DLSSD") then
		logger.info("Enabling RR, disabling NRD")
		SetOption("Developer/FeatureToggles", "DLSSD", true)
		SetOption("RayTracing", "EnableNRD", false)
		SetOption("/graphics/presets", "DLSS_D", true)
		--PushChanges()
	else
		logger.info("Enabling NRD, disabling RR")
		SetOption("/graphics/presets", "DLSS_D", false)
		SetOption("Developer/FeatureToggles", "DLSSD", false)
		SetOption("RayTracing", "EnableNRD", true)
		--PushChanges()
	end
end
]]

registerForEvent('onUpdate', function(delta)
	-- handle non-blocking background tasks
	Detector.UpdateGameStatus()

	if timer.paused or not Detector.isGameActive then
		return
	end

	timer.fast = timer.fast + delta
	timer.lazy = timer.lazy + delta
	timer.weather = timer.weather + delta

	stats.fps = (stats.fps * 9 + (1 / delta)) / 10

	if timer.fast > timer.FAST then
		DoFastUpdate()
		timer.fast = 0
	end

	if timer.lazy > timer.LAZY then
		DoLazyUpdate()
		timer.lazy = 0
	end

	if timer.weather > timer.WEATHER then
		DoWeatherUpdate()
		timer.weather = 0
	end

	for i = #activeTimers, 1, -1 do
		local tempTimer = activeTimers[i]
		tempTimer.countdown = tempTimer.countdown - delta

		if tempTimer.countdown < 0 then
			tempTimer.callback()
			table.remove(activeTimers, i)
		end
	end
end)

function InitUltraPlus()
	logger.info("Initializing...")
	LoadIni("config_common.ini")
	LoadSettings()

	config.SetMode(var.settings.mode)
	config.SetQuality(var.settings.quality)
	config.SetSceneScale(var.settings.sceneScale)
	config.SetVram(var.settings.vram)

	PreparePTNext()
end

registerForEvent("onTweak", function()
	-- load as early as possible to prevent crashes
	LoadIni("config_common.ini")
end)

registerForEvent("onInit", function()
	local file = io.open("debug", "r")
	if file then
		config.DEBUG = true
		logger.info("Enabling debug output")
	end

	ObserveAfter('QuestTrackerGameController', 'OnInitialize', function()
		logger.info("[Entered game]")
		DoGameSessionStarted()
	end)

	Observe('QuestTrackerGameController', 'OnUninitialize', function()
		DoGameSessionEnding()
	end)

	Observe("CCTVCamera", "TakeControl", function(this, val)
		logger.info(string.format("	(Camera control: %s %s)", this, val))
	end)

	ObserveAfter("CCTVCamera", "TakeControl", function(this, val)
		logger.info(string.format("	(Camera control end: %s %s)", this, val))
	end)

	InitUltraPlus()
end)

registerForEvent("onOverlayOpen", function()
	config.WindowOpen = true
end)

registerForEvent("onOverlayClose", function()
	config.WindowOpen = false
end)

registerForEvent("onDraw", function()
	if not config.WindowOpen then
		return
	end

	ui.renderUI(stats.fps)
end)
