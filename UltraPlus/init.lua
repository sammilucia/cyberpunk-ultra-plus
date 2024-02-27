local ultraplus = {
  __VERSION     = 'ultraplus.lua 1.0-rc1',
  __DESCRIPTION = 'Better Path Tracing, Ray Tracing and Stutter Hotfix for CyberPunk',
  __URL         = 'https://github.com/sammilucia/cyberpunk-ultra-plus',
  __LICENSE     = [[
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

local Draw		= require( "draw" )
local var		= require( "variables" )
local defaults	= require( "defaults" )
local toggled
local config	= {
	SetSamples	= require( "setsamples" ).SetSamples,
	SetMode		= require( "setmode" ).SetMode,
	CommonFixes	= require( "commonfixes" ).CommonFixes,
}

function Wait( seconds )

	-- wait for fractions of seconds e.g. '0.4'
    local start = os.clock()
    while os.clock() - start < seconds do end

end

function SplitOption( string )

	-- splits a GameOptions (etc.) string into pieces
    local category, item = string.match( string, "(.-)/([^/]+)$" )
    return category, item

end

function GetOption( category, item )

	local value = nil

	if category == "internal" then

		-- handle internal settings
		value = var.settings[item]

	elseif category:match( "^/" ) then

		-- handle /graphics
		value = Game.GetSettingsSystem():GetVar( category, item ):GetValue()

	else

		--handle CVars
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

		-- handle internal settings
		var.settings[item] = value

	elseif category:match( "^/" ) then

		-- handle /graphics	
		Game.GetSettingsSystem():GetVar( category, item ):SetValue( value )

	else

		-- handle CVars
		if type( value ) == "boolean" then

			GameOptions.SetBool( category, item, value )

		elseif value:match( "^%-?%d+%.%d+$" ) then

			GameOptions.SetFloat( category, item, tonumber( value ) )

		elseif value:match( "^%-?%d+$" ) then

			GameOptions.SetInt( category, item, tonumber( value ) )

		else

			print( "Unsupported GameOption." )

		end
	end
end

function PushChanges()

	Wait( 0.1 )
	Game.GetSettingsSystem():ConfirmChanges()

end

function ForceDlssd()

	local checkDlssd = GetOption( '/graphics/presets', 'DLSS_D' )

    while checkDlssd == false do

		print( '/graphics/presets/DLSS_D = ', checkDlssd )

		SetOption( "/graphics/presets", "DLSS_D", true )
		Wait( 0.1 )

        checkDlssd = GetOption( '/graphics/presets', 'DLSS_D' )

    end

	PushChanges()

	SetOption( "RayTracing", "EnableNRD", false )

	SaveSettings()

end

function LoadSettings()

	local file = io.open( "UserSettings.json", "r" )
	if not file then return end

	local rawJson = file:read( "*a" )
	file:close()

	if rawJson:match( "^%s*$" ) then

		print("---------- Ultra+: UserSettings.json is empty or invalid.")
        return

	end

	local success, output = pcall( json.decode, rawJson )

	if not success then

		print( "---------- Ultra+: Error loading UserSettings.json:", output )
		return

	end

	local settingsTable = output

	print( "---------- Ultra+: Loading Settings..." )

	local settingsCategories = {
		defaults.Experimental,
		defaults.Features,
		defaults.Distance,
		defaults.SkinHair,
	}

	for _, thisCategory in pairs( settingsCategories ) do

		for _, thisSetting in pairs( thisCategory ) do

			local value = settingsTable.UltraPlus[ thisSetting.item ]

			if value ~= nil and type(value) == "boolean" then

				thisSetting.defaultValue = value
				SetOption( thisSetting.category, thisSetting.item, thisSetting.defaultValue )

			else
				-- if UserSettings.json is invalid, revert to default
				SetOption( thisSetting.category, thisSetting.item, thisSetting.defaultValue )
				print("Invalid value for setting:", thisSetting.item, "- reverted to default.")

			end
		end
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

	for _, thisCategory in pairs( settingsCategories ) do

		for _, thisSetting in pairs( thisCategory ) do

			UltraPlus[ thisSetting.item ] = thisSetting.defaultValue

		end
	end

	local settingsTable = { UltraPlus = UltraPlus }

	local success, output = pcall( json.encode, settingsTable )
	if not success then

		print( "---------- Ultra+: Error saving UserSettings.json:", output )
		return

	end

	local rawJson = output

	local file = io.open( "UserSettings.json", "w" )

	if file then

		print( "---------- Ultra+: Saving Settings..." )

		file:write( rawJson )
		file:close()

	end
end

local function guessMode()

	local guess = "Unknown"

	local reJitter    = GetOption( "Rendering", "AllowRayTracedReferenceRejitter" )
	local reStir      = GetOption( "Editor/ReSTIRGI", "Enable" )
	local pathTracing = GetOption( "/graphics/raytracing", "RayTracedPathTracing" )
	local rayTracing  = GetOption( "/graphics/raytracing", "RayTracing" )

	if rayTracing == false then
		guess = var.mode.raster

	elseif pathTracing == false and rayTracing == true and reJitter == false then
		guess = var.mode.rt_only

	elseif pathTracing == false and rayTracing == true and reJitter == true then
		guess = var.mode.rt_pt

	elseif pathTracing == true and reStir == false then
		guess = var.mode.pt20

	elseif pathTracing == true and reStir == true and reJitter == true then
		guess = var.mode.pt21

	elseif pathTracing == true and reStir == true and reJitter == false then
		guess = var.mode.vanilla

	end

	print( "---------- Ultra+: Guessed rendering mode is", guess )
	return guess

end

local function guessSamples()

	local guess = "Unknown"

	local numInitial = GetOption( "Editor/RTXDI", "NumInitialSamples" )
	local numSpatial = GetOption( "Editor/RTXDI", "SpatialNumSamples" )

	if numInitial == 16 and numSpatial == 0 then
		guess = var.samples.performance

	elseif numInitial == 20 and numSpatial == 1 then
		guess = var.samples.balanced

	elseif numInitial == 24 and numSpatial == 2 then
		guess = var.samples.quality

	elseif numInitial == 8 and numSpatial == 1 then
		guess = var.samples.vanilla

	end

	print( "---------- Ultra+: Guessed sample mode is", guess )
	return guess

end

function ResetEngine()

	print( "---------- Ultra+: Reloading redENGINE" )
	GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():RequestSaveUserSettings()

end

local function NrdFix()

	if var.settings.mode ~= var.mode.pt21 or var.settings.nrd_fix == false then return end

	SetOption( "RayTracing", "EnableNRD", false )

end

local function RainFix()

	if not var.settings.particle_fix then return end

		local rainTest = Game.GetWeatherSystem():GetRainIntensity()

		if rainTest > 0 then
			SetOption( "Rendering", "DLSSDSeparateParticleColor", true )

		else
			SetOption( "Rendering", "DLSSDSeparateParticleColor", false )

		end
end

function DoCronTasks()

	NrdFix()
	RainFix()

end

registerForEvent( 'onUpdate', function( delta )

	var.timer.counter = var.timer.counter + delta
	var.timer.cron = var.timer.cron + delta

	if var.timer.cron < var.timer.interval then return end

	DoCronTasks()

	var.timer.cron = 0

end)

registerForEvent( "onInit", function()

	config.CommonFixes()
	LoadSettings()

	var.settings.mode = guessMode()
	config.SetMode( var.settings.mode )

	var.settings.samples = guessSamples()
	config.SetSamples( var.settings.samples )

end)

registerForEvent( "onOverlayOpen", function()

	_WindowOpen = true

end)

registerForEvent( "onOverlayClose", function()

	_WindowOpen = false

end)

registerForEvent( "onDraw", function()

	if _WindowOpen then

		ImGui.SetNextWindowPos( 200, 200, ImGuiCond.FirstUseEver )
		ImGui.SetNextWindowSize( 550, 854, ImGuiCond.Appearing )

		if ImGui.Begin( "Ultra+ Control", true ) then

			if ImGui.BeginTabBar( "Tabs" ) then

				-- Ultra+ Tab
				if ImGui.BeginTabItem( "Engine Config" ) then

					local newMode = var.settings.mode

					ImGui.Text("Settings")
					ImGui.Spacing()		

					if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", newMode == var.mode.raster ) then

						var.settings.mode = var.mode.raster
						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "Ray Tracing: Normal Ray Tracing", newMode == var.mode.rt_only ) then

						var.settings.mode = var.mode.rt_only
						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "RT+PT: Ray Tracing plus Path Tracing", newMode == var.mode.rt_pt ) then

						var.settings.mode = var.mode.rt_pt
						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "Vanilla Path Tracing (no tweaks, bugfixes only)", newMode == var.mode.vanilla ) then

						var.settings.mode = var.mode.vanilla
						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "PT20: Fast Path Tracing (RTXDI+ReLAX, tweaked)", newMode == var.mode.pt20 ) then

						var.settings.mode = var.mode.pt20
						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "PT21: Ultra+ Path Tracing (RTXDI+ReSTIR, tweaked)", newMode == var.mode.pt21 ) then

						var.settings.mode = var.mode.pt21
						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					Draw.Section( "The number of path tracing samples affects both boiling, and edge noise: Higher samples = less noise." )

					if ImGui.RadioButton( "Vanilla RTXDI samples (spatial samples: 1)", var.settings.samples == var.samples.vanilla ) then

						var.settings.samples = var.samples.vanilla
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "Performance RTXDI samples (spatial samples: Off)", var.settings.samples == var.samples.performance ) then

						var.settings.samples = var.samples.performance
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "Balanced RTXDI samples (spatial samples: 1)", var.settings.samples == var.samples.balanced ) then

						var.settings.samples = var.samples.balanced
						config.SetSamples( var.settings.samples )

					end

					if ImGui.RadioButton( "Quality RTXDI samples (spatial samples: 2)", var.settings.samples == var.samples.quality ) then

						var.settings.samples = var.samples.quality
						config.SetSamples( var.settings.samples )

					end

					Draw.Section( "Experimental" )
					ImGui.Spacing()

					for _, setting in pairs( defaults.Experimental ) do

						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						Draw.Tooltip( setting.note )

						if toggled then

							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue

							SaveSettings()

						end
					end

					Draw.Line()

					if ImGui.Button( "(Re)load All" ) then

						config.CommonFixes()

						LoadSettings()

						config.SetMode( var.settings.mode )
						config.SetSamples( var.settings.samples )

					end

					ImGui.SameLine()
					if ImGui.Button( "Save All" ) then

						SaveSettings()

					end

					ImGui.SameLine()
					if ImGui.Button( "Force Ray Reconstruction" ) then

						ForceDlssd()

					end

					ImGui.SameLine()
					if ImGui.Button( "Restart Engine" ) then

						ResetEngine()

					end

					ImGui.EndTabItem()
				end

				-- Features Tab
				if ImGui.BeginTabItem( "Rendering Config" ) then

					Draw.Heading( "General" )

					for _, setting in pairs( defaults.Features ) do

						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						Draw.Tooltip( setting.note )

						if toggled then

							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue

							SaveSettings()

						end
					end

					Draw.Heading( "Distance" )

					for _, setting in pairs( defaults.Distance ) do

						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						Draw.Tooltip( setting.note )

						if toggled then

							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue

							SaveSettings()

						end
					end

					Draw.Heading( "Skin Hair" )

					for _, setting in pairs( defaults.SkinHair ) do

						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						Draw.Tooltip( setting.note )

						if toggled then

							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue

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
