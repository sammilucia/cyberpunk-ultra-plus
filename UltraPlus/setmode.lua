-- setmode.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetMode(mode)
    logger.info("Setting mode to", mode)

    if mode == var.mode.RASTER then
        SetOption("/graphics/raytracing", "RayTracing", false)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", false)
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.15")
        SetOption("Editor/SHARC", "Enable", false)
        SaveSettings()
        return
    end

    if mode == var.mode.RT_ONLY then
        SetOption("/graphics/raytracing", "RayTracedPathTracing", false)
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("Editor/ReGIR", "Enable", false)
        SetOption("Editor/ReGIR", "UseForDI", false)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", false)
        SetOption("Rendering", "AllowRTXDIRejitter", false)
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "1")
        SetOption("RayTracing", "SunAngularSize", "0.20")
        SetOption("RayTracing", "EnableShadowCascades", false)						-- test with RT
        SetOption("RayTracing", "EnableGlobalShadow", true)
        SetOption("RayTracing", "EnableLocalShadow", true)
        SetOption("RayTracing", "EnableTransparentReflection", true)
        SetOption("RayTracing", "EnableDiffuseIllumination", true)
        SetOption("RayTracing", "EnableAmbientOcclusion", true)
        SetOption("RayTracing", "EnableReflection", true)
        SetOption("RayTracing", "EnableShadowOptimizations", true)
        -- SetOption("RayTracing", "EnableGlobalIllumination", false)
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "200.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "100.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Reflection", "AdaptiveSampling", true)
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "0")
        SetOption("RayTracing/Diffuse", "AdaptiveSampling", true)
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0")
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.35")
        SetOption("Editor/SHARC", "Enable", false)
        SaveSettings()
        return
    end

    if mode == var.mode.RT_PT then
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("/graphics/raytracing", "RayTracedPathTracing", false)
        SetOption("Editor/ReGIR", "Enable", false)
        SetOption("Editor/ReGIR", "UseForDI", false)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", true)
        SetOption("Developer/FeatureToggles", "ScreenSpaceReflection", false)
        SetOption("Developer/FeatureToggles", "ScreenSpacePlanarReflection", false)
        SetOption("Rendering", "AllowRTXDIRejitter", true) 
        SetOption("RayTracing", "EnableNRD", true)
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "1")
        SetOption("RayTracing", "SunAngularSize", "0.20")
        SetOption("RayTracing", "EnableShadowCascades", false)						-- test with RT
        SetOption("RayTracing", "EnableGlobalShadow", true)
        SetOption("RayTracing", "EnableLocalShadow", true)
        SetOption("RayTracing", "EnableTransparentReflection", true)
        SetOption("RayTracing", "EnableDiffuseIllumination", true)
        SetOption("RayTracing", "EnableAmbientOcclusion", true)
        SetOption("RayTracing", "EnableReflection", true)
        SetOption("RayTracing", "EnableShadowOptimizations", true)
        SetOption("RayTracing", "EnableGlobalIllumination", false)
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "70.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "70.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Reflection", "AdaptiveSampling", true)
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "0")
        SetOption("RayTracing/Diffuse", "AdaptiveSampling", true)
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0")
        SetOption("Editor/ReSTIRGI", "Enable", false)
        SetOption("Editor/ReSTIRGI", "EnableFused", false)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", false)
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", false)
        SetOption("Editor/ReSTIRGI", "UseSpatialRGS", false)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", false)
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "0")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "0")
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "3")
        SetOption("Editor/ReSTIRGI", "SpatialSamplingRadius", "64.0")
        SetOption("Editor/RTXDI", "SpatialSamplingRadius", "64.0")
        SetOption("Editor/RTXDI", "EnableGradients", true)
        SetOption("Editor/RTXDI", "InitialCandidatesInTemporal", true)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)		-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)						-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")					-- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)						-- TEST
        SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16")
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.15")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", true)
        SaveSettings()
        return
    end

    if mode == var.mode.VANILLA then
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("/graphics/raytracing", "RayTracedPathTracing", true)
        SetOption("Editor/ReGIR", "Enable", false)
        SetOption("Editor/ReGIR", "UseForDI", false)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", true)
        SetOption("Developer/FeatureToggles", "ScreenSpaceReflection", true)
        SetOption("Developer/FeatureToggles", "ScreenSpacePlanarReflection", true)
        SetOption("Rendering", "AllowRTXDIRejitter", false) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "1")
        SetOption("RayTracing", "SunAngularSize", "0.5")
        SetOption("RayTracing", "EnableShadowCascades", false)
        SetOption("RayTracing", "EnableGlobalShadow", true)
        SetOption("RayTracing", "EnableLocalShadow", true)
        SetOption("RayTracing", "EnableTransparentReflection", true)
        SetOption("RayTracing", "EnableDiffuseIllumination", true)
        SetOption("RayTracing", "EnableAmbientOcclusion", true)
        SetOption("RayTracing", "EnableReflection", true)
        SetOption("RayTracing", "EnableShadowOptimizations", true)
        SetOption("RayTracing", "EnableGlobalIllumination", false)
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "200.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "100.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Reflection", "AdaptiveSampling", true)
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "AdaptiveSampling", true)
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0")
        SetOption("Editor/ReSTIRGI", "Enable", true)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", false)
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", false)
        SetOption("Editor/ReSTIRGI", "BoilingFilterStrength", "0.4")
        SetOption("Editor/ReSTIRGI", "UseSpatialRGS", true)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", false)
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "8")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "8")
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "1")
        SetOption("Editor/ReSTIRGI", "SpatialSamplingRadius", "32.0")
        SetOption("Editor/RTXDI", "SpatialSamplingRadius", "32.0")
        SetOption("Editor/RTXDI", "EnableGradients", false)
        SetOption("Editor/RTXDI", "InitialCandidatesInTemporal", false)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)
        SetOption("Editor/RTXDI", "EnableFallbackLight", true)
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.5")
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "2")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", false)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)
        SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25")
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.1")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", false)
        SaveSettings()
        return
    end

    if mode == var.mode.PT21 then
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("/graphics/raytracing", "RayTracedPathTracing", true)
        SetOption("Editor/ReGIR", "Enable", false)
        SetOption("Editor/ReGIR", "UseForDI", false)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", true)
        SetOption("Developer/FeatureToggles", "ScreenSpaceReflection", false)
        SetOption("Developer/FeatureToggles", "ScreenSpacePlanarReflection", false)
        SetOption("Rendering", "AllowRTXDIRejitter", true) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "0")
        SetOption("RayTracing", "SunAngularSize", "0.20")
        SetOption("RayTracing", "EnableShadowCascades", false)						-- TEST
        SetOption("RayTracing", "EnableGlobalShadow", true)
        SetOption("RayTracing", "EnableLocalShadow", false)							-- TEST
        SetOption("RayTracing", "EnableTransparentReflection", false)				-- TEST
        SetOption("RayTracing", "EnableDiffuseIllumination", false)					-- TEST
        SetOption("RayTracing", "EnableAmbientOcclusion", false)					-- TEST
        SetOption("RayTracing", "EnableReflection", false)							-- TEST
        SetOption("RayTracing", "EnableShadowOptimizations", false)					-- TEST
        SetOption("RayTracing", "EnableGlobalIllumination", false)					-- TEST
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "70.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "70.0")
        SetOption("RayTracing/Reference", "EnableFixed", true)
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Reflection", "AdaptiveSampling", true)				-- TEST
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "AdaptiveSampling", true)					-- TEST
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0")
        SetOption("Editor/ReSTIRGI", "Enable", true)
        SetOption("Editor/ReSTIRGI", "EnableFused", true)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", true)				-- TEST
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", true)
        SetOption("Editor/ReSTIRGI", "BoilingFilterStrength", "0.4")
        SetOption("Editor/ReSTIRGI", "UseSpatialRGS", true)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", true)
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "8")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "6")
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "3")
        SetOption("Editor/ReSTIRGI", "SpatialSamplingRadius", "64.0")
        SetOption("Editor/RTXDI", "SpatialSamplingRadius", "64.0")
        SetOption("Editor/RTXDI", "EnableGradients", true)
        SetOption("Editor/RTXDI", "InitialCandidatesInTemporal", true)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)		-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)						-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")					-- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)
        SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25")
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.4")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", true)
        SaveSettings()
        return
    end

    if mode == var.mode.PT20 then
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("/graphics/raytracing", "RayTracedPathTracing", true)
        SetOption("Editor/ReGIR", "Enable", false)
        SetOption("Editor/ReGIR", "UseForDI", false)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", true)
        SetOption("Developer/FeatureToggles", "ScreenSpaceReflection", false)
        SetOption("Developer/FeatureToggles", "ScreenSpacePlanarReflection", false)
        SetOption("Rendering", "AllowRTXDIRejitter", true) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "0")
        SetOption("RayTracing", "SunAngularSize", "0.20")
        SetOption("RayTracing", "EnableShadowCascades", false)						-- TEST
        SetOption("RayTracing", "EnableGlobalShadow", true)
        SetOption("RayTracing", "EnableLocalShadow", false)							-- TEST
        SetOption("RayTracing", "EnableTransparentReflection", false)				-- TEST
        SetOption("RayTracing", "EnableDiffuseIllumination", false)					-- TEST
        SetOption("RayTracing", "EnableAmbientOcclusion", false)					-- TEST
        SetOption("RayTracing", "EnableReflection", false)							-- TEST
        SetOption("RayTracing", "EnableShadowOptimizations", false)					-- TEST
        SetOption("RayTracing", "EnableGlobalIllumination", false)					-- TEST
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "50.0")		-- WAS 70.0 improves RTXDI light/shadow selection
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "50.0")		-- WAS 70.0
        SetOption("RayTracing/Reference", "EnableFixed", true)
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Reflection", "AdaptiveSampling", false)
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "0")
        SetOption("RayTracing/Diffuse", "AdaptiveSampling", false)
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0")
        SetOption("Editor/ReSTIRGI", "Enable", false)
        SetOption("Editor/ReSTIRGI", "EnableFused", false)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", false)
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", false)
        SetOption("Editor/ReSTIRGI", "UseSpatialRGS", false)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", false)
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "0")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "0")
        SetOption("Editor/ReSTIRGI", "SpatialSamplingRadius", "64.0")
        SetOption("Editor/RTXDI", "SpatialSamplingRadius", "64.0")
        SetOption("Editor/RTXDI", "EnableGradients", true)
        SetOption("Editor/RTXDI", "InitialCandidatesInTemporal", true)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)		-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)						-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")					-- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)						-- TEST
        SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16")
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.4")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", true)
        SaveSettings()
    end

    if mode == var.mode.PTNEXT then
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("/graphics/raytracing", "RayTracedPathTracing", true)
        SetOption("Editor/ReGIR", "Enable", true)
        SetOption("Editor/ReGIR", "UseForDI", true)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", true)
        SetOption("Developer/FeatureToggles", "ScreenSpaceReflection", false)
        SetOption("Developer/FeatureToggles", "ScreenSpacePlanarReflection", false)
        SetOption("Rendering", "AllowRTXDIRejitter", false) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "0")
        SetOption("RayTracing", "SunAngularSize", "0.20")
        SetOption("RayTracing", "EnableShadowCascades", false)
        SetOption("RayTracing", "EnableGlobalShadow", true)
        SetOption("RayTracing", "EnableLocalShadow", true)
        SetOption("RayTracing", "EnableTransparentReflection", false)
        SetOption("RayTracing", "EnableDiffuseIllumination", false)
        SetOption("RayTracing", "EnableAmbientOcclusion", false)
        SetOption("RayTracing", "EnableReflection", false)
        SetOption("RayTracing", "EnableShadowOptimizations", true)
        SetOption("RayTracing", "EnableGlobalIllumination", false)
        SetOption("RayTracing", "EnableImportanceSampling", false)					-- TEST
        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        -- SetOption("RayTracing/Debug", "HitDistance", true)						-- TEST
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "200.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "100.0")
        SetOption("RayTracing/Reference", "EnableFixed", false)
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Reflection", "AdaptiveSampling", false)
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "AdaptiveSampling", false)
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0")
        SetOption("Editor/ReSTIRGI", "Enable", true)
        SetOption("Editor/ReSTIRGI", "EnableFused", true)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", true)				-- test 2.0
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", false)
        SetOption("Editor/ReSTIRGI", "BoilingFilterStrength", "0.2")
        SetOption("Editor/ReSTIRGI", "UseSpatialRGS", true)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", true)
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "3")
        SetOption("Editor/ReSTIRGI", "SpatialSamplingRadius", "20.0")
        SetOption("Editor/RTXDI", "SpatialSamplingRadius", "20.0")
        SetOption("Editor/RTXDI", "EnableGradients", true)
        SetOption("Editor/RTXDI", "InitialCandidatesInTemporal", true)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)		-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)						-- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.1")					-- WAS 0.35 TEST
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)				-- TEST
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", true)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", false)
        SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.125")
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.1")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", false)
        SaveSettings()
        return
    end
end

return config
