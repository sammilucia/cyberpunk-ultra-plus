UltraPlus = {
	__VERSION	 = '5.0.2',
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
local logger = require("helpers/logger")
local var = require("helpers/variables")
local config = require("helpers/config")
local options = require("helpers/options")
local render = require("render")
-- local bumpweather = require("helpers/bumpweather") -- needs actual calling
local gameSession = {
	active = false,
	time = nil,
	lastTime = nil,
	fastTravel = false,
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
	LAZY = 5.0,
	WEATHER = 910,		-- 15:10 hours
}

print("Modules loaded in init.lua. Config:", config, "Render:", render, "Var:", var)


function toboolean(value)
	if value == "true" or value == true then
		return true
	elseif value == "false" or value == false then
		return false
	else
		return nil
	end
end

function IsGameSessionActive()
	-- check if the game is active or not
	local time = Game.GetPlaythroughTime():ToFloat()

	if time ~= gameSession.lastTime and gameSession.active and not gameSession.fastTravel then
		timer.paused = false
	elseif time == gameSession.lastTime or not gameSession.active or gameSession.fastTravel then
		config.ptNext.active = false
		config.ptNext.primed = false
		timer.paused = true
	end

	gameSession.lastTime = time
end

local activeTimers = {}
function Wait(seconds, callback)
	-- non-blocking wait
	table.insert(activeTimers, { countdown = seconds, callback = callback })
end

function ConfirmChanges()
	-- confirm menu changes and save UserSettings.json to try to prevent it getting out of sync
	GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():RequestSaveUserSettings()

	if Game.GetSettingsSystem():NeedsConfirmation() then
		logger.info("> Confirming settings change to Cyberpunk")
		Game.GetSettingsSystem():ConfirmChanges()
		config.changed = false
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

	logger.info("ERROR: Error getting value for:", category .. "/" .. item, "=", value)
end

function SetOption(category, item, value, valueType)
	-- sets a live game setting, working out which method to use for different setting types
	if value == nil then
		logger.info("ERROR: Skipping nil value:", category .. "/" .. item, "=", value)
		return
	end

	if category == "internal" then
		var.settings[item] = value
		return
	end

	if string.sub(category, 1, 1) == "/" and (tostring(value) == "true" or tostring(value) == "false") then
		if GetOption(category, item) ~= value then
			Game.GetSettingsSystem():GetVar(category, item):SetValue(toboolean(value))
			config.changed = true
		end
		return
	end

	if string.sub(category, 1, 1) == "/" and tostring(value):match("^%-?%d+$") then
		Game.GetSettingsSystem():GetVar(category, item):SetIndex(tonumber(value))
		config.changed = true
		return
	end

	if type(value) == "boolean" or tostring(value) == "false" or tostring(value) == "true" then
		if GetOption(category, item) ~= value then
			GameOptions.SetBool(category, item, toboolean(value))
		end
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

	logger.info("ERROR: Couldn't set value for:", category .. "/" .. item, "=", value)
end

function LoadIni(config)
	-- pushes an ini file into live game settings
	local iniData = {}
	local category

	local path = "config/" .. config .. ".ini"
	local file = io.open(path, "r")
	if not file then
		logger.info("Failed to open file:", path)
		return
	end

	logger.info("	(Loading", path .. ")")
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
			local success, result = pcall(SetOption, category, item, value)
			if not success then
				logger.info("SetOption failed:", result)
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
		options.tweaks,
		options.ptFeatures,
		options.rasterFeatures,
		options.postProcessFeatures,
		options.miscFeatures,
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
		options.tweaks,
		options.ptFeatures,
		options.rasterFeatures,
		options.postProcessFeatures,
		options.miscFeatures,
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
	UltraPlus["internal.graphics"] = var.settings.graphics
	UltraPlus["internal.nsgddCompatible"] = var.settings.nsgddCompatible
	UltraPlus["internal.rayReconstruction"] = var.settings.rayReconstruction
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

function ToggleDlss(state)
	if state then
		local testDlssd = GetOption("/graphics/presets", "DLSS_D")
		while not testDlssd do
			SetOption("/graphics/presets", "DLSS_D", true)

		Wait(0.5, function()
			testDlssd = GetOption("/graphics/presets", "DLSS_D")
		end)
	end

	if not state then
		SetOption("/graphics/presets", "DLSS_D", false)
		-- SetOption("RayTracing", "EnableNRD", true)
		return
	end
	config.changed = true
end

function PreparePTNext()
	-- if not in PTNext mode, always disable ReGIR
	-- otherwise disable PTNext in preparation for loading
	if config.ptNext.primed or var.settings.mode ~= var.mode.PTNEXT then
		return
	end

	if var.settings.mode ~= var.mode.PTNEXT then
		SetOption("Editor/ReGIR", "UseForDI", false)
		SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)

		logger.info("    PTNext is not in use")
		config.ptNext.active = false
		return
	end

	SetOption("Editor/ReGIR", "UseForDI", false)
	SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)

	logger.info("    PTNext is ready to load")
	config.status = "PTNext is ready to load"
	config.ptNext.primed = true
	config.ptNext.active = false
end

function EnablePTNext()
	if config.ptNext.active or var.settings.mode ~= var.mode.PTNEXT then
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

	config.ptNext.active = true
	logger.info("    PTNext is active")
	config.status = "PTNext is active"
end

function DoRainFix()
	-- enable particle PT integration unless player is outdoors AND it's raining
	if var.settings.rain and not var.settings.indoors then
		logger.info("    (It's raining: Enabling separate particle colour)")
		SetOption("Rendering", "DLSSDSeparateParticleColor", true)
	else
		logger.info("    (It's not raining: Disabling separate particle colour)")
		SetOption("Rendering", "DLSSDSeparateParticleColor", false)
	end
end

function DoRRFix()
	-- while RR is enabled, continually disable NRD to work around CP FPS slowdown bug entering
	-- vehicles or cutscenes. also controls EnableGradients which doesn't work with NRD
	timer.paused = true
	if not GetOption("/graphics/presets", "DLSS_D") then
		SetOption("Editor/RTXDI", "EnableGradients", false)
		SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AntiFirefly", true)
		return
	end

	SetOption("RayTracing", "EnableNRD", false)
	SetOption("Editor/RTXDI", "EnableGradients", true)
	SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AntiFirefly", false)
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

function DoRefreshReGir()
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

function DoFastUpdate()
	-- runs every timer.FAST seconds
	IsGameSessionActive()

	if var.settings.rayReconstruction and SetOption("/graphics/presets", "DLSS_D", false) then
		print(var.settings.rayReconstruction)
		EnableDlssd(true)
	end

	if not var.settings.rayReconstruction and SetOption("/graphics/presets", "DLSS_D", true) then
		print(var.settings.rayReconstruction)
		EnableDlssd(false)
	end

	if config.status == "" then
		config.status = "Ready."
		ConfirmChanges()
	end

	if timer.paused then
		PreparePTNext()
		return
	end
	elseif config.ptNext.primed then
		config.status = "PTNext is ready to load"
	else
		config.status = "Ready."
	end

	EnablePTNext()
	DoRRFix()

	local testRain = Game.GetWeatherSystem():GetRainIntensity() > 0 and true or false
	local testIndoors = IsEntityInInteriorArea(GetPlayer())

	if testRain ~= var.settings.rain or testIndoors ~= var.settings.indoors then
		var.settings.rain = testRain
		var.settings.indoors = testIndoors
		DoRainFix()
	end
end

function DoLazyUpdate()
	-- runs every timer.LAZY seconds
	if timer.paused then
		return
	end

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
	if timer.paused then
		return
	end

	-- if the weather is stuck, change it
	local currentWeather = GetCurrentWeather()
	if currentWeather == config.PreviousWeather then
		config.BumpWeather(currentWeather)
	end
	config.PreviousWeather = currentWeather
end

registerForEvent('onUpdate', function(delta)
	-- handle non-blocking background tasks
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
	LoadIni("common")
	LoadSettings()

	config.SetGraphics(var.settings.graphics)
	config.SetMode(var.settings.mode)
	config.SetQuality(var.settings.quality)
	config.SetSceneScale(var.settings.sceneScale)
	config.SetVram(var.settings.vram)

	ToggleDlss(var.settings.rayReconstruction)

	PreparePTNext()
end

registerForEvent("onTweak", function()
	-- load as early as possible to prevent crashes
	LoadIni("common")
end)

registerForEvent("onInit", function()

	Observe('QuestTrackerGameController', 'OnUninitialize', function()
		gameSession.active = false
	end)

	ObserveAfter('QuestTrackerGameController', 'OnInitialize', function()
		gameSession.active = true
	end)

	Observe('FastTravelSystem', 'OnUpdateFastTravelPointRecordRequest', function()
		gameSession.fastTravel = true
	end)

	Observe('FastTravelSystem', 'OnPerformFastTravelRequest', function()
		gameSession.fastTravel = true
	end)

	Observe('FastTravelSystem', 'OnLoadingScreenFinished', function(_, finished)
		if finished then
			gameSession.fastTravel = false
		end
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
	var.window.open = true
end)

registerForEvent("onOverlayClose", function()
	var.window.open = false
end)

registerForEvent("onDraw", function()
	if not var.window.open then
		return
	end

	render.renderUI(stats.fps, var.window.open)
end)
