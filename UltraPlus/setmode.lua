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
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "EnableShadowCascades", false)                        -- test
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "0")
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "200.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "100.0")
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
        SetOption("Rendering", "AllowRTXDIRejitter", true) 
        SetOption("RayTracing", "EnableNRD", true)
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "1")
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "SunAngularSize", "0.15")
        SetOption("RayTracing", "EnableShadowCascades", false)                        -- test
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "70.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "70.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "0")
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0")
        SetOption("Rendering","AllowRTXDIRejitter",true)
        SetOption("Editor/ReSTIRGI", "Enable", false)
        SetOption("Editor/RTXDI", "EnableGradients", false)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)        -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)                       -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")                    -- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableEmissiveProxyLightRejection", true)
        SetOption("Editor/RTXDI", "EnableGlobalLight", false)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)                         -- TEST
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.15")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", true)
        SetOption("Editor/PathTracing", "UseSSRFallback", true)
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
        SetOption("Rendering", "AllowRTXDIRejitter", false) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "1")
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "SunAngularSize", "0.5")
        SetOption("RayTracing", "EnableShadowCascades", false)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "200.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "100.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "1")
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0")
        SetOption("Editor/ReSTIRGI", "Enable", true)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", false)
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", true)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", false)
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "1")
        SetOption("Editor/RTXDI", "EnableGradients", false)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)
        SetOption("Editor/RTXDI", "EnableFallbackLight", true)
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.5")
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "2")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", false)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableEmissiveProxyLightRejection", false)
        SetOption("Editor/RTXDI", "EnableGlobalLight", false)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.4")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", false)
        SetOption("Editor/PathTracing", "UseSSRFallback", true)
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
        SetOption("Rendering", "AllowRTXDIRejitter", true) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "0")
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "SunAngularSize", "0.15")
        SetOption("RayTracing", "EnableShadowCascades", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "70.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "70.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "1")
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0")
        SetOption("Editor/ReSTIRGI", "Enable", true)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", true)                  -- test 2.0
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", true)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", true)
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableGradients", false)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)        -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)                       -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")                    -- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableEmissiveProxyLightRejection", true)
        SetOption("Editor/RTXDI", "EnableGlobalLight", false)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.4")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", true)
        SetOption("Editor/PathTracing", "UseSSRFallback", true)
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
        SetOption("Rendering", "AllowRTXDIRejitter", true) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "0")
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "SunAngularSize", "0.15")
        SetOption("RayTracing", "EnableShadowCascades", true)
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "50.0")          -- WAS 70.0 improves RTXDI light/shadow selection
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "50.0")         -- WAS 70.0
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "0")
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "2.0")
        SetOption("Rendering","AllowRTXDIRejitter",true)
        SetOption("Editor/ReSTIRGI", "Enable", false)
        SetOption("Editor/RTXDI", "EnableGradients", false)
        SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)        -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)                       -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")                    -- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", true)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableEmissiveProxyLightRejection", true)
        SetOption("Editor/RTXDI", "EnableGlobalLight", false)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
        SetOption("Editor/SHARC", "Enable", true)
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", false)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", true)                         -- TEST
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.4")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", true)
        SetOption("Editor/PathTracing", "UseSSRFallback", true)
        SaveSettings()
    end

    if mode == var.mode.REGIR then
        SetOption("/graphics/raytracing", "RayTracing", true)
        SetOption("/graphics/raytracing", "RayTracedPathTracing", true)
        SetOption("Editor/ReGIR", "Enable", true)
        SetOption("Editor/ReGIR", "UseForDI", true)
        PushChanges()

        SetOption("Developer/FeatureToggles", "RTXDI", true)
        SetOption("Rendering", "AllowRTXDIRejitter", false) 
        SetOption("RayTracing", "AmbientOcclusionRayNumber", "1")
        SetOption("RayTracing", "EnableImportanceSampling", true)
        SetOption("RayTracing", "SunAngularSize", "0.15")                             -- WAS 0.5
        SetOption("RayTracing", "EnableShadowCascades", false)
        SetOption("RayTracing/Collector", "VisibilityCullingRadius", "2000.0")
        SetOption("RayTracing/Collector", "VisibilityFrustumOffset", "200.0")
        SetOption("RayTracing/Collector", "LocalShadowCullingRadius", "100.0")
        SetOption("RayTracing/Reflection", "EnableHalfResolutionTracing", "1")
        SetOption("RayTracing/Diffuse", "EnableHalfResolutionTracing", "1")
        SetOption("Rendering/VariableRateShading", "ScreenEdgeFactor", "1.0")
        SetOption("Editor/ReSTIRGI", "EnableFused", true)
        SetOption("Editor/ReSTIRGI", "EnableFallbackSampling", true)                  -- test 2.0
        SetOption("Editor/ReSTIRGI", "EnableBoilingFilter", true)
        SetOption("Editor/ReSTIRGI", "UseTemporalRGS", false)
        SetOption("Editor/ReSTIRGI", "BoilingFilterStrength", "0.2")
        SetOption("Editor/ReSTIRGI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableGradients", true)
        -- SetOption("Editor/RTXDI", "EnableLocalLightImportanceSampling", false)        -- disabling so SpatialNumSamples not needed
        -- SetOption("Editor/RTXDI", "EnableFallbackLight", false)                       -- disabling so SpatialNumSamples not needed
        SetOption("Editor/RTXDI", "BoilingFilterStrength", "0.35")                    -- WAS 0.45
        SetOption("Editor/RTXDI", "BiasCorrectionMode", "3")
        SetOption("Editor/RTXDI", "EnableApproximateTargetPDF", false)
        SetOption("Editor/RTXDI", "ForcedShadowLightSourceRadius", "0.1")
        SetOption("Editor/RTXDI", "EnableEmissiveProxyLightRejection", false)
        SetOption("Editor/RTXDI", "EnableGlobalLight", true)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)
        SetOption("Editor/SHARC", "Enable", "true")
        SetOption("Editor/SHARC", "UseRTXDIAtPrimary", true)
        SetOption("Editor/SHARC", "UseRTXDIWithAlbedo", false)
        SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.1")
        SetOption("Editor/PathTracing", "UseScreenSpaceData", false)
        SetOption("Editor/PathTracing", "UseSSRFallback", false)
        SaveSettings()
        return
    end
end

return config
