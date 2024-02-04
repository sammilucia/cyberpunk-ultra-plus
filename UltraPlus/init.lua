-- 	Ultra+ 		(CET version)
--	version:	v0.1
--	author:		SammiLucia
--	copyright:	copy or use only with explicit consent

traceMode = "PT21"
ptSamples = "Medium"
streamer = "Medium"

local Settings = require( "settings.lua" )

function setOption( category, item, value )
    if type( value ) == "boolean" then
        GameOptions.SetBool( category, item, value )
    elseif value:match( "^%-?%d+%.%d+$" ) then
        GameOptions.SetFloat( category, item, tonumber( value ) )
    elseif value:match("^%d+$") then
        GameOptions.SetInt( category, item, tonumber( value ) )
    else
        print("Unsupported value type for option setting.")
    end
end

function commonFixes()
	print( "---------- Ultra+: Resetting all settings" )
	local category

	category = "Streaming"
		setOption( category, "DistanceBoost", "0.0" )
		setOption( category, "PrecacheDistance", "0.0" )
		setOption( category, "MaxNodesPerFrame", "300" )
		setOption( category, "MaxNodesPerFrameWhileLoading", "100000" )
		setOption( category, "MaxStreamingDistance", "8000.0" )
		setOption( category, "EditorThrottledMaxNodesPerFrame", "300" )
		setOption( category, "MinStreamingDistance", "40.0" )
		setOption( category, "TimeLimitAttachingPerFrame", "0.5" )
		setOption( category, "TimeLimitSectorLoadPerFrame", "1.5" )
		setOption( category, "TimeLimitSectorUnloadPerFrame", "1.5" )
		setOption( category, "TimeLimitStreamedPerFrame", "3.0" )
		setOption( category, "TimeLimitStreamedPerFrameWhileLoading", "8.0" )
		setOption( category, "ObserverVelocityOffsetEnabled", true )
		setOption( category, "ObserverMaxOnFootForwardVelocity", "40.0" )
		setOption( category, "ObserverMaxNonAirVehicleForwardVelocity", "600.0" )
		setOption( category, "ObserverMaxAirVehicleForwardVelocity", "200.0" )

	category = "Streaming/Editor"
		setOption( category, "TimeLimitAttachingPerFrame", "0.5" )
		setOption( category, "TimeLimitDetachingPerFrame", "1.0" )
		setOption( category, "TimeLimitStreamedPerFrame", "3.0" )
		
	category = "Editor/Streaming"
		setOption( category, "ForceAutoHideDistanceMax", "0.0" )
		
	category = "Streaming/QueryZoom"
		setOption( category, "Enabled", true )
		setOption( category, "MaxSpeed", "2.0" )
		setOption( category, "MinActivationZoomFactor", "2.0" )
		setOption( category, "MaxZoomFactor", "4.0" )

	category = "DLSS"
		setOption( category, "EnableMirrorScaling", false )
		setOption( category, "MirrorScaling", "1.0" )

	category = "FSR2"
		setOption( category, "SampleNumber", "16" )
		setOption( category, "EnableMirrorScaling", false )
		setOption( category, "MirrorScaling", "1.0" )
		
	category = "Rendering/LUT"
		setOption( category, "Size", "128" )
		setOption( category, "MinRange", "0.0000000001" )
		setOption( category, "MaxRange", "100.0" )
		
	category = "Editor/VolumetricFog"
		setOption( category, "Exponent", "5.0" )

	category = "RayTracing/NRD"
		setOption( category, "UseReblurForDirectRadiance", false )
		setOption( category, "UseReblurForIndirectRadiance", false )

	category = "RayTracing"
		setOption( category, "EnableNRD", false )
		
	category = "RayTracing/Reference"
		setOption( category, "EnableFixed", true )
		setOption( category, "EnableRIS", true )
		setOption( category, "BounceNumber", "1" )
		setOption( category, "RayNumber", "1" )
		setOption( category, "EnableProbabilisticSampling", true )
		setOption( category, "BounceNumberScreenshot", "2" )
		setOption( category, "RayNumberScreenshot", "2" )

	category = "Editor/SHARC"
		setOption( category, "Enable", true )
		setOption( category, "SerUpdate", true )
		setOption( category, "UseRTXDI", true )
		setOption( category, "UseRTXDIWithAlbedo", true )
		setOption( category, "Bounces", "4" )
		setOption( category, "UsePrevFrame", true )

	category = "Editor/ReSTIRGI"
		setOption( category, "EnableFused", true )
		setOption( category, "BiasCorrectionMode", "1" )
		setOption( category, "MaxHistoryLength", "8" )
		setOption( category, "MaxReservoirAge", "32" )
		setOption( category, "PermutationSamplingMode", "2" )				-- test 2.0
		setOption( category, "SpatialSamplingRadius", "32.0" )
		setOption( category, "BoilingFilterStrength", "0.4" )
		setOption( category, "TargetHistoryLength", "8" )
		setOption( category, "UseSpatialRGS", true )

	category = "Editor/PathTracing"
		setOption( category, "UseScreenSpaceData", true )
		setOption( category, "UseSSRFallback", true )
		
	category = "Editor/RTXDI"
		setOption( category, "BoilingFilterStrength", "0.5" )
		setOption( category, "ForcedShadowLightSourceRadius", "0.01" )		-- test 2.0
		setOption( category, "UseFusedApproach", false )
		setOption( category, "InitialCandidatesInTemporal", false )
		setOption( category, "EnableFallbackLight", true )
		setOption( category, "EnableGradients", false )
		setOption( category, "EnableEmissiveTriangleLights", false )
		setOption( category, "EnableGlobalLight", false )
		setOption( category, "EnableSeparateDenoising", true )
		setOption( category, "EnableRTXDIDenoising", true )
		
	category = "Editor/Characters/Eyes"
		setOption( category, "UseAOOnEyes", true )
		setOption( category, "DiffuseBoost", "0.4" )

	category = "Editor/Characters/Skin"
		setOption( category, "AllowSkinAmbientMix", false )
		setOption( category, "SkinAmbientMix_Factor", "1.0" )
		setOption( category, "SubsurfaceSpecularTintWeight", "0.5" )
		setOption( category, "SkinAmbientIntensity_Factor", "0.3" )
		setOption( category, "SubsurfaceSpecularTint_R", "0.26" )
		setOption( category, "SubsurfaceSpecularTint_G", "0.17" )
		setOption( category, "SubsurfaceSpecularTint_B", "0.19" )
end

function setMode( mode )
	if mode == "Vanilla" then
		print( "---------- Ultra+: Switching to Vanilla Path Tracing" )
		setOption( "RayTracing/Debug", "ReSTIRGI", true )
		setOption( "Editor/ReSTIRGI", "Enable", true )
		setOption( "Editor/ReSTIRGI", "EnableFused", true )
		setOption( "Rendering/VariableRateShading", "Enable", true )
		setOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		setOption( "Rendering/VariableRateShading", "VarianceCutoff", "0.025" )
		setOption( "Rendering/VariableRateShading", "MotionFactor", "0.75" )
		setOption( "RayTracing", "EnableImportanceSampling", true )
		setOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		setOption( "Rendering", "AllowRTXDIRejitter", false )
		setOption( "RayTracing/Multilayer", "ResolutionScaleEnable", "-1.0" )
		setOption( "RayTracing/Multilayer", "ResolutionScale", "1.0" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleNormalFactor", "1.0" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleMicroblendFactor", "0.0" )
		setOption( "Editor/ReSTIRGI", "EnableFallbackSampling", false )
		setOption( "Editor/ReSTIRGI", "EnableBoilingFilter", false )
		setOption( "Editor/ReSTIRGI", "UseTemporalRGS", false )
		setOption( "Editor/RTXDI", "MaxHistoryLength", "20" )
		setOption( "Editor/RTXDI", "EnableLocalLightImportanceSampling", false )
		setOption( "Editor/RTXDI", "BiasCorrectionMode", "2" )
		setOption( "Editor/RTXDI", "SpatialSamplingRadius", "32.0" )
		setOption( "Editor/SHARC", "SceneScale", "50.0" )
		setOption( "Editor/SHARC", "DownscaleFactor", "5" )
		setOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		warmRestart()

	elseif mode == "PT21" then
		print( "---------- Ultra+: Switching to PT21" )
		setOption( "RayTracing/Debug", "ReSTIRGI", true )
		setOption( "Editor/ReSTIRGI", "Enable", true )
		setOption( "Editor/ReSTIRGI", "EnableFused", true )
		setOption( "Rendering/VariableRateShading", "Enable", true )
		setOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		setOption( "Rendering/VariableRateShading", "VarianceCutoff", "0.05" )
		setOption( "Rendering/VariableRateShading", "MotionFactor", "0.7" )
		setOption( "RayTracing", "EnableImportanceSampling", false )
		setOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		setOption( "Rendering", "AllowRTXDIRejitter", false )
		setOption( "RayTracing/Multilayer", "ResolutionScaleEnable", "0.25" )
		setOption( "RayTracing/Multilayer", "ResolutionScale", "0.25" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleNormalFactor", "0.25" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleMicroblendFactor", "0.67" )
		setOption( "Editor/ReSTIRGI", "EnableFallbackSampling", true )
		setOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		setOption( "Editor/ReSTIRGI", "UseTemporalRGS", true )
		setOption( "Editor/RTXDI", "MaxHistoryLength", "10" )
		setOption( "Editor/RTXDI", "EnableLocalLightImportanceSampling", true )
		setOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		setOption( "Editor/RTXDI", "SpatialSamplingRadius", "16.0" )
		setOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		setOption( "Editor/SHARC", "DownscaleFactor", "7" )
		setOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		warmRestart()

	elseif mode == "PT20" then
		print( "---------- Ultra+: Switching to PT20" )
		setOption( "RayTracing/Debug", "ReSTIRGI", false )
		setOption( "Editor/ReSTIRGI", "Enable", false )
		setOption( "Editor/ReSTIRGI", "EnableFused", false )
		setOption( "Rendering/VariableRateShading", "Enable", true )
		setOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		setOption( "Rendering/VariableRateShading", "VarianceCutoff", "0.05" )
		setOption( "Rendering/VariableRateShading", "MotionFactor", "0.7" )
		setOption( "RayTracing", "EnableImportanceSampling", true )
		setOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		setOption( "Rendering", "AllowRTXDIRejitter", true )
		setOption( "RayTracing/Multilayer", "ResolutionScaleEnable", "0.25" )
		setOption( "RayTracing/Multilayer", "ResolutionScale", "0.25" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleNormalFactor", "0.25" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleMicroblendFactor", "0.67" )
		setOption( "Editor/ReSTIRGI", "EnableFallbackSampling", false )
		setOption( "Editor/ReSTIRGI", "EnableBoilingFilter", false )
		setOption( "Editor/ReSTIRGI", "UseTemporalRGS", false )
		setOption( "Editor/RTXDI", "MaxHistoryLength", "10" )
		setOption( "Editor/RTXDI", "EnableLocalLightImportanceSampling", true )
		setOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		setOption( "Editor/RTXDI", "SpatialSamplingRadius", "16.0" )
		setOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		setOption( "Editor/SHARC", "DownscaleFactor", "7" )
		setOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		warmRestart()

	elseif mode == "RTPT" then
		print( "---------- Ultra+: Switching to RTPT" )
		setOption( "RayTracing/Debug", "ReSTIRGI", false )
		setOption( "Editor/ReSTIRGI", "Enable", false )
		setOption( "Editor/ReSTIRGI", "EnableFused", false )
		setOption( "Rendering/VariableRateShading", "Enable", true )
		setOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		setOption( "Rendering/VariableRateShading", "VarianceCutoff", "0.05" )
		setOption( "Rendering/VariableRateShading", "MotionFactor", "0.7" )
		setOption( "RayTracing", "EnableImportanceSampling", true )
		setOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		setOption( "Rendering", "AllowRTXDIRejitter", true )
		setOption( "RayTracing/Multilayer", "ResolutionScaleEnable", "-1.0" )
		setOption( "RayTracing/Multilayer", "ResolutionScale", "1.0" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleNormalFactor", "1.0" )
		setOption( "RayTracing/Multilayer", "ResolutionScaleMicroblendFactor", "0.0" )
		setOption( "Editor/ReSTIRGI", "EnableFallbackSampling", false )
		setOption( "Editor/ReSTIRGI", "EnableBoilingFilter", false )
		setOption( "Editor/ReSTIRGI", "UseTemporalRGS", false )
		setOption( "Editor/RTXDI", "MaxHistoryLength", "10" )
		setOption( "Editor/RTXDI", "EnableLocalLightImportanceSampling", true )
		setOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		setOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		setOption( "Editor/SHARC", "DownscaleFactor", "7" )
		setOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		warmRestart()
	end
end

function setSamples( samples )
	if samples == "Vanilla" then
		print( "---------- Ultra+: Switching to Vanilla path tracing samples" )
		setOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "5" )
		setOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		setOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2" )
		setOption( "Editor/RTXDI", "NumInitialSamples", "8" )
		setOption( "Editor/RTXDI", "NumEnvMapSamples", "8" )
		setOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
		setOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )

	elseif samples == "Medium" then
		print( "---------- Ultra+: Switching to Medium path tracing samples" )
		setOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "7" )
		setOption( "Editor/ReSTIRGI", "SpatialNumSamples", "3" )
		setOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "4" )
		setOption( "Editor/RTXDI", "NumInitialSamples", "12" )
		setOption( "Editor/RTXDI", "NumEnvMapSamples", "12" )
		setOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
		setOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "12" )

	elseif samples == "High" then
		print( "---------- Ultra+: Switching to High path tracing samples" )
		setOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "12" )
		setOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		setOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "8" )
		setOption( "Editor/RTXDI", "NumInitialSamples", "16" )
		setOption( "Editor/RTXDI", "NumEnvMapSamples", "16" )
		setOption( "Editor/RTXDI", "SpatialNumSamples", "4" )
		setOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "14" )
		
	elseif samples == "Insane" then
		print( "---------- Ultra+: Switching to Insane path tracing samples" )
		setOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		setOption( "Editor/ReSTIRGI", "SpatialNumSamples", "6" )
		setOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "16" )
		setOption( "Editor/RTXDI", "NumInitialSamples", "16" )
		setOption( "Editor/RTXDI", "NumEnvMapSamples", "32" )
		setOption( "Editor/RTXDI", "SpatialNumSamples", "6" )
		setOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16" )
	end
end

function saveSettings()
	local thisSetting = {}
	local allCategories =
	{
		Settings.Mode,
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

function loadSettings()
	local file = io.open( "settings.json", "r" )

	if file then
		local jsonString = file:read( "*a" )
		file:close()

		local settingsTable = json.decode( jsonString )
		if settingsTable then
			print( "---------- Ultra+: Loading Settings..." )
			
			local allCategories = {
				-- Settings.Mode,
				Settings.Experimental,
				Settings.Features,
				Settings.Distance,
				Settings.SkinHair,
			}

			for _, categoryList in pairs( allCategories ) do
				for _, setting in pairs( categoryList ) do
					local settingValue = settingsTable.thisSetting[ setting.item ]
					if settingValue ~= nil then
						setting.defaultvalue = settingValue
						GameOptions.SetBool( setting.category, setting.item, setting.defaultvalue )
					end
				end
			end
		end
	end

end
function drawLine()
	ImGui.Spacing()
	ImGui.Separator()
	ImGui.Spacing()
end

function drawSection( text )	
	ImGui.Spacing()
	ImGui.Separator()
	ImGui.PushStyleColor( ImGuiCol.Text, 0xff888888 )
	ImGui.TextWrapped( text )
	ImGui.PopStyleColor()
	ImGui.Spacing()
end	

function drawTooltip( text )	
	if ImGui.IsItemHovered() and text ~= "" then
		ImGui.BeginTooltip()
		ImGui.SetTooltip( text )
		ImGui.EndTooltip()
	end
end

function drawRadio( label, subLabel, variable, value )
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

function warmRestart()
	print( "---------- Ultra+: Reloading redENGINE" )
	GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():RequestSaveUserSettings()
end

registerForEvent( "onInit", function()
	commonFixes()
	loadSettings()
	setMode( traceMode )
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
		ImGui.SetNextWindowSize( 545, 686 )
		ImGui.Begin( "Ultra+", ImGuiWindowFlags.NoResize )

		--  Text_x1, Text_y1 = ImGui.CalcTextSize( "                   " )
		width = ImGui.GetWindowContentRegionWidth()

		if ImGui.BeginTabBar( "Tabs" ) then

			-- Ultra+ Tab
			if ImGui.BeginTabItem( "Ultra+" ) then
							ImGui.Text("Settings")

				ImGui.Spacing()
				
				--[[
				for _, setting in pairs( Settings.UltraPlus ) do
					setting.defaultValue = GameOptions.GetBool( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
				]]--

				if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", traceMode == "Raster" ) then
					traceMode = "Raster"
					setMode( traceMode )
					setting.defaultValue = "Raster"
					saveSettings()
				end

				if ImGui.RadioButton( "Vanilla Path Tracing (ReSTIR, fixes only)", traceMode == "Vanilla" ) then
					traceMode = "Vanilla"
					setMode( traceMode )
					setting.defaultValue = "Vanilla"
					saveSettings()
				end

				if ImGui.RadioButton( "PT20: Fast Path Tracing (PT20: ReLAX, tweaked)", traceMode == "PT20" ) then
					traceMode = "PT20"
					setMode( traceMode )
					setting.defaultValue = "PT20"
					saveSettings()
				end

				if ImGui.RadioButton( "PT21: Ultra+ Path Tracing (PT21: ReSTIR, tweaked)", traceMode == "PT21" ) then
					traceMode = "PT21"
					setMode( traceMode )
					setting.defaultValue = "PT21"
					saveSettings()
				end

				if ImGui.RadioButton( "RTPT: Ray Tracing plus Path Tracing", traceMode == "RTPT" ) then
					traceMode = "RTPT"
					setMode( traceMode )
					setting.defaultValue = "RTPT"
					saveSettings()
				end
				
				drawSection( "The number of path tracing samples affects both boiling, and edge noise: Higher samples = less noise." )

				if ImGui.RadioButton( "Vanilla Path Tracing Samples", ptSamples == "Vanilla" ) then
					ptSamples = "Vanilla"
					setSamples( ptSamples )
					-- setting.defaultValue = ptSamples
					-- saveSettings()
				end

				if ImGui.RadioButton( "Medium Path Tracing Samples", ptSamples == "Medium" ) then
					ptSamples = "Medium"
					setSamples( ptSamples )
					-- setting.defaultValue = ptSamples
					-- saveSettings()
				end

				if ImGui.RadioButton( "High Path Tracing Samples", ptSamples == "High" ) then
					ptSamples = "High"
					setSamples( ptSamples )
					-- setting.defaultValue = ptSamples
					-- saveSettings()
				end

				if ImGui.RadioButton( "Insane Path Tracing Samples", ptSamples == "Insane" ) then
					ptSamples = "Insane"
					setSamples( ptSamples )
					-- setting.defaultValue = ptSamples
					-- saveSettings()
				end
				
				drawSection( "Experimental" )
				
				ImGui.Spacing()
				
				for _, setting in pairs( Settings.Experimental ) 
				do
					setting.defaultValue = GameOptions.GetBool( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					drawTooltip( setting.note )

					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
						setting.defaultValue = setting.defaultValue
						saveSettings()
					end
				end
				
				drawLine()

				if ImGui.Button( "Reset All Settings" ) then
					commonFixes()
					loadSettings()
					setMode( traceMode )
				end
				
				ImGui.SameLine()
				if ImGui.Button( "Load Settings" ) then
					loadSettings()
				end
				
				ImGui.SameLine()
				if ImGui.Button( "Save Settings" ) then
					saveSettings()
				end
				
				ImGui.SameLine()
				if ImGui.Button( "Warm Restart" ) then
					warmRestart()
				end
				
				ImGui.EndTabItem()
			end

			-- Features Tab
			if ImGui.BeginTabItem( "Features" ) then
				ImGui.Spacing()

				for _, setting in pairs( Settings.Features ) 
				do
					setting.defaultValue = GameOptions.GetBool( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					drawTooltip( setting.note )
	
					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
						setting.defaultValue = setting.defaultValue
						saveSettings()
					end
				end
				ImGui.EndTabItem()
			end

			-- Distance Tab
			if ImGui.BeginTabItem( "Distance" ) then
				ImGui.Spacing()

				for _, setting in pairs( Settings.Distance )
				do
					setting.defaultValue = GameOptions.GetBool( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					drawTooltip( setting.note )

					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
						setting.defaultValue = setting.defaultValue
						saveSettings()
					end
				end
				ImGui.EndTabItem()
			end

			-- Skin/Hair Tab
			if ImGui.BeginTabItem( "Skin/Hair" ) then
				ImGui.Spacing()

				for _, setting in pairs( Settings.SkinHair )
				do
					setting.defaultValue = GameOptions.GetBool( setting.category, setting.item )
					setting.defaultValue, toggled = ImGui.Checkbox( setting.name, setting.defaultValue )
					drawTooltip( setting.note )

					if toggled then
						GameOptions.SetBool( setting.category, setting.item, setting.defaultValue )
						setting.defaultValue = setting.defaultValue
						saveSettings()
					end
				end
				ImGui.EndTabItem()
			end

			ImGui.EndTabBar()
		end

		ImGui.End()
	end
end)
