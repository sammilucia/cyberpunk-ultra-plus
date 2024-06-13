-- setquality.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetQuality(quality)
    logger.info("Setting", var.settings.mode, "quality to", quality)

    if quality == var.quality.VANILLA then
        LoadIni("config_vanilla.ini")

        SetOption("DLSS", "SampleNumber", "16")
        SetOption("FSR2", "SampleNumber", "16")
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","2")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "5")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "5")
        SetOption("Editor/ReGIR", "LightSlotsCount", "128")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "4")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")
        SetOption("Rendering/Shadows", "DistantShadowsForceFoliageGeometry", false)
        SetOption("RayTracing", "TracingRadius", "200.0")
        SetOption("RayTracing", "TracingRadiusReflections", "2000.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "15.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "40.0")
        SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
        SetOption("RayTracing/Reference", "RayNumber", "2")
        SetOption("RayTracing/Reference", "BounceNumber", "2")
        SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
        SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "5")
        SetOption("Editor/RTXDI", "MaxHistoryLength", "20")
        SetOption("Editor/RTXDI", "NumInitialSamples", "8")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "8")
        SetOption("Editor/RTXDI", "EnableFallbackLight", true)
        SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
        SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8")
        SetOption("Editor/SHARC", "DownscaleFactor", "5")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "4")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2")
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "8")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "8")
        return
    end

    if quality == var.quality.LOW then
        LoadIni("config_low.ini")

        SetOption("DLSS", "SampleNumber", "16")
        SetOption("FSR2", "SampleNumber", "16")
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","3")                -- TEST
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "4")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "4")
        SetOption("Editor/ReGIR", "LightSlotsCount", "512")				-- TEST
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "8")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")
        SetOption("Rendering/Shadows", "DistantShadowsForceFoliageGeometry", false)
        SetOption("RayTracing", "TracingRadiusReflections", "800.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "12.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "35.0")
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "16")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "TracingRadius", "100.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "30.0")
            SetOption("Editor/SHARC", "Bounces", "1")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            return
        end

        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "16")
        SetOption("Editor/RTXDI", "NumInitialSamples", "16")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")
        SetOption("Editor/SHARC", "Bounces", "2")

        if var.settings.mode == var.mode.PT20 then
            SetOption("RayTracing", "TracingRadius", "100.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "1")
            SetOption("RayTracing/Reference", "BounceNumber", "1")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "30.0")
            SetOption("Editor/SHARC", "Bounces", "1")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("RayTracing", "TracingRadius", "100.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "1")
            SetOption("RayTracing/Reference", "BounceNumber", "1")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "30.0")
            SetOption("Editor/SHARC", "Bounces", "1")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("RayTracing", "TracingRadius", "100.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "4")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "30.0")
            SetOption("Editor/SHARC", "Bounces", "1")
            return
        end
    end

    if quality == var.quality.MEDIUM then
        LoadIni("config_medium.ini")

        SetOption("DLSS", "SampleNumber", "24")
        SetOption("FSR2", "SampleNumber", "24")
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","2")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "5")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "5")
        SetOption("Editor/ReGIR", "LightSlotsCount", "512")				-- TEST
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "16")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")
        SetOption("Rendering/Shadows", "DistantShadowsForceFoliageGeometry", false)
        SetOption("RayTracing", "TracingRadiusReflections", "1500.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "15.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "40.0")
        SetOption("Editor/RTXDI", "EnableFallbackLight", false)
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "3")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "16")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            return
        end

        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "22")
        SetOption("Editor/RTXDI", "NumInitialSamples", "16")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")
        SetOption("Editor/SHARC", "Bounces", "2")
        
        if var.settings.mode == var.mode.PT20 then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "1")
            SetOption("RayTracing/Reference", "BounceNumber", "2")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "1")
            SetOption("RayTracing/Reference", "BounceNumber", "2")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "3")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "1")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8")
            SetOption("Editor/SHARC", "DownscaleFactor", "5")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end
    end

    if quality == var.quality.HIGH then
        LoadIni("config_high.ini")

        SetOption("DLSS", "SampleNumber", "32")
        SetOption("FSR2", "SampleNumber", "32")
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","2")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "6")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "6")
        SetOption("Editor/ReGIR", "LightSlotsCount", "512")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "20")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")      -- WAS 10 above 8 causes lights flickering
        SetOption("Rendering/Shadows", "DistantShadowsForceFoliageGeometry", true)
        SetOption("RayTracing", "TracingRadiusReflections", "1500.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "15.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "50.0")
        SetOption("Editor/RTXDI", "EnableFallbackLight", true)
        SetOption("Editor/RTXDI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "4")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "24")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/SHARC", "DownscaleFactor", "5")
            SetOption("Editor/SHARC", "SceneScale", "100.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            return
        end

        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "24")
        SetOption("Editor/RTXDI", "NumInitialSamples", "16")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")

        if var.settings.mode == var.mode.PT20 then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "2")
            SetOption("RayTracing/Reference", "BounceNumber", "2")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "2")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "100.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "1")
            SetOption("RayTracing/Reference", "BounceNumber", "2")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "2")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "2")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "100.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "10")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16")
            SetOption("Editor/SHARC", "DownscaleFactor", "3")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end
    end

    if quality == var.quality.INSANE then
        LoadIni("config_insane.ini")

        SetOption("DLSS", "SampleNumber", "32")
        SetOption("FSR2", "SampleNumber", "32")
        SetOption("Editor/Selection/Appearance", "CheckerboardSize","3")
        SetOption("Editor/Denoising/ReLAX/Direct/Common", "AtrousIterationNum", "6")
        SetOption("Editor/Denoising/ReLAX/Indirect/Common", "AtrousIterationNum", "6")
        SetOption("Editor/ReGIR", "LightSlotsCount", "512")
        SetOption("Editor/ReGIR", "ShadingCandidatesCount", "24")
        SetOption("Editor/ReGIR", "BuildCandidatesCount", "8")      -- WAS 12 above 8 causes lights flickering
        SetOption("Rendering/Shadows", "DistantShadowsForceFoliageGeometry", true)
        SetOption("RayTracing", "TracingRadiusReflections", "8000.0")
        SetOption("RayTracing", "CullingDistanceCharacter", "20.0")
        SetOption("RayTracing", "CullingDistanceVehicle", "60.0")
        SetOption("Editor/RTXDI", "EnableFallbackLight", true)
        SetOption("Editor/RTXDI", "SpatialNumSamples", "3")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "5")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "24")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/SHARC", "DownscaleFactor", "3")
            SetOption("Editor/SHARC", "SceneScale", "200.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            return
        end

        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "20")
        SetOption("Editor/RTXDI", "NumInitialSamples", "16")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "3")

        if var.settings.mode == var.mode.PT20 then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
            SetOption("RayTracing/Reference", "RayNumber", "2")
            SetOption("RayTracing/Reference", "BounceNumber", "2")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "5")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "3")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "3")
            SetOption("Editor/SHARC", "SceneScale", "200.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("RayTracing", "TracingRadius", "1000.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "3")
            SetOption("RayTracing/Reference", "BounceNumber", "2")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "5")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "3")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "3")
            SetOption("Editor/SHARC", "SceneScale", "200.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("RayTracing", "TracingRadius", "200.0")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
            SetOption("RayTracing/Reference", "RayNumber", "0")
            SetOption("RayTracing/Reference", "BounceNumber", "0")
            SetOption("RayTracing/Reference", "RayNumberScreenshot", "0")
            SetOption("RayTracing/Reference", "BounceNumberScreenshot", "0")
            SetOption("Editor/RTXDI", "MaxHistoryLength", "10")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "DownscaleFactor", "2")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
        end
    end
end

return config
