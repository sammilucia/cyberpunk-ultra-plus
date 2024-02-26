local ultraplus = {
  __VERSION     = 'ultraplus.lua 0.8-test',
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

_var 	 = require( "variables" )

Defaults = require( "defaults" )
config 	 = {
	SetSamples 	= require( "setsamples" ).SetSamples,
	SetMode 	= require( "setmode" ).SetMode,
	CommonFixes = require( "commonfixes" ).CommonFixes,
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
	
	if category:match( "^/" ) then
		-- handle graphics settings
		value = Game.GetSettingsSystem():GetVar( category, item ):GetValue()
	else
		--handle ini settings
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
	
	if category:match( "^/" ) then
		-- handle graphics settings
		Game.GetSettingsSystem():GetVar( category, item ):SetValue( value )
	else
		-- handle ini settings
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

	print( '/graphics/presets/DLSS_D = ', checkDlssd )

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
		Defaults.Experimental,
		Defaults.Features,
		Defaults.Distance,
		Defaults.SkinHair,
	}

	for _, thisCategory in pairs( settingsCategories )
	do
		for _, thisSetting in pairs( thisCategory )
		do
			local settingValue = settingsTable.UltraPlus[ thisSetting.item ]

			if settingValue ~= nil then
				thisSetting.defaultValue = settingValue
				SetOption( thisSetting.category, thisSetting.item, thisSetting.defaultValue )
			end
		end
	end
end

function SaveSettings()
	local UltraPlus = {}
	local settingsCategories = {
		Defaults.Experimental,
		Defaults.Features,
		Defaults.Distance,
		Defaults.SkinHair,
	}

	for _, thisCategory in pairs( settingsCategories )
	do
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

function guessMode()
	local guess = "Unknown"

	local reJitter    = GetOption( "Rendering", "AllowRayTracedReferenceRejitter" )
	local reStir      = GetOption( "Editor/ReSTIRGI", "Enable" )
	local pathTracing = GetOption( "/graphics/raytracing", "RayTracedPathTracing" )
	local rayTracing  = GetOption( "/graphics/raytracing", "RayTracing" )

	if rayTracing == false then
		guess = _var.mode.raster
	elseif pathTracing == false and rayTracing == true and reJitter == false then
		guess = _var.mode.rtOnly
	elseif pathTracing == false and rayTracing == true and reJitter == true then
		guess = _var.mode.rtpt
	elseif pathTracing == true and reStir == false then
		guess = _var.mode.pt20
	elseif pathTracing == true and reStir == true and reJitter == true then
		guess = _var.mode.pt21
	elseif pathTracing == true and reStir == true and reJitter == false then
		guess = _var.mode.vanilla
	end
	
	print( "---------- Ultra+: Guessed rendering mode is", guess )
	return guess
end

function guessSamples()
	local guess = "Unknown"
	
	local numInitial = GetOption( "Editor/RTXDI", "NumInitialSamples" )
	local numSpatial = GetOption( "Editor/RTXDI", "SpatialNumSamples" )
	
	if numInitial == 16 and numSpatial == 0 then
		guess = _var.samples.performance
	elseif numInitial == 20 and numSpatial == 1 then
		guess = _var.samples.balanced
	elseif numInitial == 24 and numSpatial == 2 then
		guess = _var.samples.quality
	elseif numInitial == 8 and numSpatial == 1 then
		guess = _var.samples.vanilla
	end
	
	print( "---------- Ultra+: Guessed sample mode is", guess )
	return guess
end

function DrawLine()
	ImGui.Spacing()
	ImGui.Separator()
	ImGui.Spacing()
end

function DrawSection( text )	
	ImGui.Spacing()
	ImGui.Separator()
	ImGui.PushStyleColor( ImGuiCol.Text, 0xff888888 )
	ImGui.TextWrapped( text )
	ImGui.PopStyleColor()
	ImGui.Spacing()
end	

function DrawTooltip( text )	
	if ImGui.IsItemHovered() and text ~= "" then
		ImGui.BeginTooltip()
		ImGui.SetTooltip( text )
		ImGui.EndTooltip()
	end
end

function ResetEngine()
	print( "---------- Ultra+: Reloading redENGINE" )
	GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():RequestSaveUserSettings()
end

function DoCronTasks()

	if _var.settings.mode == _var.mode.pt21 and _var.settings.nrdFix == true
	then
		SetOption( "RayTracing", "EnableNRD", false )
	end
--[[
	if GetOptions( weatherStates ) == "Rain" or GetOptions( weatherStates ) == "Rain2" then
		SetOption( "Rendering", "DLSSDSeparateParticleColor", true )
	else
		SetOption( "Rendering", "DLSSDSeparateParticleColor", false )
	end
]]

end

registerForEvent( 'onUpdate', function( delta )

	_var.timer.counter = _var.timer.counter + delta
	_var.timer.cron = _var.timer.cron + delta

	if _var.timer.cron < _var.timer.interval then return end
	
	DoCronTasks()
	_var.timer.cron = 0

end)

registerForEvent( "onInit", function()

	config.CommonFixes()
	LoadSettings()

	_var.settings.mode = guessMode()
	config.SetMode( _var.settings.mode )

	_var.settings.samples = guessSamples()
	config.SetSamples( _var.settings.samples )

end)

registerForEvent( "onOverlayOpen", function()
	windowOpen = true
end)

registerForEvent( "onOverlayClose", function()
	windowOpen = false
end)

registerForEvent( "onDraw", function()

	if windowOpen then
	
		ImGui.SetNextWindowPos( 200, 200, ImGuiCond.FirstUseEver )
		ImGui.SetNextWindowSize( 550, 820, ImGuiCond.Appearing )

		if ImGui.Begin( "Ultra+ Control", true ) then

			--width = ImGui.GetWindowContentRegionWidth()

			if ImGui.BeginTabBar( "Tabs" ) then

				-- Ultra+ Tab
				if ImGui.BeginTabItem( "Engine Config" ) then

					local newMode = _var.settings.mode

					ImGui.Text("Settings")
					ImGui.Spacing()		

					if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", newMode == _var.mode.raster ) then
						_var.settings.mode = _var.mode.raster
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "Ray Tracing: Normal Ray Tracing", newMode == _var.mode.rtOnly ) then
						_var.settings.mode = _var.mode.rtOnly
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "RT+PT: Ray Tracing plus Path Tracing", newMode == _var.mode.rtpt ) then
						_var.settings.mode = _var.mode.rtpt
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "Vanilla Path Tracing (no tweaks, bugfixes only)", newMode == _var.mode.vanilla ) then
						_var.settings.mode = _var.mode.vanilla
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "PT20: Fast Path Tracing (RTXDI+ReLAX, tweaked)", newMode == _var.mode.pt20 ) then
						_var.settings.mode = _var.mode.pt20
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "PT21: Ultra+ Path Tracing (RTXDI+ReSTIR, tweaked)", newMode == _var.mode.pt21 ) then
						_var.settings.mode = _var.mode.pt21
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
					end
					
					DrawSection( "The number of path tracing samples affects both boiling, and edge noise: Higher samples = less noise." )

					if ImGui.RadioButton( "Vanilla RTXDI samples (spatial samples: 1)", _var.settings.samples == _var.samples.vanilla ) then
						_var.settings.samples = _var.samples.vanilla
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "Performance RTXDI samples (spatial samples: Off)", _var.settings.samples == _var.samples.performance ) then
						_var.settings.samples = _var.samples.performance
						config.SetSamples( _var.settings.samples )
					end

					if ImGui.RadioButton( "Balanced RTXDI samples (spatial samples: 1)", _var.settings.samples == _var.samples.balanced ) then
						_var.settings.samples = _var.samples.balanced
						config.SetSamples( _var.settings.samples )
					end
					
					if ImGui.RadioButton( "Quality RTXDI samples (spatial samples: 2)", _var.settings.samples == _var.samples.quality ) then
						_var.settings.samples = _var.samples.quality
						config.SetSamples( _var.settings.samples )
					end

					DrawSection( "Experimental" )
					ImGui.Spacing()

					_var.settings.nrdFix = ImGui.Checkbox( "PT21 FPS Fix: Continually disable NRD", _var.settings.nrdFix )
					
					for _, setting in pairs( Defaults.Experimental ) do

						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						DrawTooltip( setting.note )

						if toggled then
						
							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue
							SaveSettings()
						
						end
					end
					
					DrawLine()
					
					if ImGui.Button( "(Re)load All" ) then
						config.CommonFixes()
						LoadSettings()
						config.SetMode( _var.settings.mode )
						config.SetSamples( _var.settings.samples )
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
					ImGui.Text( "General" )
					ImGui.Spacing()

					for _, setting in pairs( Defaults.Features ) 
					do
						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						DrawTooltip( setting.note )
		
						if toggled then
							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue
							SaveSettings()
						end
					end

					ImGui.Spacing()
					ImGui.Text( "Distance" )
					ImGui.Spacing()

					for _, setting in pairs( Defaults.Distance )
					do
						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						DrawTooltip( setting.note )

						if toggled then
							SetOption( setting.category, setting.item, setting.defaultValue )
							setting.defaultValue = setting.defaultValue
							SaveSettings()
						end
					end

					ImGui.Spacing()
					ImGui.Text( "Skin/Hair" )
					ImGui.Spacing()

					for _, setting in pairs( Defaults.SkinHair )
					do
						setting.defaultValue = GetOption( setting.category, setting.item )
						setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
						DrawTooltip( setting.note )

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
