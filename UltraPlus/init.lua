local ultraplus = {
  __VERSION     = 'ultraplus.lua 0.2',
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

local Settings = require( "settings.lua" )

currentMode = "Unknown"
ptSamples = "Fast"
streamer = "Medium"

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

function SetOption( category, item, value )
	-- handle graphics settings
	if category:match( "^/" ) then
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

function GetOption( category, item )
	local value = nil

	-- handle graphics settings
	if category:match( "^/" ) then
		value = Game.GetSettingsSystem():GetVar( category, item ):GetValue()
	else
		--handle ini settings
		value = GameOptions.GetBool( category, item )
--[[
		if value == "true" then
			value = true
		elseif value == "false" then
			value = false
		elseif string.match( value, "^%-?%d+%.%d+$" ) then
			value = tonumber(
		elseif string.match( value, "^%-?%d+$"" ) then
]]--
	end

    return value
end

function PushChanges()
	Wait( 0.1 )
	Game.GetSettingsSystem():ConfirmChanges()
end

function EnableDlssd()
    local checkDlssd = GetOption( '/graphics/presets', 'DLSS_D' )

    while checkDlssd == false do
		print( '/graphics/presets/DLSS_D = ', checkDlssd )

		SetOption( "/graphics/presets", "DLSS_D", true )
		Wait( 0.1 )

        checkDlssd = GetOption( '/graphics/presets', 'DLSS_D' )
    end

	print( '/graphics/presets/DLSS_D = ', checkDlssd )
	PushChanges()
	--SetOption( "RayTracing", "EnableNRD", false )
	SaveSettings()
end

function CommonFixes()
	print( "---------- Ultra+: Resetting all settings" )
	local category

	category = "Streaming"
		SetOption( category, "MaxNodesPerFrame", "300" )
		SetOption( category, "MaxNodesPerFrameWhileLoading", "100000" )
		SetOption( category, "MaxStreamingDistance", "8000.0" )
		SetOption( category, "EditorThrottledMaxNodesPerFrame", "300" )
		SetOption( category, "TimeLimitAttachingPerFrame", "0.5" )
		SetOption( category, "TimeLimitSectorLoadPerFrame", "2.0" )
		SetOption( category, "TimeLimitSectorUnloadPerFrame", "2.0" )
		SetOption( category, "TimeLimitStreamedPerFrame", "3.0" )
		SetOption( category, "TimeLimitStreamedPerFrameWhileLoading", "8.0" )
		SetOption( category, "ObserverVelocityOffsetEnabled", true )
		SetOption( category, "ObserverMaxOnFootForwardVelocity", "40.0" )
		SetOption( category, "ObserverMaxNonAirVehicleForwardVelocity", "600.0" )
		SetOption( category, "ObserverMaxAirVehicleForwardVelocity", "200.0" )

	category = "Streaming/Editor"
		SetOption( category, "TimeLimitAttachingPerFrame", "0.5" )
		SetOption( category, "TimeLimitDetachingPerFrame", "1.0" )
		SetOption( category, "TimeLimitStreamedPerFrame", "3.0" )
		
	category = "Editor/Streaming"
		SetOption( category, "ForceAutoHideDistanceMax", "0.0" )
		
	category = "Streaming/QueryZoom"
		SetOption( category, "Enabled", true )
		SetOption( category, "MaxSpeed", "2.0" )
		SetOption( category, "MinActivationZoomFactor", "2.0" )
		SetOption( category, "MaxZoomFactor", "4.0" )

	category = "DLSS"
		SetOption( category, "SampleNumber", "24" )
		SetOption( category, "EnableMirrorScaling", false )
		SetOption( category, "MirrorScaling", "1.0" )

	category = "FSR2"
		SetOption( category, "SampleNumber", "24" )
		SetOption( category, "EnableMirrorScaling", false )
		SetOption( category, "MirrorScaling", "1.0" )
		
	category = "Rendering/LUT"
		SetOption( category, "Size", "64" )
		SetOption( category, "MinRange", "0.0000000001" )
		SetOption( category, "MaxRange", "100.0" )
		
	category = "Editor/VolumetricFog"
		SetOption( category, "Exponent", "5.0" )

	category = "RayTracing/NRD"
		SetOption( category, "UseReblurForDirectRadiance", false )
		SetOption( category, "UseReblurForIndirectRadiance", false )

	category = "RayTracing/Reference"
		SetOption( category, "BounceNumber", "1" )
		SetOption( category, "RayNumber", "1" )
		SetOption( category, "EnableProbabilisticSampling", true )
		SetOption( category, "BounceNumberScreenshot", "2" )
		SetOption( category, "RayNumberScreenshot", "3" )

	category = "Editor/ReSTIRGI"
		SetOption( category, "PermutationSamplingMode", "2" )
		SetOption( category, "EnableBoilingFilter", false )
		SetOption( category, "UseTemporalRGS", true )

	category = "Editor/SHARC"
		SetOption( category, "Enable", true )

	category = "Editor/PathTracing"
		SetOption( category, "UseScreenSpaceData", true )

	category = "Editor/Characters/Eyes"
		SetOption( category, "UseAOOnEyes", true )

	category = "Editor/Characters/Skin"
		SetOption( category, "AllowSkinAmbientMix", false )
		SetOption( category, "SkinAmbientMix_Factor", "1.0" )
		SetOption( category, "SubsurfaceSpecularTintWeight", "0.5" )
		SetOption( category, "SkinAmbientIntensity_Factor", "0.3" )
		SetOption( category, "SubsurfaceSpecularTint_R", "0.26" )
		SetOption( category, "SubsurfaceSpecularTint_G", "0.17" )
		SetOption( category, "SubsurfaceSpecularTint_B", "0.19" )
end

function SetMode( mode )
	if mode == "Raster" then
		print( "---------- Ultra+: Switching to Raster" )
		SetOption( '/graphics/raytracing', 'RayTracing', false )
		PushChanges()

		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )
		SaveSettings()

	elseif mode == "RTOnly" then
		print( "---------- Ultra+: Switching to RTPT" )
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		PushChanges()
		--EnableDlssd()

		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.35" )
		SaveSettings()

	elseif mode == "RTPT" then
		print( "---------- Ultra+: Switching to RTPT" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		PushChanges()
		--EnableDlssd()

		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering", "AllowRTXDIRejitter", true )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "20.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.02" )
		SetOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.35" )
		SaveSettings()

	elseif mode == "Vanilla" then
		print( "---------- Ultra+: Switching to Vanilla Path Tracing" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()
		--EnableDlssd()

		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering", "AllowRTXDIRejitter", false )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", false )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "20" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.5" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "2" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "32.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "1.0" )
		SetOption( "Editor/SHARC", "SceneScale", "50.0" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "5" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()

	elseif mode == "PT21" then
		print( "---------- Ultra+: Switching to PT21" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()
		--EnableDlssd()

		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", false )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering", "AllowRTXDIRejitter", false )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableFallbackSampling", true )			-- test 2.0
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", true )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "20.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.02" )
		SetOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()

	elseif mode == "PT20" then
		print( "---------- Ultra+: Switching to PT20" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()
		--EnableDlssd()

		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering", "AllowRTXDIRejitter", true )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "20.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.02" )
		SetOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()
	end
end

function SetSamples( samples )
	if samples == "Vanilla" then
		print( "---------- Ultra+: Switching to Vanilla RTXDI samples" )
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "5" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "8" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "8" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
		SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )

	elseif samples == "Fast" then
		print( "---------- Ultra+: Switching to Fast RTXDI samples" )
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "16" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "0" )
		SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )

	elseif samples == "High" then
		print( "---------- Ultra+: Switching to High RTXDI samples" )
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "16" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
		SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
	end
end

function SaveSettings()
	local thisSetting = {}
	local allCategories =
	{
		Settings.Experimental,
		Settings.Features,
		Settings.Distance,
		Settings.SkinHair,
	}

	for _, categoryList in pairs( allCategories ) do
		for _, setting in pairs( categoryList ) do
			thisSetting[ setting.item ] = setting.defaultValue
		end
	end

	local settingsTable = { thisSetting = thisSetting }
	local jsonString = json.encode( settingsTable )

	local file = io.open( "settings.json", "w" )
	if file then
		print( "---------- Ultra+: Saving Settings..." )
		
		file:write( jsonString )
		file:close()
	end
end

function guessMode()
	local guess = "Unknown"

	local reJitter    = GetOption( "Rendering", "AllowRTXDIRejitter" )
	local reStir      = GetOption( "Editor/ReSTIRGI", "Enable" )
	local pathTracing = GetOption( "/graphics/raytracing", "RayTracedPathTracing" )
	local rayTracing  = GetOption( "/graphics/raytracing", "RayTracing" )
	
	print( "reJitter:", reJitter, "reStir:", reStir, "pathTracing:", pathTracing, "rayTracing:", rayTracing )

	if rayTracing == false then
		guess = "Raster"
	elseif pathTracing == false and rayTracing == true and reJitter == false then
		guess = "RTOnly"
	elseif pathTracing == false and rayTracing == true and reJitter == true then
		guess = "RTPT"
	elseif pathTracing == true and reStir == false then
		guess = "PT20"
	elseif pathTracing == true and reStir == true and reJitter == true then
		guess = "PT21"
	elseif pathTracing == true and reStir == true and reJitter == false then
		guess = "Vanilla"
	else
		print( "---------- Ultra+: Could not guess current rendering mode." )
	end
	
	print( "---------- Ultra+: Guessed rendering mode is", guess )
	return guess
end

function LoadSettings()
	local file = io.open( "settings.json", "r" )

	if file then
		local jsonString = file:read( "*a" )
		file:close()

		local settingsTable = json.decode( jsonString )

		if settingsTable then
			print( "---------- Ultra+: Loading Settings..." )
			
			local allCategories = {
				Settings.Experimental,
				Settings.Features,
				Settings.Distance,
				Settings.SkinHair,
			}

			for _, categoryList in pairs( allCategories )
			do
				for _, setting in pairs( categoryList ) 
				do
					local settingValue = settingsTable.thisSetting[ setting.item ]
					if settingValue ~= nil
					then
						setting.defaultvalue = settingValue
						SetOption( setting.category, setting.item, setting.defaultvalue )
					end
				end
			end
		end
	end
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

function DrawRadio( label, subLabel, variable, value )
    local clicked = ImGui.RadioButton( "##" .. label, variable == value )
    ImGui.SameLine()

    -- main label
    ImGui.Text(label)
    ImGui.SameLine()

    -- sublabel
    ImGui.PushStyleColor( ImGuiCol.Text, 0xff888888 )
    ImGui.Text( subLabel )
    ImGui.PopStyleColor()

    -- update when clicked
    if clicked then
        variable = value
    end

    return variable
end

function ResetEngine()
	print( "---------- Ultra+: Reloading redENGINE" )
	GetSingleton( "inkMenuScenario" ):GetSystemRequestsHandler():RequestSaveUserSettings()
end

registerForEvent( "onInit", function()
	CommonFixes()
	LoadSettings()
	currentMode = guessMode()
	SetMode( currentMode )
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
		ImGui.SetNextWindowSize( 550, 818 )
		ImGui.Begin( "Ultra+ Control", ImGuiWindowFlags.NoResize )

		width = ImGui.GetWindowContentRegionWidth()

		if ImGui.BeginTabBar( "Tabs" ) then

			-- Ultra+ Tab
			if ImGui.BeginTabItem( "Engine Config" ) then
				local newMode = currentMode

				ImGui.Text("Settings")
				ImGui.Spacing()		

				if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", newMode == "Raster" ) then
					currentMode = "Raster"
					SetMode( currentMode )
				end

				if ImGui.RadioButton( "Ray Tracing: Normal Ray Tracing", newMode == "RTOnly" ) then
					currentMode = "RTOnly"
					SetMode( currentMode )
				end

				if ImGui.RadioButton( "RT+PT: Ray Tracing plus Path Tracing", newMode == "RTPT" ) then
					currentMode = "RTPT"
					SetMode( currentMode )
				end

				if ImGui.RadioButton( "Vanilla Path Tracing (no tweaks, bugfixes only)", newMode == "Vanilla" ) then
					currentMode = "Vanilla"
					SetMode( currentMode )
				end

				if ImGui.RadioButton( "PT20: Fast Path Tracing (RTXDI+ReLAX, tweaked)", newMode == "PT20" ) then
					currentMode = "PT20"
					SetMode( currentMode )
				end

				if ImGui.RadioButton( "PT21: Ultra+ Path Tracing (RTXDI+ReSTIR, tweaked)", newMode == "PT21" ) then
					currentMode = "PT21"
					SetMode( currentMode )
				end
				
				DrawSection( "The number of path tracing samples affects both boiling, and edge noise: Higher samples = less noise." )

				if ImGui.RadioButton( "Vanilla RTXDI samples (spatial sampling: On)", ptSamples == "Vanilla" ) then
					ptSamples = "Vanilla"
					SetSamples( ptSamples )
				end

				if ImGui.RadioButton( "Fast RTXDI samples (spatial sampling: Off)", ptSamples == "Fast" ) then
					ptSamples = "Fast"
					SetSamples( ptSamples )
				end

				if ImGui.RadioButton( "High RTXDI samples (spatial sampling: On)", ptSamples == "High" ) then
					ptSamples = "High"
					SetSamples( ptSamples )
				end

				DrawSection( "Experimental" )
				ImGui.Spacing()
				
				for _, setting in pairs( Settings.Experimental ) 
				do
					setting.defaultValue = GetOption( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					DrawTooltip( setting.note )

					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
						setting.defaultValue = setting.defaultValue
						SaveSettings()
					end
				end
				
				DrawLine()
				
				if ImGui.Button( "(Re)load All" ) then
					CommonFixes()
					LoadSettings()
					SetMode( currentMode )
				end
				
				ImGui.SameLine()
				if ImGui.Button( "Save All" ) then
					SaveSettings()
				end

				ImGui.SameLine()
				if ImGui.Button( "Force Ray Reconstruction" ) then
					EnableDlssd()
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

				for _, setting in pairs( Settings.Features ) 
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

				for _, setting in pairs( Settings.Distance )
				do
					setting.defaultValue = GetOption( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					DrawTooltip( setting.note )

					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
						setting.defaultValue = setting.defaultValue
						SaveSettings()
					end
				end

				ImGui.Spacing()
				ImGui.Text( "Skin/Hair" )
				ImGui.Spacing()

				for _, setting in pairs( Settings.SkinHair )
				do
					setting.defaultValue = GetOption( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					DrawTooltip( setting.note )

					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
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
end)