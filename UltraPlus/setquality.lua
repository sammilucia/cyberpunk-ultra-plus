-- setquality.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetQuality(quality)
    logger.info("Setting", var.settings.mode, "quality to", quality)

    if quality == var.quality.VANILLA then
        SetOption("RayTracing", "TracingRadius", "200.0")
        SetOption("RayTracing", "TracingRadiusReflections", "2000.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "15.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "50.0")
        SetOption("RayTracing/Reference", "RayNumber", "2")
        SetOption("RayTracing/Reference", "BounceNumber", "2")
        SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
        SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
        SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
        
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","2")
        SetOption("Editor/SHARC", "DownscaleFactor", "5")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "4")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "4")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")
        SetOption("Rendering", "CheckerboardGI", true)
        return
    end

    if quality == var.quality.LOW then
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","3")                -- TEST
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "4")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "4")
        SetOption("Editor/ReGIR", "LightSlotsCount", "256")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "16")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")
        SetOption("RayTracing", "TracingRadius", "100.0")
        SetOption("RayTracing", "TracingRadiusReflections", "800.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "12.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "35.0")
        SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
        SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "ForceShadowLODBiasUsage", false)
            SetOption("RayTracing", "ForceShadowLODBiasUseMax", false)
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("Editor/ReSTIRGI", "Enable", false)
            SetOption("RayTracing/Reference", "RayNumber", "2")
            SetOption("RayTracing/Reference", "BounceNumber", "2")                      -- lower or higher is slower for some reason
            return
        end

        SetOption("RayTracing", "ForceShadowLODBiasUsage", false)
        SetOption("RayTracing", "ForceShadowLODBiasUseMax", false)
        SetOption("RayTracing/Reference", "RayNumber", "1")
        SetOption("RayTracing/Reference", "BounceNumber", "1")
        SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
    end

    if quality == var.quality.MEDIUM then
        SetOption("Rendering", "CheckerboardGI", true)
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","2")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "5")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "5")
        SetOption("Editor/ReGIR", "LightSlotsCount", "384")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "20")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "10")
        SetOption("RayTracing", "TracingRadius", "200.0")
        SetOption("RayTracing", "TracingRadiusReflections", "1500.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "15.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "40.0")
        SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
        SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "ForceShadowLODBiasUsage", false)
            SetOption("RayTracing", "ForceShadowLODBiasUseMax", false)
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("Editor/ReSTIRGI", "Enable", true)
            SetOption("RayTracing/Reference", "RayNumber", "2")
            SetOption("RayTracing/Reference", "BounceNumber", "2")                      -- lower or higher is slower for some reason
            return
        end

        SetOption("RayTracing", "ForceShadowLODBiasUsage", false)
        SetOption("RayTracing", "ForceShadowLODBiasUseMax", false)
        SetOption("RayTracing/Reference", "RayNumber", "1")
        SetOption("RayTracing/Reference", "BounceNumber", "2")
        SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
    end

    if quality == var.quality.HIGH then
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","2")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "6")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "6")
        SetOption("Editor/ReGIR", "LightSlotsCount", "512")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "24")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "12")
        SetOption("RayTracing", "TracingRadius", "200.0")
        SetOption("RayTracing", "TracingRadiusReflections", "8000.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "15.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "50.0")
        SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
        SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "ForceShadowLODBiasUsage", false)
            SetOption("RayTracing", "ForceShadowLODBiasUseMax", false)
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("Editor/ReSTIRGI", "Enable", true)
            SetOption("RayTracing/Reference", "RayNumber", "3")
            SetOption("RayTracing/Reference", "BounceNumber", "2")                      -- lower or higher is slower for some reason
            return
        end

        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing", "ForceShadowLODBiasUseMax", true)
        SetOption("RayTracing/Reference", "RayNumber", "3")
        SetOption("RayTracing/Reference", "BounceNumber", "2")
        SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
    end

    if quality == var.quality.INSANE then
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","3")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "6")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "6")
        SetOption("Editor/ReGIR", "LightSlotsCount", "512")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "32")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "16")
        SetOption("RayTracing", "TracingRadius", "1000.0")
        SetOption("RayTracing", "TracingRadiusReflections", "8000.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "20.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "60.0")
        SetOption("RayTracing/Reference", "RayNumberScreenshot", "8")
        SetOption("RayTracing/Reference", "BounceNumberScreenshot", "3")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "ForceShadowLODBiasUsage", false)
            SetOption("RayTracing", "ForceShadowLODBiasUseMax", false)
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("Editor/ReSTIRGI", "Enable", true)
            SetOption("RayTracing/Reference", "RayNumber", "3")
            SetOption("RayTracing/Reference", "BounceNumber", "2")                      -- lower or higher is slower for some reason
            return
        end

        SetOption("RayTracing", "ForceShadowLODBiasUsage", true)
        SetOption("RayTracing", "ForceShadowLODBiasUseMax", true)
        SetOption("RayTracing/Reference", "RayNumber", "5")
        SetOption("RayTracing/Reference", "BounceNumber", "2")
        SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
    end
end

return config
