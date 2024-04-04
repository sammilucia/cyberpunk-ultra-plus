local ultraplus = {
	__VERSION	 	= '4.0-alpha08',
	__DESCRIPTION	= 'Better Path Tracing, Ray Tracing and Stutter Hotfix for CyberPunk',
	__URL			= 'https://github.com/sammilucia/cyberpunk-ultra-plus',
	__LICENSE		= [[
	Copyright (c) 2024 SammiLucia and Xerme

	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}
local toggled
local options = require( "options" )
local var = require( "variables" )
local ui = require( "ui" )
local config = {
	SetSamples = require( "setsamples" ).SetSamples,
	SetMode = require( "setmode" ).SetMode,
	SetQuality = require( "setquality" ).SetQuality,
	SetStreaming = require( "setstreaming" ).SetStreaming,
	DEBUG = false,
	reGIR = false,
--	turboHack = false,
}
local activeTimers = {}
local timer = {
	lazy = 0,
	fast = 0,
	paused = false,
	LAZY = 20.0,
	FAST = 1.0,
}
local Detector = {
	isGameActive = false
}

function Detector.UpdateGameStatus()
	-- check if ingame or not
	local player = Game.GetPlayer()
	local isInMenu = GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():IsPreGame()

	if player and not isInMenu then
		if not Detector.isGameActive then
			Debug( "Player is in-game" )
			Detector.isGameActive = true
		end
	else
		if Detector.isGameActive then
			Debug( "Player is in menu" )
			Detector.isGameActive = false
		end
	end
end

function Debug( ... )
	if not config.DEBUG then return end

	local args = { ... }
	print( "DEBUG:", table.concat( args, " " ) )
end

function Wait( seconds, callback )
	-- non-blocking wait()
	table.insert( activeTimers, { countdown = seconds, callback = callback } )
end

function PushChanges()
	-- confirm menu changes and save UserSettings.json to try to prevent it getting out of sync
	-- currently crashes CP 2.0+ and idk why
	Wait( 1.0, function()
		GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():RequestSaveUserSettings()
	end )

	Wait( 1.0, function()
		Game.GetSettingsSystem():ConfirmChanges()
	end )
end

function SplitOption( string )
	-- splits an ini/CVar command into its constituents
	local category, item = string.match( string, "(.-)/([^/]+)$" )

	return category, item
end

function GetOption( category, item )
	-- gets a live game setting
	local value = nil

	if category == "internal" then
		value = var.settings[item]
		if value == nil then
			value = false
		end

	elseif category:match( "^/" ) then
		value = Game.GetSettingsSystem():GetVar( category, item ):GetValue()

	else
		value = GameOptions.Get( category, item )

		if value == "true" then
			value = true

		elseif value == "false" then
			value = false

		elseif string.match( value, "^%-?%d+$" ) then
			value = tonumber( value )
		end
	end

	return value
end

function SetOption( category, item, value )
	-- sets a live game setting, working out which method to use for different setting types
	if value == nil then
		Debug( "Skipping nil value:", category .. "/" .. item)
		return
	end

	if category == "internal" then
		var.settings[item] = value

	elseif category:match( "^/" ) then
		Game.GetSettingsSystem():GetVar( category, item ):SetValue( value )

	else
		if type( value ) == "boolean" then
			GameOptions.SetBool( category, item, value )

		elseif tostring(value):match( "^%-?%d+%.%d+$" ) then
			GameOptions.SetFloat( category, item, tonumber( value ) )

		elseif tostring(value):match( "^%-?%d+$" ) then
			GameOptions.SetInt( category, item, tonumber( value ) )

		else
			Debug( "Unsupported GameOption:", category .. "/" .. item, "=", value )
		end
	end
end

function GuessMode()
	-- tries to guess current rendering mode
	local guess = "Unknown"

	local proxyLightRejection = GetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection" )
	local nrdEnabled = GetOption( "Raytracing", "EnableNRD" )
	local reStir = GetOption( "Editor/ReSTIRGI", "Enable" )
	local pathTracing = GetOption( "/graphics/raytracing", "RayTracedPathTracing" )
	local rayTracing = GetOption( "/graphics/raytracing", "RayTracing" )

	if not rayTracing
	then
		guess = var.mode.RASTER

	elseif rayTracing and not pathTracing and not nrdEnabled then
		guess = var.mode.RT_ONLY

	elseif rayTracing and not pathTracing and nrdEnabled then
		guess = var.mode.RT_PT

	elseif pathTracing and proxyLightRejection and not reStir then
		guess = var.mode.PT20

	elseif pathTracing and proxyLightRejection and reStir then
		guess = var.mode.PT21

	elseif pathTracing and not proxyLightRejection and reStir then
		guess = var.mode.VANILLA
	end

	print( "---------- Ultra+: Guessed rendering mode is", guess )
	return guess
end

function GuessQuality()
	-- tries to guess current mode quality
	local guess = "Low"

	local initialBounces = GetOption( "RayTracing/Reference", "BounceNumber" )
	local initialRays = GetOption( "RayTracing/Reference", "RayNumber" )

	if initialBounces == 1 then
		guess = var.quality.LOW

	elseif initialBounces == 2 then
		guess = var.quality.MEDIUM

	elseif initialBounces == 2 and initialRays == 3 then
		guess = var.quality.HIGH

	elseif initialBounces == 3 then
		guess = var.quality.INSANE

	elseif initialBounces == 2 and initialRays == 2 then
		guess = var.quality.VANILLA

	end

	print( "---------- Ultra+: Guessed sample mode is", guess )
	return guess
end

function GuessSamples()
	-- tries to guess RTXDI samples
	local guess = "Medium"

	local initialSamples = GetOption( "Editor/RTXDI", "NumInitialSamples" )

	if initialSamples == 14 then
		guess = var.samples.LOW

	elseif initialSamples == 16 then
		guess = var.samples.MEDIUM

	elseif initialSamples == 20 then
		guess = var.samples.HIGH

	elseif initialSamples == 24 then
		guess = var.samples.INSANE

	elseif initialSamples == 8 then
		guess = var.samples.VANILLA

	end

	print( "---------- Ultra+: Guessed sample mode is", guess )
	return guess
end

function LoadIni( path )
    -- pushes an ini file into live game settings
    local iniData = {}
    local category

    local file = io.open( path, "r" )
    if not file then
        print( "---------- Ultra+: Failed to open file:", path )
        return
    end

    print( "---------- Ultra+: Loading common fixes..." )
    for line in file:lines() do
        line = line:match("^%s*(.-)%s*$") -- trim whitespace
        -- print("Line:", line) -- Debug print

        if line ~= "" and not line:match("^;") then

            local currentCategory = line:match("%[(.+)%]") -- check if line is a category
            if currentCategory then
                category = currentCategory
                iniData[category] = iniData[category] or {}

            else
                local item, value = line:match( "([^=]+)%s*=%s*([^;]+)" ) -- parse items and values, ignore comments
                if item and value then
                    item = item:match("^%s*(.-)%s*$")
                    value = value:match("^%s*(.-)%s*$")
                    iniData[category][item] = value
                    local success, err = pcall( SetOption, category, item, value )
                    if not success then
                        print( "---------- Ultra+: SetOption failed:", err )
                    end
                end
            end
        end
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

	for _, category in pairs( settingsCategories ) do
		for _, setting in ipairs( category ) do
			local currentValue = GetOption( setting.category, setting.item )
			settingsTable[setting.item] = { category = setting.category, value = currentValue }
		end
	end

	local file = io.open( "config.json", "r" )
	if file then
		local rawJson = file:read( "*a" )
		file:close()

		if not rawJson:match( "^%s*$" ) then
			local success, result = pcall( json.decode, rawJson )

            if success and result.UltraPlus then
            	for item, value in pairs( result.UltraPlus ) do

                    if settingsTable[item] and not string.match(item, "^internal") then
                        settingsTable[item].value = value

                    elseif string.match( item, "internal" ) then
						local key = string.match( item, "^internal%.(%w+)$" )
                        if key then
                            var.settings[key] = value
                        end
                    end
                end
            else
                print("---------- Ultra+: Error loading config.json:", result)
            end
        else
            print("---------- Ultra+: config.json is empty or invalid.")
        end
    end

	print( "---------- Ultra+: Loading user settings..." )
	for item, setting in pairs( settingsTable ) do
		SetOption( setting.category, item, setting.value )
	end
end

function SaveSettings()
	-- save Ultra+ settings to config.json
	local UltraPlus = {}
	local settingsCategories = {
		options.Tweaks,
		options.Features,
	}

	for _, currentCategory in pairs( settingsCategories ) do
		for _, currentSetting in pairs( currentCategory ) do
			UltraPlus[currentSetting.item] = currentSetting.value
		end
	end

	UltraPlus["internal.mode"] = var.settings.mode
	UltraPlus["internal.samples"] = var.settings.samples
	UltraPlus["internal.quality"] = var.settings.quality
	UltraPlus["internal.streaming"] = var.settings.streaming

	local settingsTable = { UltraPlus = UltraPlus }

	local success, result = pcall( json.encode, settingsTable )
	if not success then
		print( "---------- Ultra+: Error saving config.json:", result )
		return
	end

	local rawJson = result
	local file = io.open( "config.json", "w" )

	if file then
		file:write( rawJson )
		file:close()
	end
end

local function ForceDlssd()
	local testDlssd = GetOption( '/graphics/presets', 'DLSS_D' )

	while testDlssd == false do
		Debug( "/graphics/presets/DLSS_D =", testDlssd )

		SetOption( "/graphics/presets", "DLSS_D", true )

		Wait( 1.0, function()
			testDlssd = GetOption( '/graphics/presets', 'DLSS_D' )
		end )
	end

	PushChanges()

	SetOption( "RayTracing", "EnableNRD", false )
	SaveSettings()
end

function ResetEngine()
	print( "---------- Ultra+: Reloading REDengine" )
	GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():RequestSaveUserSettings()
end

local function DoReGIR()
    -- fully enable/disable ReGIR
	if var.settings.reGIR then
		print( "---------- Ultra+: Enabling ReGIR" )

		SetOption( "Editor/ReGIR", "Enable", true )
		SetOption( "Editor/ReGIR", "UseForDI", true )
		SetOption( "Editor/RTXDI", "EnableSeparateDenoising", false )
	else
		print( "---------- Ultra+: Disabling ReGIR" )

		SetOption( "Editor/ReGIR", "Enable", false )
		SetOption( "Editor/ReGIR", "UseForDI", false )
		SetOption( "Editor/RTXDI", "EnableSeparateDenoising", true )
	end
end

--[[
local function DoTurboHack()
	-- reduce detail outdoors
	if not var.settings.turboHack or var.settings.indoors then
		config.SetSamples( var.settings.samples )
		config.SetQuality( var.settings.quality )
	else
		print( "---------- Ultra+: PT Turbo - reducing detail oudoors" )

		if var.settings.samples == var.samples.VANILLA then
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "0" )

		elseif var.settings.samples == var.samples.LOW then
			if var.settings.mode == var.mode.PT20 then
				SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
				SetOption( "Editor/SHARC", "SceneScale", "35.7142857143" )
			elseif var.settings.mode == var.mode.RT_PT then
				SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
				SetOption( "Editor/SHARC", "SceneScale", "35.7142857143" )
			elseif var.settings.mode == var.mode.PT21 then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "0" )
			end

		elseif var.settings.samples == var.samples.MEDIUM then
			if var.settings.mode == var.mode.PT20 then

			elseif var.settings.mode == var.mode.RT_PT then

			elseif var.settings.mode == var.mode.PT21 then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			end

		elseif var.settings.samples == var.samples.HIGH then
			if var.settings.mode == var.mode.PT20 then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			elseif var.settings.mode == var.mode.RT_PT then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "0" )
			elseif var.settings.mode == var.mode.PT21 then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			end

		elseif var.settings.samples == var.samples.INSANE then
			if var.settings.mode == var.mode.PT20 then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "3" )
			elseif var.settings.mode == var.mode.RT_PT then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			elseif var.settings.mode == var.mode.PT21 then
				SetOption( "Editor/RTXDI", "SpatialNumSamples", "3" )
			end
		end

		if var.quality.mode == var.quality.MEDIUM then
			SetOption( "RayTracing/Reference", "BounceNumber", "1" )
		elseif var.quality.mode == var.quality.HIGH then
			SetOption( "RayTracing/Reference", "RayNumber", "2" )
			SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", true )
		elseif var.quality.mode == var.quality.INSANE then
			SetOption( "RayTracing/Reference", "RayNumber", "3" )
			SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", false )
		end
	end
end
]]

local function DoRainFix()
	-- emable particle PT integration unless player is outdoors AND it's raining
--[[
	if not var.settings.rainFix then
		print( "---------- Ultra+: Enabling DLSSDSeparateParticleColor" )
		SetOption( "Rendering", "DLSSDSeparateParticleColor", true )
		return
	end
]]
	if var.settings.rain == 1 or var.settings.indoors then
		print( "---------- Ultra+: Enabling DLSSDSeparateParticleColor" )
		SetOption( "Rendering", "DLSSDSeparateParticleColor", true )
	else
		print( "---------- Ultra+: Disabling DLSSDSeparateParticleColor" )
		SetOption( "Rendering", "DLSSDSeparateParticleColor", false )
	end
end

local function DoRRFix()
	-- if RR is enabled, continually disable NRD to work around FPS slowdown bug in CP 2.0+
	timer.paused = true
	local rayReconstruction = GetOption( '/graphics/presets', 'DLSS_D' )
	
	if not rayReconstruction then return end

	Debug( "Disabling NRD" )
	SetOption( "RayTracing", "EnableNRD", false )
	timer.paused = false
end

local function DoFastUpdate()
	-- runs every timer.FAST seconds
	DoRRFix()

	local testRain = Game.GetWeatherSystem():GetRainIntensity() > 0 and 1
	local testIndoors = IsEntityInInteriorArea(GetPlayer())

	if testRain ~= var.settings.rain or testIndoors ~= var.settings.indoors then
		DoRainFix()
		var.settings.rain = testRain
		var.settings.indoors = testIndoors
	end
--[[
	if config.turboHack ~= var.settings.turboHack then
		DoTurboHack()
		config.turboHack = var.settings.turboHack
	end
]]
	if  config.reGIR ~= var.settings.reGIR then
		DoReGIR()
		config.reGIR = var.settings.reGIR
	end
end

local function DoLazyUpdate()
	-- runs every timer.LAZY seconds
end

local function forcePTDenoiser()

	if GetOption( "Developer/FeatureToggles", "DLSSD" ) then
		print( "---------- Ultra+: Enabling RR, disabling NRD" )
		SetOption( "Developer/FeatureToggles", "DLSSD", true )
		SetOption( "RayTracing", "EnableNRD", false )
		SetOption( "/graphics/presets", "DLSS_D", true )
		--PushChanges()
	else
		print( "---------- Ultra+: Enabling NRD, disabling RR" )
		SetOption( "/graphics/presets", "DLSS_D", false )
		SetOption( "Developer/FeatureToggles", "DLSSD", false )
		SetOption( "RayTracing", "EnableNRD", true )
		--PushChanges()
	end
end

registerForEvent( 'onUpdate', function( delta )
	-- handle non-blocking background tasks
	Detector.UpdateGameStatus()

	if not timer.paused then
		timer.fast = timer.fast + delta
		timer.lazy = timer.lazy + delta
	end

	if Detector.isGameActive then
		if timer.fast > timer.FAST then
			DoFastUpdate()
			timer.fast = 0
		end

		if timer.lazy > timer.LAZY then
			DoLazyUpdate()
			timer.lazy = 0
		end
	end

	for i = #activeTimers, 1, -1 do
		local timer = activeTimers[i]
		timer.countdown = timer.countdown - delta

		if timer.countdown < 0 then
			timer.callback()
			table.remove( activeTimers, i )
		end
	end
end)

registerForEvent( "onTweak", function()

	LoadIni( "commonfixes.ini" )
--[[
	var.settings.mode = GuessMode()
	config.SetMode( var.settings.mode )

	var.settings.samples = GuessSamples()
	config.SetSamples( var.settings.samples )

	var.settings.quality = GuessQuality()
	config.SetQuality( var.settings.quality )
]]
	LoadSettings()
end)

registerForEvent( "onInit", function()

	local file = io.open( "debug", "r" )
	if file then
		config.DEBUG = true
		Debug( "Enabling debug output" )
	end

	config.SetMode( var.settings.mode )
	config.SetStreaming( var.settings.streaming )
	config.SetSamples( var.settings.samples )
	config.SetQuality( var.settings.quality )
end)

registerForEvent( "onOverlayOpen", function()
	WindowOpen = true
end)

registerForEvent( "onOverlayClose", function()
	WindowOpen = false
end)

registerForEvent( "onDraw", function()

	if WindowOpen then

		ImGui.SetNextWindowPos( 200, 200, ImGuiCond.FirstUseEver )
		ImGui.SetNextWindowSize( 436, 615, ImGuiCond.Appearing )

		if ImGui.Begin( "Ultra+ Control v" .. ultraplus.__VERSION, true ) then

			ImGui.SetWindowFontScale(0.9)

			if ImGui.BeginTabBar( "Tabs" ) then

				if ImGui.BeginTabItem( "Engine Config" ) then

					ui.text( "NOTE: Wait for FPS to stabilise after changing settings.")

					if ImGui.CollapsingHeader( "Rendering Mode", ImGuiTreeNodeFlags.DefaultOpen ) then
--[[
						if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", var.settings.mode == var.mode.RASTER ) then
							var.settings.mode = var.mode.RASTER
							config.SetMode( var.settings.mode )
							config.SetSamples( var.settings.samples )
						end
]]
						if ImGui.RadioButton( "RT Only", var.settings.mode == var.mode.RT_ONLY ) then
							var.settings.mode = var.mode.RT_ONLY
							config.SetMode( var.settings.mode )
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "RT+PT", var.settings.mode == var.mode.RT_PT ) then
							var.settings.mode = var.mode.RT_PT
							config.SetMode( var.settings.mode )
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "PT20", var.settings.mode == var.mode.PT20 ) then
							var.settings.mode = var.mode.PT20
							config.SetMode( var.settings.mode )
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "PT21", var.settings.mode == var.mode.PT21 ) then
							var.settings.mode = var.mode.PT21
							config.SetMode( var.settings.mode )
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "RTXDI and ReGIR Quality", ImGuiTreeNodeFlags.DefaultOpen ) then
						ui.tooltip( "RTXDI is path traced direct illumination." )

						if ImGui.RadioButton( "Vanilla##SamplesVanilla", var.settings.samples == var.samples.VANILLA ) then
							var.settings.samples = var.samples.VANILLA
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "Low##SamplesLow", var.settings.samples == var.samples.LOW ) then
							var.settings.samples = var.samples.LOW
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "Medium##SamplesMedium", var.settings.samples == var.samples.MEDIUM ) then
							var.settings.samples = var.samples.MEDIUM
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "High##SamplesHigh", var.settings.samples == var.samples.HIGH ) then
							var.settings.samples = var.samples.HIGH
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "Insane##SamplesInsane", var.settings.samples == var.samples.INSANE ) then
							var.settings.samples = var.samples.INSANE
							config.SetSamples( var.settings.samples )
							SaveSettings()
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( var.settings.mode.." Indirect Illumination Sampling", ImGuiTreeNodeFlags.DefaultOpen ) then

						if ImGui.RadioButton( "Vanilla##QualityVanilla", var.settings.quality == var.quality.VANILLA ) then
							var.settings.quality = var.quality.VANILLA
							config.SetQuality( var.settings.quality )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "Low##QualityLow", var.settings.quality == var.quality.LOW ) then
							var.settings.quality = var.quality.LOW
							config.SetQuality( var.settings.quality )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "Medium##QualityMedium", var.settings.quality == var.quality.MEDIUM ) then
							var.settings.quality = var.quality.MEDIUM
							config.SetQuality( var.settings.quality )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "High##QualityHigh", var.settings.quality == var.quality.HIGH ) then
							var.settings.quality = var.quality.HIGH
							config.SetQuality( var.settings.quality )
							SaveSettings()
						end
						
						ui.align()
						if ImGui.RadioButton( "Insane##QualityInsane", var.settings.quality == var.quality.INSANE ) then
							var.settings.quality = var.quality.INSANE
							config.SetQuality( var.settings.quality )
							SaveSettings()
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "Streaming Boost", ImGuiTreeNodeFlags.DefaultOpen ) then

						if ImGui.RadioButton( "20 metres##StreamingLow", var.settings.streaming == var.streaming.LOW ) then
							var.settings.streaming = var.streaming.LOW
							config.SetStreaming( var.settings.streaming )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "40 metres##StreamingMedium", var.settings.streaming == var.streaming.MEDIUM ) then
							var.settings.streaming = var.streaming.MEDIUM
							config.SetStreaming( var.settings.streaming )
							SaveSettings()
						end

						ui.align()
						if ImGui.RadioButton( "80 metres##StreamingHigh", var.settings.streaming == var.streaming.HIGH ) then
							var.settings.streaming = var.streaming.HIGH
							config.SetStreaming( var.settings.streaming )
							SaveSettings()
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "Tweaks", ImGuiTreeNodeFlags.DefaultOpen ) then

						for _, setting in pairs( options.Tweaks ) do
							setting.value = GetOption( setting.category, setting.item )
							setting.value, toggled = ImGui.Checkbox( setting.name, setting.value )
							ui.tooltip( setting.tooltip )

							if toggled then
								SetOption( setting.category, setting.item, setting.value )
								setting.value = setting.value
								SaveSettings()
							end
						end
					end

					ImGui.EndTabItem()
				end

				if ImGui.BeginTabItem( "Rendering Features" ) then

					ui.space()
					for _, setting in pairs( options.Features ) do
						setting.value = GetOption( setting.category, setting.item )
						setting.value, toggled = ImGui.Checkbox( setting.name, setting.value )
						ui.tooltip( setting.tooltip )

						if toggled then
							SetOption( setting.category, setting.item, setting.value )
							setting.value = setting.value

							SaveSettings()
						end
					end

					ImGui.EndTabItem()
				end

				ImGui.EndTabBar()
			end

		ImGui.End()
		end
	end
end)
