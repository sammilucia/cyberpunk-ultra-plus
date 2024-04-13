-- setsamples.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetSamples(samples)
    logger.info("Setting samples to", samples)

    if samples == var.samples.VANILLA then
        SetOption("DLSS", "SampleNumber", "16")
        SetOption("FSR2", "SampleNumber", "16")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "5")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2")
        SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "8")
        SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "8")
        SetOption("Editor/RTXDI", "MaxHistoryLength", "20")
        SetOption("Editor/RTXDI", "NumInitialSamples", "8")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "8")
        SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
        SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8")
        SetOption("Editor/SHARC", "DownscaleFactor", "5")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "4")
        return
    end

    if samples == var.samples.LOW then
        SetOption("DLSS", "SampleNumber", "16")
        SetOption("FSR2", "SampleNumber", "16")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "16")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "16")
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")                        -- not used for ReGIR?
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "30.0")
            SetOption("Editor/SHARC", "Bounces", "1")
            return
        end

        SetOption("Editor/RTXDI", "NumInitialSamples", "16")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")                           -- required for LL sampling to env map, almost no cost
        SetOption("Editor/SHARC", "DownscaleFactor", "7")
        SetOption("Editor/SHARC", "SceneScale", "30.0")
        SetOption("Editor/SHARC", "Bounces", "2")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "4")
            return
        end
    end

    if samples == var.samples.MEDIUM then
        SetOption("DLSS", "SampleNumber", "24")
        SetOption("FSR2", "SampleNumber", "24")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "16")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "3")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "16")
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")                        -- not used for ReGIR?
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            SetOption("Editor/SHARC", "DownscaleFactor", "7")
            SetOption("Editor/SHARC", "SceneScale", "40.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        SetOption("Editor/RTXDI", "NumInitialSamples", "18")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")                           -- required for LL sampling to env map, almost no cost
        SetOption("Editor/SHARC", "DownscaleFactor", "5")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "2")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8")
            return
        end
    end

    if samples == var.samples.HIGH then
        SetOption("DLSS", "SampleNumber", "32")
        SetOption("FSR2", "SampleNumber", "32")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "20")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "4")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "24")
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")                  -- not used for ReGIR?
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            SetOption("Editor/SHARC", "DownscaleFactor", "6")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        SetOption("Editor/RTXDI", "NumInitialSamples", "20")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")                     -- required for LL sampling to env map, almost no cost
        SetOption("Editor/SHARC", "DownscaleFactor", "4")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "3")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "10")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16")
            return
        end
    end

    if samples == var.samples.INSANE then
        SetOption("DLSS", "SampleNumber", "32")
        SetOption("FSR2", "SampleNumber", "32")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "20")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "5")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32")
        SetOption("Editor/RTXDI", "SpatialNumSamples", "0")

        if var.settings.mode == var.mode.PTNEXT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "6")
            SetOption("Editor/RTXDI", "NumInitialSamples", "0")
            SetOption("Editor/RTXDI", "NumEnvMapSamples", "0")                        -- not used for ReGIR?
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "0")
            SetOption("Editor/ReSTIRGI", "MaxHistoryLength", "6")
            SetOption("Editor/ReSTIRGI", "TargetHistoryLength", "4")
            SetOption("Editor/SHARC", "DownscaleFactor", "5")
            SetOption("Editor/SHARC", "SceneScale", "50.0")
            SetOption("Editor/SHARC", "Bounces", "2")
            return
        end

        SetOption("Editor/RTXDI", "NumInitialSamples", "24")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "32")
        SetOption("Editor/SHARC", "DownscaleFactor", "3")
        SetOption("Editor/SHARC", "SceneScale", "50.0")
        SetOption("Editor/SHARC", "Bounces", "3")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "10")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16")
        end
    end
end

return config
