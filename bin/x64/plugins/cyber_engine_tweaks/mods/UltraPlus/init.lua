UltraPlus = {
	__VERSION	 = '6.4.6-beta',
	__DESCRIPTION = 'Better Path Tracing, Ray Tracing and Hotfixes for CyberPunk',
	__URL		 = 'https://github.com/sammilucia/cyberpunk-ultra-plus',
	__LICENSE	 = [[
	MIT No Attribution

	Copyright 2024 SammiLucia, FireKahuna, robber804, Lazorr, WoaDmulL, Xerme

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
Config = require('helpers/config')
Cyberpunk = require('helpers/Cyberpunk')
GameSession = require('helpers/psiberx/GameSession')
GameUI = require('helpers/psiberx/GameUI')
Cron = require('helpers/psiberx/Cron')
Stats = {
	fps = 0,
}
local UltraPlusFlag = "UltraPlus.Initialized"
local options = require('helpers/options')
local render = require('render')

local timer = {
	paused = true,
	flash = false,
}

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
	for _, settings in pairs(iniData) do
		for item, value in pairs(settings) do
			if value == 'true' or value == 'false' then
				value = value == 'true'
			end
			Logger.info('    config', item .. ':', value)
			if settingsTable[item] and not string.match(item, '^internal') then
				settingsTable[item].value = value
			elseif string.match(item, '^internal') then
				local key = string.match(item, '^internal%.(%w+)$')
				if key then
					Logger.info('    Found user config', key .. ':', value)
					Var.settings[key] = value
				end
			end
		end
	end

	for item, setting in pairs(settingsTable) do
		Cyberpunk.SetOption(setting.category, item, setting.value)
	end

	if Var.settings.mode == Var.mode.PTNEXT then
		Cyberpunk.SetOption('RayTracing/Reference', 'EnableRIS', true)
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
	UltraPlus['internal.graphicsMenuOverrides'] = Var.settings.graphicsMenuOverrides
	UltraPlus['internal.rayReconstruction'] = Var.settings.rayReconstruction
	UltraPlus['internal.stableFps'] = Var.settings.stableFps
	UltraPlus['internal.stableFpsTarget'] = Var.settings.stableFpsTarget
	UltraPlus['internal.console'] = Var.settings.console
	UltraPlus['internal.hairAdjustments'] = Var.settings.hairAdjustments
	UltraPlus['internal.preemHair'] = Var.settings.preemHair
	UltraPlus['internal.ptLightingAdjustments'] = Var.settings.ptLightingAdjustments
	UltraPlus['internal.weatherFix'] = Var.settings.weatherFix

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

local function resetPTNext()
	if Var.settings.mode ~= Var.mode.PTNEXT then
		return
	end

	Cron.After(1.5, function()
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cron.After(0.5, function()
			Cyberpunk.SetOption('Editor/ReGIR', 'Enable', true)
			Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', true)
		end)
	end)

	Logger.info('    PTNext RESET')
end

local function enablePTNext()
	if Var.settings.mode ~= Var.mode.PTNEXT then
		return
	end

	Config.SetQuality(Var.settings.quality)

	resetPTNext()

	Logger.info('    PTNext is active')
end

local function doMiscFixes()
	if Cyberpunk.GetOption('RayTracing', 'TransparentReflectionEnvironmentBlendFactor') == 1.0 then
		Cyberpunk.SetOption('RayTracing', 'TransparentReflectionEnvironmentBlendFactor', '0.06')
	end
	
	if Cyberpunk.GetOption('Visuals', 'MotionBlurScale') == 1.0 then
		Cyberpunk.SetOption('Visuals', 'MotionBlurScale', '0.6')
	end 
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
		Cyberpunk.SetOption('/graphics/presets', 'DLSS_D', false, 'boolean', true)
	end

	if not Cyberpunk.GetOption('/graphics/presets', 'DLSS_D') then
		-- Cyberpunk.SetOption('Editor/RTXDI', 'EnableGradients', false) -- needs testing with NRD again
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', true, 'boolean', true)
		return
	end

	Cyberpunk.SetOption('RayTracing', 'EnableNRD', false, 'boolean', true)
	-- Cyberpunk.SetOption('Editor/RTXDI', 'EnableGradients', true) -- needs testing with NRD again
	Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', false, 'boolean', true)
end

local function doWindowClose()
	-- run tasks just after CET window is closed
	-- delay needed to avoid CTDs due to long-standing CET bug
end

local function setStatus()
	if Cyberpunk.NeedsConfirmation() then
		if timer.flash then
			Config.Status = 'Open the Graphics Menu and click \'Apply\'...'
		else
			Config.Status = ''
		end
	elseif Var.settings.modeChanged then
		if timer.flash then
			Config.Status = 'Load a save game to fully activate ' .. Var.settings.mode
		else
			Config.Status = ''
		end
	else
		Config.Status = 'Let\'s delta'
	end
end

local function doWeatherUpdate()
	if timer.paused then
		return
	end

	-- if the weather is stuck, change it
	local currentWeather = Cyberpunk.GetWeather()
	if currentWeather == Var.settings.previousWeather then
		Config.BumpWeather(currentWeather)
	end

	Var.settings.previousWeather = currentWeather
end

registerForEvent('onUpdate', function(delta)
	Cron.Update(delta)

	Stats.fps = (Stats.fps * 9 + (1 / delta)) / 10
end)

function DoHairAdjustments()
	if Var.settings.hairAdjustments and Var.settings.preemHair then
		Logger.info('Enabling PT hair adjustments for Preem Hair')
		LoadIni('config/hair_on-preem.ini', true)
	elseif Var.settings.hairAdjustments and not Var.settings.preemHair then
		Logger.info('Enabling PT hair adjustments for vanilla hair')
		LoadIni('config/hair_on.ini', true)
	else
		Logger.info('Disabling PT hair adjustments')
		LoadIni('config/hair_off.ini', true)
	end
end

local function preparePtNext()
	if Var.settings.mode ~= Var.mode.PTNEXT then
		return
	end

	-- delay full activation of PTNext so it loads correctly because it's not exposed in the shipped game
	-- only seems to build shaders correctly with ShadingCandidatesCount == 4, but increasing these later seems to work
	Config.SetMode(Var.settings.mode)
	Config.SetQuality(Var.settings.quality)

	Cyberpunk.SetOption('Editor/ReGIR', 'BuildCandidatesCount', '8')
	Cyberpunk.SetOption('Editor/ReGIR', 'ShadingCandidatesCount', '4')
	Cyberpunk.SetOption('Editor/ReGIR', 'LightSlotsCount', '128')
	Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', true)
end

local function initUltraPlus()
	if isUltraPlusInitialized() then
		Logger.info('    (CET reload detected)')
		Logger.info('Reinitializing...')
	else
		Logger.info('Initializing...')
	end

	Logger.debug('Debug mode enabled')

	LoadIni('config/common.ini', true)
	LoadConfig()

	Logger.info('Enforcing user settings...')
	Config.SetGraphics(Var.settings.graphicsMenuOverrides)
	Config.SetMode(Var.settings.mode)
	Config.SetQuality(Var.settings.quality)
	Config.SetSceneScale(Var.settings.sceneScale)
	Config.SetVram(Var.settings.vram)

	LoadIni(Var.settings.ptLightingAdjustments and 'config/ptlighting_on.ini' or 'config/ptlighting_off.ini', true)
	DoHairAdjustments()
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

		resetPTNext()
	end)

	GameSession.OnLoad(function(state)
		Logger.info("LOAD")

		preparePtNext()
	end)

	GameUI.OnFastTravelStart(function()
		Logger.info("Fast Travel Start")

		preparePtNext()
	end)

	GameUI.OnFastTravelFinish(function()
		Logger.info("Fast Travel Finish")

		enablePTNext()
	end)

	local firstStart = true
	GameSession.OnStart(function(state)
		Logger.info("START")
		timer.paused = false

		if firstStart then
			firstStart = false
			Var.settings.previousWeather = Cyberpunk.GetWeather()
			Var.settings.sameWeatherSeconds = 0
		end

		Var.settings.modeChanged = false

		enablePTNext()
	end)

	Cron.Every(30.0, function()
		if timer.paused then
			return
		end

		local weather = Cyberpunk.GetWeather()
		if weather == Var.settings.previousWeather then
			Var.settings.sameWeatherSeconds = Var.settings.sameWeatherSeconds + 30

			if Var.settings.weatherFix and Var.settings.sameWeatherSeconds > 910 then
				Config.BumpWeather(weather)
			end
		else
			Var.settings.previousWeather = weather
			Var.settings.sameWeatherSeconds = 0
		end

		Logger.debug("Daytime task and weather")
		Config.SetDaytime(Cyberpunk.GetHour())
	end)

	Cron.Every(1.0, function()
		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableRIS', true)
		end
	end)

	Cron.Every(0.25, {tick = 0}, function(timerinfo)
		timerinfo.tick = (timerinfo.tick + 1) % 4

		if timerinfo.tick == 0 then
			timer.flash = not timer.flash
			setStatus()
		end

		if timer.paused then
			return
		end

		Logger.debug("RR fix")
		doRayReconstructionFix()
	end)

	Cron.Every(5.0, function() 
		if timer.paused then
			return
		end

		Logger.debug("Rain check")
		local testRain = Cyberpunk.IsRaining()
		local testIndoors = IsEntityInInteriorArea(GetPlayer())

		if testRain ~= Var.settings.rain or testIndoors ~= Var.settings.indoors then
			Var.settings.rain = testRain
			Var.settings.indoors = testIndoors
			doRainPathTracingFix()
		end

		-- stableFps system
		if not Var.settings.stableFps or Var.settings.mode == Var.mode.RTOnly then
			return
		end

		local percentageDifference = (Stats.fps - Var.settings.stableFpsTarget) / Var.settings.stableFpsTarget * 100
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
	end)

	initUltraPlus()
end)

registerForEvent('onTweak', function()
	-- called early during engine init
	LoadIni('config/common.ini', true)
	LoadIni('config/traffic.ini', true)
	doMiscFixes()
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
