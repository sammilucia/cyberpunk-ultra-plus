_var = require( "variables" )

local config = {}

function config.SetMode( mode )
	if mode == _var.mode.raster then
		print( "---------- Ultra+: Switching to Raster" )
		SetOption( '/graphics/raytracing', 'RayTracing', false )
		PushChanges()

		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )
		SaveSettings()

	elseif mode == _var.mode.rtOnly then
		print( "---------- Ultra+: Switching to RTPT" )
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		PushChanges()

		SetOption( "RayTracing", "EnableNRD", false )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "EnableShadowCascades", false )					-- test
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.35" )
		SaveSettings()

	elseif mode == _var.mode.rtpt then
		print( "---------- Ultra+: Switching to RTPT" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		PushChanges()

		SetOption( "/graphics/presets", "DLSS_D", false )
		SetOption( "RayTracing", "EnableNRD", true )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.20" )
		SetOption( "RayTracing", "EnableShadowCascades", false )					-- test
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering", "AllowRayTracedReferenceRejitter", true )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "20.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.25" )
		SetOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )
		SaveSettings()

	elseif mode == _var.mode.vanilla then
		print( "---------- Ultra+: Switching to Vanilla Path Tracing" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()
		--ForceDlssd()

		-- if DLAA then use NRD, not RR (let engine switch on NRD)
		print( GetOption( "/graphics/presets", "DLSS" ) )
		if GetOption( "/graphics/presets", "DLSS" ) == _var.dlss.dlaa then
			SetOption( "/graphics/presets", "DLSS_D", false )
		end
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.50" )
		SetOption( "RayTracing", "EnableShadowCascades", false )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering", "AllowRayTracedReferenceRejitter", false )
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

	elseif mode == _var.mode.pt21 then
		print( "---------- Ultra+: Switching to PT21" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()

		-- if DLAA then use NRD, not RR (let engine switch on NRD)
		print( GetOption( "/graphics/presets", "DLSS" ) )
		if GetOption( "/graphics/presets", "DLSS" ) == _var.dlss.dlaa then
			SetOption( "/graphics/presets", "DLSS_D", false )
		end
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", false )
		SetOption( "RayTracing", "SunAngularSize", "0.20" )
		SetOption( "RayTracing", "EnableShadowCascades", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering", "AllowRayTracedReferenceRejitter", false )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableFallbackSampling", true )			-- test 2.0
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", true )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "20.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.25" )
		SetOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()

	elseif mode == _var.mode.pt20 then
		print( "---------- Ultra+: Switching to PT20" )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()

		-- if DLAA then use NRD, not RR (let engine switch on NRD)
		print( GetOption( "/graphics/presets", "DLSS" ) )
		if GetOption( "/graphics/presets", "DLSS" ) == _var.dlss.dlaa then
			SetOption( "/graphics/presets", "DLSS_D", false )
		end
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.20" )
		SetOption( "RayTracing", "EnableShadowCascades", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering", "AllowRayTracedReferenceRejitter", true )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "SpatialSamplingRadius", "20.0" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.25" )
		SetOption( "Editor/SHARC", "SceneScale", "33.3333333333" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "7" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()
	end
end

return config
