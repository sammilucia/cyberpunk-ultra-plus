UltraPlus = {
	__VERSION	 = '5.4.4',
	__DESCRIPTION = 'Better Path Tracing, Ray Tracing and Hotfixes for CyberPunk',
	__URL		 = 'https://github.com/sammilucia/cyberpunk-ultra-plus',
	__LICENSE	 = [[
	MIT No Attribution

	Copyright 2024 SammiLucia, Xerme, FireKahuna, WoaDmulL

	Permission is hereby granted, free of charge, to any person obtaining a copy of this
	software and associated documentation files (the 'Software'), to deal in the Software
	without restriction, including without limitation the rights to use, copy, modify,
	merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so.

	THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = require('helpers/Config')
Cyberpunk = require('helpers/Cyberpunk')
GameSession = require('helpers/psiberx/GameSession')
Stats = {
	fps = 0,
}
local UltraPlusFlag = "UltraPlus.Initialized"
local options = require('helpers/options')
local render = require('render')
local mode = {
	changed = false,
	previousMode = '',
}
local timer = {
	lazy = 0,
	fast = 0,
	weather = 0,
	paused = false,
	FAST = 1.0,
	LAZY = 5.0,
	WEATHER = 910, -- 15:10 hours
	flash = false,
}

local function setUltraPlusInitialized(flag)
	TweakDB:SetFlat(UltraPlusFlag, flag)
end

local function isUltraPlusInitialized()
	local success, flag = pcall(TweakDB.GetFlat, UltraPlusFlag)
	if not success then
		return false
	end
	return flag
end

local activeTimers = {}
function Wait(seconds, callback)
	-- non-blocking wait
	table.insert(activeTimers, { countdown = seconds, callback = callback })
end

local function saveUserSettingsJson()
	-- instructs game to save settings to UserSettings.json
	if timer.paused then
		return
	end

	Var.confirmationRequired = false
	Logger.info('Cyberpunk successfully saved UserSettings.json')
end

local function confirmChanges()
	-- confirm graphics menu changes to Cyberpunk
	-- causes CTD due to long-standing CET bug
	if Var.ultraPlusActive and Cyberpunk.NeedsConfirmation() then
		Cyberpunk.Confirm()
	end
end

function LoadIni(config, set)
	-- pushes an ini file into live game settings
	local iniData = {}
	local category

	local file = io.open(config, 'r')
	if not file then
		Logger.info('Failed to open file:', config)
		return
	end

	Logger.info('	(Loading', config .. ')')
	for line in file:lines() do
		line = line:match('^%s*(.-)%s*$') -- trim whitespace

		if line == '' or string.sub(line, 1, 1) == ';' then
			goto continue
		end

		local currentCategory = line:match('%[(.+)%]') -- match category lines
		if currentCategory then
			category = currentCategory
			iniData[category] = iniData[category] or {}
			goto continue
		end

		local item, value = line:match('([^=]+)%s*=%s*([^;]+)') -- match items and values, ignore comments
		if item and value then
			item = item:match('^%s*(.-)%s*$')
			value = value:match('^%s*(.-)%s*$')
			iniData[category][item] = value
			if set then
				local success, result = pcall(Cyberpunk.SetOption, category, item, value)
				if not success then
					Logger.info('SetOption failed:', result)
				end
			end
		end

		::continue::
	end
	file:close()

	return iniData
end

function LoadConfig()
	-- get game's live settings, then replace with Var.configFile settings (if they exist and are valid)
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
			local currentValue = Cyberpunk.GetOption(setting.category, setting.item)
			settingsTable[setting.item] = { category = setting.category, value = currentValue }
		end
	end

	local iniData = LoadIni(Var.configFile)
	if not iniData then
		Logger.info('LoadIni() returned no data from', Var.configFile)
		return
	end

	Logger.info('Loading user settings...')
	for category, settings in pairs(iniData) do
		for item, value in pairs(settings) do
			if settingsTable[item] and not string.match(item, '^internal') then
				settingsTable[item].value = value
			elseif string.match(item, '^internal') then
				local key = string.match(item, '^internal%.(%w+)$')
				if key then
					Logger.info('    Found user config', key..':', value)
					Var.settings[key] = value
				end
			end
		end
	end
end

function SaveConfig()
	-- save UI states to Var.configFile
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
			UltraPlus[currentSetting.item] = Cyberpunk.GetOption(currentSetting.category, currentSetting.item)
		end
	end

	UltraPlus['internal.mode'] = Var.settings.mode
	UltraPlus['internal.quality'] = Var.settings.quality
	UltraPlus['internal.sceneScale'] = Var.settings.sceneScale
	UltraPlus['internal.vram'] = Var.settings.vram
	UltraPlus['internal.graphics'] = Var.settings.graphics
	UltraPlus['internal.rayReconstruction'] = Var.settings.rayReconstruction
	UltraPlus['internal.enableTargetFps'] = Var.settings.enableTargetFps
	UltraPlus['internal.targetFps'] = Var.settings.targetFps
	UltraPlus['internal.enableConsole'] = Var.settings.enableConsole
	UltraPlus['internal.enableTraffic'] = Var.settings.enableTraffic
	UltraPlus['internal.enableCrowds'] = Var.settings.enableCrowds

	local iniData = {}
	local iniContent = ""

	iniData["UltraPlus"] = UltraPlus
	for category, settings in pairs(iniData) do
		iniContent = iniContent .. "[" .. category .. "]\n"
		for item, value in pairs(settings) do
			iniContent = iniContent .. item .. " = " .. tostring(value) .. "\n"
		end
		iniContent = iniContent .. "\n"
	end

	local file = io.open(Var.configFile, 'w')
	if not file then
		Logger.info('Error opening', Var.configFile, 'for writing')
		return
	end

	file:write(iniContent)
	file:close()

	Logger.info('Saved', Var.configFile)
end

local function toggleRayReconstruction(state)
	while Cyberpunk.GetOption('/graphics/presets', 'DLSS_D') ~= state do
		Wait(1.0, function()
			Cyberpunk.SetOption('/graphics/presets', 'DLSS_D', state)
		end)
	end
end

local function preparePTNext()
	-- if not in PTNext mode, disable ReGIR
	-- if in PTNext mode, disable PTNext in preparation for loading
	if Config.ptNext.stage2 then
		return
	end

	if Var.settings.mode ~= Var.mode.PTNEXT then
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableSeparateDenoising', true)

		Logger.info('    PTNext is not in use')
		Config.ptNext.active = false
		return
	end

	Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)
	Cyberpunk.SetOption('Editor/RTXDI', 'EnableSeparateDenoising', false)

	Logger.info('    PTNext is ready to load')
	Config.ptNext.stage2 = true
	Config.ptNext.active = false
end

local function enablePTNext()
	if Config.ptNext.active or Var.settings.mode ~= Var.mode.PTNEXT then
		return
	end

	Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

	Wait(0.8, function()
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableSeparateDenoising', true)
	end)

	Wait(1.5, function()
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', true)
	end)

	Config.ptNext.active = true
	Logger.info('    PTNext is active')
end

local function doRainPathTracingFix()
	-- enable particle PT integration unless player is outdoors AND it's raining
	if Var.settings.rain and not Var.settings.indoors then
		Logger.info('    (It\'s raining: Enabling separate particle colour)')
		Cyberpunk.SetOption('Rendering', 'DLSSDSeparateParticleColor', true)
	else
		Logger.info('    (It\'s not raining: Disabling separate particle colour)')
		Cyberpunk.SetOption('Rendering', 'DLSSDSeparateParticleColor', false)
	end
end

local function doRayReconstructionFix()
	-- while RR is enabled, continually disable NRD to work around CP FPS slowdown bug entering
	-- vehicles or cutscenes. also controls EnableGradients which doesn't work with NRD
	if Var.settings.mode == Var.mode.PT16 then
		-- force RR off for PT16, don't rely on user to do it
		Cyberpunk.SetOption('/graphics/presets', 'DLSS_D', false)
	end

	if not Cyberpunk.GetOption('/graphics/presets', 'DLSS_D') then
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableGradients', false) -- needs testing with NRD again
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', true)
		return
	end

	Cyberpunk.SetOption('RayTracing', 'EnableNRD', false)
	Cyberpunk.SetOption('Editor/RTXDI', 'EnableGradients', true) -- needs testing with NRD again
	Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', false)
end

local function doWindowClose()
	-- run tasks just after CET window is closed
	-- delay needed to avoid CTDs due to long-standing CET bug
end

local function setStatus()
	if Cyberpunk.NeedsConfirmation() then
		if timer.flash then
			Config.status = 'Click \'Apply\' in game graphics menu'
		else
			Config.status = ''
		end
	elseif mode.changed then
		if timer.flash then
			Config.status = 'Load a save game to fully activate ' .. Var.settings.mode
		else
			Config.status = ''
		end
	else
		Config.status = 'Preem.'
	end
end

local function doFastUpdate()
	-- runs every timer.FAST seconds
	-- confirmChanges()
	timer.flash = not timer.flash

	if Var.settings.mode ~= mode.previousMode then
		mode.changed = true
	end

	mode.previousMode = Var.settings.mode

	setStatus()

	if Var.settings.mode == Var.mode.PTNEXT and not Config.ptNext.active and not Config.ptNext.stage1 then
		preparePTNext()
	end

	if not Cyberpunk.GetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode') then goto continue
		Config.NRD = Cyberpunk.GetOption('Raytracing', 'EnableNRD')
		Config.DLSSD = Cyberpunk.GetOption('/graphics/presets', 'DLSS_D')

		if Cyberpunk.PhotoMode() then
			Cyberpunk.SetOption('/graphics/presets', 'DLSS_D', false)
			Cyberpunk.SetOption('Raytracing', 'EnableNRD', false)
		else
			Cyberpunk.SetOption('Raytracing', 'EnableNRD', Config.NRD)
			Cyberpunk.SetOption('/graphics/presets', 'DLSS_D', Config.DLSSD)
		end
		::continue::
	end

	if timer.paused then
		return
	end

	enablePTNext()
	doRayReconstructionFix()

	local testRain = Cyberpunk.IsRaining()
	local testIndoors = IsEntityInInteriorArea(GetPlayer())

	if testRain ~= Var.settings.rain or testIndoors ~= Var.settings.indoors then
		Var.settings.rain = testRain
		Var.settings.indoors = testIndoors
		doRainPathTracingFix()
	end
end

local function doLazyUpdate()
	-- runs every timer.LAZY seconds
	if timer.paused then
		return
	end

	-- begin time of day logic:
	Config.SetDaytime(Cyberpunk.GetHour())

	-- begin targetFps logic:
	if not Var.settings.enableTargetFps or Var.settings.mode == Var.mode.RTOnly then
		return
	end

	local percentageDifference = (Stats.fps - Var.settings.targetFps) / Var.settings.targetFps * 100
	local scaleStep = math.floor(percentageDifference / 10)

	Var.settings.lastAutoScale = Var.settings.autoScale
	Var.settings.autoScale = Var.settings.autoScale + scaleStep
	if scaleStep == 0 then
		return
	end

	if Var.settings.autoScale > 6 then Var.settings.autoScale = 6 end
	if Var.settings.autoScale < 1 then Var.settings.autoScale = 1 end
	if Var.settings.autoScale == Var.settings.lastAutoScale then
		return
	end
	Config.AutoScale(Var.settings.autoScale)
end

local function doWeatherUpdate()
	if timer.paused then
		return
	end

	-- if the weather is stuck, change it
	local currentWeather = Cyberpunk.GetWeather()
	if currentWeather == Config.gameSession.previousWeather then
		Config.BumpWeather(currentWeather)
	end
	Config.gameSession.previousWeather = currentWeather
end

registerForEvent('onUpdate', function(delta)
	-- handle non-blocking background tasks
	timer.fast = timer.fast + delta
	timer.lazy = timer.lazy + delta
	timer.weather = timer.weather + delta

	Stats.fps = (Stats.fps * 9 + (1 / delta)) / 10

	if timer.fast > timer.FAST then
		doFastUpdate()
		timer.fast = 0
	end

	if timer.lazy > timer.LAZY then
		doLazyUpdate()
		timer.lazy = 0
	end

	if timer.weather > timer.WEATHER then
		doWeatherUpdate()
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

local function initUltraPlus()
	if isUltraPlusInitialized() then
		Logger.info('    (CET reload detected)')
		Logger.info('Reinitializing...')
	else
		Logger.info('Initializing...')
	end

	Logger.debug('Debug mode enabled')

	LoadIni('config/common.ini', true)
	LoadIni('config/traffic.ini', true)
	LoadConfig()

	Logger.info('Enforcing user settings...')
	Config.SetGraphics(Var.settings.graphics)
	Config.SetMode(Var.settings.mode)
	Config.SetQuality(Var.settings.quality)
	Config.SetSceneScale(Var.settings.sceneScale)
	Config.SetVram(Var.settings.vram)
	Config.SetPop(Var.settings.enableTraffic)
	Config.SetCars(Var.settings.enableTraffic)

	timer.fast = 0
	timer.lazy = 0
	timer.weather = 0

	-- preparePTNext()
end

registerForEvent('onInit', function()
	Logger.info("UltraPlus initializing")
	GameSession.Listen(function(state)
		GameSession.PrintState(state)
		timer.paused = GameSession.IsPaused()
		Logger.info('Listener set timer to paused: ', timer.paused)
	end)

	GameSession.OnResume(function(state)
		Logger.info("RESUME")
		timer.paused = false
	end)

	GameSession.OnStart(function(state)
		Logger.info("START")
		timer.paused = false

		mode.changed = false
        mode.previousMode = Var.settings.mode
	end)

	initUltraPlus()
end)

registerForEvent('onTweak', function()
	-- called early during engine init
	LoadIni('config/common.ini', true)
	LoadIni('config/traffic.ini', true)
end)

registerForEvent('onOverlayOpen', function()
	Var.window.open = true
end)

registerForEvent('onOverlayClose', function()
	Var.window.open = false
	doWindowClose()
end)

registerForEvent('onDraw', function()
	if not Var.window.open then
		return
	end

	render.renderUI(Stats.fps, Var.window.open)
end)
