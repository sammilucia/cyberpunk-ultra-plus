local ultraplus = {
  __VERSION	 	= '3.2',
  __DESCRIPTION = 'Better Path Tracing, Ray Tracing and Stutter Hotfix for CyberPunk',
  __URL		 	= 'https://github.com/sammilucia/cyberpunk-ultra-plus',
  __LICENSE	 	= [[
	Copyright (c) 2024 SammiLucia

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
local defaults = require( "defaults" )
local var = require( "variables" )
local ui = require( "ui" )
local config = {
	setSamples = require( "setsamples" ).setSamples,
	setMode = require( "setmode" ).setMode,
	commonFixes = require( "commonfixes" ).commonFixes,
}
local activeTimers = {}
local timer = {
	lazy = 0,
	fast = 0,
	LAZY = 20.0,
	FAST = 2.0,
}

function Wait( seconds, callback )
	-- non-blocking wait
	table.insert( activeTimers, { countdown = seconds, callback = callback } )
end

function SplitOption( string )
	-- splits an ini/CVar command into its constituents
	local category, item = string.match( string, "(.-)/([^/]+)$" )

	return category, item
end

function GetOption( category, item )

	local value = nil

	if category == "internal" then
		value = var.settings[item]

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

	if category == "internal" then
		var.settings[item] = value

	elseif category:match( "^/" ) then
		Game.GetSettingsSystem():GetVar( category, item ):SetValue( value )

	else
		if type( value ) == "boolean" then
			GameOptions.SetBool( category, item, value )

		elseif value:match( "^%-?%d+%.%d+$" ) then
			GameOptions.SetFloat( category, item, tonumber( value ) )

		elseif value:match( "^%-?%d+$" ) then
			GameOptions.SetInt( category, item, tonumber( value ) )

		else
			print("---------- Ultra+: Unsupported GameOption:", category .. "/" .. item, "=", value)
		end
	end
end

function PushChanges()
	Wait( 0.1, function()
		Game.GetSettingsSystem():ConfirmChanges()
	end )
end

local function forceDlssd()
	local testDlssd = GetOption( '/graphics/presets', 'DLSS_D' )

	while testDlssd == false
	do
		print( '/graphics/presets/DLSS_D = ', testDlssd )

		SetOption( "/graphics/presets", "DLSS_D", true )

		Wait( 0.1, function()
			testDlssd = GetOption( '/graphics/presets', 'DLSS_D' )
		end )
	end

	PushChanges()

	SetOption( "RayTracing", "EnableNRD", false )

	SaveSettings()
end

function LoadSettings()
-- load defaults, then attempt to replace with user settings

	local settingsTable = {}
	local settingsCategories = {
		defaults.Experimental,
		defaults.Features,
		defaults.Distance,
		defaults.SkinHair,
	}

	for _, category in pairs(settingsCategories)
	do
		for _, setting in ipairs(category)
		do
			settingsTable[setting.item] = {value = setting.defaultValue, category = setting.category}
		end
	end

	local file = io.open( "UserSettings.json", "r" )

	if file then
		local rawJson = file:read( "*a" )
		file:close()

		if not rawJson:match( "^%s*$" ) then
			local success, result = pcall( json.decode, rawJson )

			if success and result.UltraPlus
			then
				for item, value in pairs( result.UltraPlus )
				do
					if settingsTable[item] ~= nil then
						settingsTable[item].value = value
					end
				end
			else
				print("---------- Ultra+: Error loading UserSettings.json:", result)
			end
		else
			print("---------- Ultra+: UserSettings.json is empty or invalid.")
		end
	end

	print("---------- Ultra+: Loading Settings...")

	for item, setting in pairs( settingsTable )
	do
		SetOption( setting.category, item, setting.value )
	end
end

function SaveSettings()

	local UltraPlus = {}
	local settingsCategories = {
		defaults.Experimental,
		defaults.Features,
		defaults.Distance,
		defaults.SkinHair,
	}

	for _, thisCategory in pairs( settingsCategories )
	do
		for _, thisSetting in pairs( thisCategory )
		do
			UltraPlus[ thisSetting.item ] = thisSetting.defaultValue
		end
	end

	local settingsTable = { UltraPlus = UltraPlus }

	local success, result = pcall( json.encode, settingsTable )
	if not success then
		print( "---------- Ultra+: Error saving UserSettings.json:", result )
		return
	end

	local rawJson = result
	local file = io.open( "UserSettings.json", "w" )

	if file then
		file:write( rawJson )
		file:close()
	end
end

local function guessMode()

	local guess = "Unknown"

	local reJitter = GetOption( "Rendering", "AllowRayTracedReferenceRejitter" )
	local reStir = GetOption( "Editor/ReSTIRGI", "Enable" )
	local pathTracing = GetOption( "/graphics/raytracing", "RayTracedPathTracing" )
	local rayTracing = GetOption( "/graphics/raytracing", "RayTracing" )

	if rayTracing == false then
		guess = var.mode.RASTER

	elseif pathTracing == false and rayTracing == true and reJitter == false then
		guess = var.mode.RT_ONLY

	elseif pathTracing == false and rayTracing == true and reJitter == true then
		guess = var.mode.RT_PT

	elseif pathTracing == true and reStir == false then
		guess = var.mode.PT20

	elseif pathTracing == true and reStir == true and reJitter == true then
		guess = var.mode.PT21

	elseif pathTracing == true and reStir == true and reJitter == false then
		guess = var.mode.VANILLA

	end

	print( "---------- Ultra+: Guessed rendering mode is", guess )
	return guess
end

local function guessSamples()

	local guess = "Unknown"

	local numInitial = GetOption( "Editor/RTXDI", "NumInitialSamples" )
	local numSpatial = GetOption( "Editor/RTXDI", "SpatialNumSamples" )

	if numInitial == 14 then
		guess = var.samples.PERFORMANCE

	elseif numInitial == 16 then
		guess = var.samples.BALANCED

	elseif numInitial == 20 then
		guess = var.samples.QUALITY

	elseif numInitial == 8 then
		guess = var.samples.VANILLA

	end

	print( "---------- Ultra+: Guessed sample mode is", guess )
	return guess
end

function ResetEngine()
	print( "---------- Ultra+: Reloading redENGINE" )
	GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():RequestSaveUserSettings()
end

local function doNrdFix()
	-- if var.settings.mode ~= var.mode.PT21 or var.settings.nrdFix == false then return end
	if not var.settings.nrdFix then return end

	SetOption( "RayTracing", "EnableNRD", false )
end

local function updateState()
	-- if testRain > 0 then testRain = 1
    local testRain = Game.GetWeatherSystem():GetRainIntensity() > 0 and 1 or 0
    local testIndoors = IsEntityInInteriorArea(GetPlayer())

    if testRain ~= var.settings.rain or testIndoors ~= var.settings.indoors
	then
        var.settings.rain = testRain
        var.settings.indoors = testIndoors

        return true
    end

    return false
end

local function doTurboHack()
	-- disable RTXDI spatial sampling if player is outdoors
    if not var.settings.realTurbo or var.settings.indoors then
        config.setSamples( var.settings.samples )

		return
	end

    if not var.settings.indoors then
        print( "---------- Ultra+: Disabling SpatialNumSamples" )
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")
    else
        config.setSamples( var.settings.samples )
    end
end

local function doRainFix()
	-- emable particle PT integration unless player is outdoors AND it's raining
    if not var.settings.rainFix then
        print( "---------- Ultra+: Enabling DLSSDSeparateParticleColor" )
		SetOption( "Rendering", "DLSSDSeparateParticleColor", true )

		return
	end

    if var.settings.rain == 1 and not var.settings.indoors then
		print( "---------- Ultra+: Enabling DLSSDSeparateParticleColor" )
        SetOption( "Rendering", "DLSSDSeparateParticleColor", true )
    else
		print( "---------- Ultra+: Disabling DLSSDSeparateParticleColor" )
        SetOption( "Rendering", "DLSSDSeparateParticleColor", false )
    end
end

local function doFastUpdate()
	-- runs every timer.__FAST seconds
    local stateChanged = updateState()

    if stateChanged then
        doRainFix()
        doTurboHack()
    end
end

local function doLazyUpdate()
	-- runs every timer.__LAZY seconds
	if var.settings.nrdFix then doNrdFix() end
end

registerForEvent( 'onUpdate', function( delta )

	timer.fast = timer.fast + delta
	timer.lazy = timer.lazy + delta

	if timer.fast > timer.__FAST then
		doFastUpdate()
		timer.fast = 0
	end

	if timer.lazy > timer.__LAZY then
		doLazyUpdate()
		timer.lazy = 0
	end

	for i = #activeTimers, 1, -1
	do
		local timer = activeTimers[i]
		timer.countdown = timer.countdown - delta

		if timer.countdown < 0 then
			timer.callback()
			table.remove( activeTimers, i )
		end
	end
end)

registerForEvent( "onInit", function()

	config.commonFixes()
	LoadSettings()

	var.settings.mode = guessMode()
	config.setMode( var.settings.mode )

	var.settings.samples = guessSamples()
	config.setSamples( var.settings.samples )
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
		ImGui.SetNextWindowSize( 510, 738, ImGuiCond.Appearing )

		if ImGui.Begin( "Ultra+ Control v" .. ultraplus.__VERSION, true ) then

			ImGui.SetWindowFontScale(0.9)

			if ImGui.BeginTabBar( "Tabs" ) then

				-- Ultra+ Tab
				if ImGui.BeginTabItem( "Engine Config" ) then

					local newMode = var.settings.mode

					if ImGui.CollapsingHeader( "Mode", ImGuiTreeNodeFlags.DefaultOpen )
					then
						if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", newMode == var.mode.RASTER )
						then
							var.settings.mode = var.mode.RASTER
							config.setMode( var.settings.mode )
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "Ray Tracing: Normal Ray Tracing", newMode == var.mode.RT_ONLY )
						then
							var.settings.mode = var.mode.RT_ONLY
							config.setMode( var.settings.mode )
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "RT+PT: Ray Tracing plus Path Tracing", newMode == var.mode.RT_PT )
						then
							var.settings.mode = var.mode.RT_PT
							config.setMode( var.settings.mode )
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "Vanilla Path Tracing (no tweaks, bugfixes only)", newMode == var.mode.VANILLA )
						then
							var.settings.mode = var.mode.VANILLA
							config.setMode( var.settings.mode )
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "PT20: Fast Path Tracing (RTXDI+ReLAX, tweaked)", newMode == var.mode.PT20 )
						then
							var.settings.mode = var.mode.PT20
							config.setMode( var.settings.mode )
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "PT21: Ultra+ Path Tracing (RTXDI+ReSTIR, tweaked)", newMode == var.mode.PT21 )
						then
							var.settings.mode = var.mode.PT21
							config.setMode( var.settings.mode )
							config.setSamples( var.settings.samples )
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "Path Tracing Samples", ImGuiTreeNodeFlags.DefaultOpen )
					then
						if ImGui.RadioButton( "Vanilla", var.settings.samples == var.samples.VANILLA )
						then
							var.settings.samples = var.samples.VANILLA
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "Performance", var.settings.samples == var.samples.PERFORMANCE )
						then
							var.settings.samples = var.samples.PERFORMANCE
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "Balanced", var.settings.samples == var.samples.BALANCED )
						then
							var.settings.samples = var.samples.BALANCED
							config.setSamples( var.settings.samples )
						end

						if ImGui.RadioButton( "Quality", var.settings.samples == var.samples.QUALITY )
						then
							var.settings.samples = var.samples.QUALITY
							config.setSamples( var.settings.samples )
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "Experimental", ImGuiTreeNodeFlags.DefaultOpen )
					then
						for _, setting in pairs( defaults.Experimental )
						do
							setting.defaultValue = GetOption( setting.category, setting.item )
							setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
								ui.tooltip( setting.tooltip )

							if toggled
							then
								SetOption( setting.category, setting.item, setting.defaultValue )
								setting.defaultValue = setting.defaultValue

								SaveSettings()
							end
						end
					end

					ImGui.EndTabItem()
				end

				if ImGui.BeginTabItem( "Tweaks" )
				then
					ui.space()
					if ImGui.CollapsingHeader( "Features", ImGuiTreeNodeFlags.DefaultOpen )
					then
						for _, setting in pairs( defaults.Features )
						do
							setting.defaultValue = GetOption( setting.category, setting.item )
							setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
							ui.tooltip( setting.tooltip )

							if toggled then
								SetOption( setting.category, setting.item, setting.defaultValue )
								setting.defaultValue = setting.defaultValue

								SaveSettings()
							end
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "Distance", ImGuiTreeNodeFlags.DefaultOpen )
					then
						for _, setting in pairs( defaults.Distance )
						do
							setting.defaultValue = GetOption( setting.category, setting.item )
							setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
							ui.tooltip( setting.tooltip )

							if toggled then
								SetOption( setting.category, setting.item, setting.defaultValue )
								setting.defaultValue = setting.defaultValue

								SaveSettings()
							end
						end
					end

					ui.space()
					if ImGui.CollapsingHeader( "Skin and Hair", ImGuiTreeNodeFlags.DefaultOpen )
					then
						for _, setting in pairs( defaults.SkinHair )
						do
							setting.defaultValue = GetOption( setting.category, setting.item )
							setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
							ui.tooltip( setting.tooltip )

							if toggled then

								SetOption( setting.category, setting.item, setting.defaultValue )
								setting.defaultValue = setting.defaultValue

								SaveSettings()
							end
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
