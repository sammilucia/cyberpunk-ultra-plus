-- setmode.lua

local var = require( "variables" )
local config = {}

function config.setMode( mode )

	print( "---------- Ultra+: Switching to", mode )

	if mode == var.mode.RASTER
	then
		SetOption( '/graphics/raytracing', 'RayTracing', false )
		PushChanges()

		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )

		SaveSettings()
	elseif mode == var.mode.RT_ONLY
	then
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

	elseif mode == var.mode.RT_PT
	then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( '/graphics/raytracing', 'RayTracedPathTracing', false )
		PushChanges()

		-- SetOption( "/graphics/presets", "DLSS_D", false )
		SetOption( "RayTracing", "EnableNRD", true )
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.20" )
		SetOption( "RayTracing", "EnableShadowCascades", false )					-- test
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.25" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", true )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.15" )

		SaveSettings()
	elseif mode == var.mode.VANILLA
	then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )
		
		PushChanges()

		if GetOption( "/graphics/presets", "DLSS" ) == var.dlss.DLAA
		then
			-- SetOption( "/graphics/presets", "DLSS_D", false )
		end
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "1" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.50" )
		SetOption( "RayTracing", "EnableShadowCascades", false )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.5" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "2" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "1.0" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", false )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )

		SaveSettings()

	elseif mode == var.mode.PT21
	then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )

		PushChanges()

		if GetOption( "/graphics/presets", "DLSS" ) == var.dlss.DLAA
		then
			-- SetOption( "/graphics/presets", "DLSS_D", false )
		end
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.20" )
		SetOption( "RayTracing", "EnableShadowCascades", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "1" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", true )
		SetOption( "Editor/ReSTIRGI", "EnableFallbackSampling", true )			-- test 2.0
		SetOption( "Editor/ReSTIRGI", "EnableBoilingFilter", true )
		SetOption( "Editor/ReSTIRGI", "UseTemporalRGS", true )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.25" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", true )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )

		SaveSettings()

	elseif mode == var.mode.PT20
	then
		SetOption( '/graphics/raytracing', 'RayTracing', true )
		SetOption( "/graphics/raytracing", "RayTracedPathTracing", true )

		PushChanges()

		if GetOption( "/graphics/presets", "DLSS" ) == var.dlss.DLAA
		then
			-- SetOption( "/graphics/presets", "DLSS_D", false )
		end
		SetOption( "RayTracing", "AmbientOcclusionRayNumber", "0" )
		SetOption( "RayTracing", "EnableImportanceSampling", true )
		SetOption( "RayTracing", "SunAngularSize", "0.20" )
		SetOption( "RayTracing", "EnableShadowCascades", true )
		SetOption( "RayTracing/Diffuse", "EnableHalfResolutionTracing", "0" )
		SetOption( "Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0" )
		SetOption( "Editor/ReSTIRGI", "Enable", false )
		SetOption( "Editor/RTXDI", "BoilingFilterStrength", "0.45" )
		SetOption( "Editor/RTXDI", "BiasCorrectionMode", "1" )
		SetOption( "Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.25" )
		SetOption( "Editor/RTXDI", "EnableEmissiveProxyLightRejection", true )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		SetOption( "Editor/Characters/Eyes", "DiffuseBoost", "0.4" )

		SaveSettings()
	end
end

return config
