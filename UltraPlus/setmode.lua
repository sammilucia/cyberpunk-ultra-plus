-- setmode.lua

local var = require( "variables" )
local config = {}

function config.SetMode( mode )

	print( "---------- Ultra+: Setting mode to", mode )

	if mode == var.mode.RASTER then
		SetOption( '/graphics/raytracing', 'RayTracing', false )
		PushChanges()

		SetOption( "Developer/FeatureToggles", "RTXDI", false )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )
		SetOption( "Editor/SHARC", "Enable", "false" )
		SaveSettings()
		return
	end

	if mode == var.mode.RT_ONLY then
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		PushChanges()

		SetOption( "Developer/FeatureToggles", "RTXDI", false )
		SetOption( "Editor/ReGIR", "Enable", false )
		SetOption( "Editor/ReGIR", "UseForDI", false )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "EnableShadowCascades", false )					-- test
		SetOption( "RayTracing/Reflection", "EnableHalfResolutionTracing", "1" )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "RayTracing/Collector", "VisibilityFrustumOffset", "200.0" )
		SetOption( "RayTracing/Collector", "LocalShadowCullingRadius", "100.0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.35" )
		SetOption( "Editor/SHARC", "Enable", "false" )
		SaveSettings()
		return
	end

	if mode == var.mode.RT_PT then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		PushChanges()

		SetOption( "Developer/FeatureToggles", "RTXDI", true )
		SetOption( "RayTracing", "EnableNRD", true )
		SetOption( "Editor/ReGIR", "Enable", false )
		SetOption( "Editor/ReGIR", "UseForDI", false )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.15" )
		SetOption( "RayTracing", "EnableShadowCascades", false )					-- test
		SetOption( "RayTracing/Collector", "VisibilityFrustumOffset", "70.0" )
		SetOption( "RayTracing/Collector", "LocalShadowCullingRadius", "70.0" )
		SetOption( "RayTracing/Reflection", "EnableHalfResolutionTracing", "1" )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "EnableGradients", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.35" )				-- WAS 0.45
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "4" )
		SetOption( "Editor/RTXDI", "EnableApproximateTargetPDF", false )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", true )
		SetOption( "Editor/SHARC", "Enable", "true" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )
		SaveSettings()
		return
	end

	if mode == var.mode.VANILLA then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()

		SetOption( "Developer/FeatureToggles", "RTXDI", true )
		SetOption( "Editor/ReGIR", "Enable", false )
		SetOption( "Editor/ReGIR", "UseForDI", false )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.50" )
		SetOption( "RayTracing", "EnableShadowCascades", false )
		SetOption( "RayTracing/Collector", "VisibilityFrustumOffset", "200.0" )
		SetOption( "RayTracing/Collector", "LocalShadowCullingRadius", "100.0" )
		SetOption( "RayTracing/Reflection", "EnableHalfResolutionTracing", "1" )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableFallbackSampling", false )
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", false )
		SetOption( "Editor/RTXDI", "EnableGradients", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.5" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "2" )
		SetOption( "Editor/RTXDI", "EnableApproximateTargetPDF", false )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", false )
		SetOption( "Editor/SHARC", "Enable", "true" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()
		return
	end

	if mode == var.mode.PT21 then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()

		SetOption( "Developer/FeatureToggles", "RTXDI", true )
		SetOption( "Editor/ReGIR", "Enable", false )
		SetOption( "Editor/ReGIR", "UseForDI", false )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.15" )
		SetOption( "RayTracing", "EnableShadowCascades", true )
		SetOption( "RayTracing/Collector", "VisibilityFrustumOffset", "70.0" )
		SetOption( "RayTracing/Collector", "LocalShadowCullingRadius", "70.0" )
		SetOption( "RayTracing/Reflection", "EnableHalfResolutionTracing", "1" )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableFallbackSampling", true )				-- test 2.0
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", true )
		SetOption( "Editor/RTXDI", "EnableGradients", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.35" )				-- WAS 0.45
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "4" )
		SetOption( "Editor/RTXDI", "EnableApproximateTargetPDF", false )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", true )
		SetOption( "Editor/SHARC", "Enable", "true" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()
		return
	end

	if mode == var.mode.PT20 then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		PushChanges()

		SetOption( "Developer/FeatureToggles", "RTXDI", true )
		SetOption( "Editor/ReGIR", "Enable", false )
		SetOption( "Editor/ReGIR", "UseForDI", false )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.15" )
		SetOption( "RayTracing", "EnableShadowCascades", true )
		SetOption( "RayTracing/Collector", "VisibilityFrustumOffset", "70.0" )
		SetOption( "RayTracing/Collector", "LocalShadowCullingRadius", "70.0" )
		SetOption( "RayTracing/Reflection", "EnableHalfResolutionTracing", "1" )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "EnableGradients", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.35" )				-- WAS 0.45
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "4" )
		SetOption( "Editor/RTXDI", "EnableApproximateTargetPDF", false )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", true )
		SetOption( "Editor/SHARC", "Enable", "true" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )
		SaveSettings()
	end
end

return config
