-- setsamples.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetSamples(samples)
    logger.info("Setting samples to", samples)

    if samples == var.samples.VANILLA then
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "5")
        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2")
        SetOption("Editor/RTXDI", "MaxHistoryLength", "20")
        SetOption("Editor/RTXDI", "NumInitialSamples", "8")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "8")
        SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
        SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8")

        SetOption("DLSS", "SampleNumber", "16")
        SetOption("FSR2", "SampleNumber", "16")
        return
    end

    if samples == var.samples.LOW then
        SetOption("DLSS", "SampleNumber", "16")
        SetOption("FSR2", "SampleNumber", "16")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "16")

        if var.settings.mode == var.mode.REGIR then
            SetOption( "Editor/RTXDI", "MaxHistoryLength", "8" )
            SetOption( "Editor/RTXDI", "NumInitialSamples", "6" )
            SetOption( "Editor/RTXDI", "NumEnvMapSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
            SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
            SetOption( "Editor/ReSTIRGI", "MaxHistoryLength", "8" )
            SetOption( "Editor/ReSTIRGI", "TargetHistoryLength", "6" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "1" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "8" )
            return
        end

        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "2")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "8")
        SetOption("Editor/RTXDI", "NumInitialSamples", "14")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "16")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "0")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "4")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "4")
            SetOption("Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25")
            return
        end
    end

    if samples == var.samples.BALANCED then
        SetOption("DLSS", "SampleNumber", "24")
        SetOption("FSR2", "SampleNumber", "24")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "16")

        if var.settings.mode == var.mode.REGIR then
            SetOption( "Editor/RTXDI", "MaxHistoryLength", "8" )
            SetOption( "Editor/RTXDI", "NumInitialSamples", "8" )
            SetOption( "Editor/RTXDI", "NumEnvMapSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
            SetOption( "Editor/ReSTIRGI", "MaxHistoryLength", "8" )
            SetOption( "Editor/ReSTIRGI", "TargetHistoryLength", "6" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "8" )
            return
        end

        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "4")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32")
        SetOption("Editor/RTXDI", "NumInitialSamples", "14")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "16")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "2")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "4")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "2")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8")
            return
        end
    end

    if samples == var.samples.HIGH then
        SetOption("DLSS", "SampleNumber", "32")
        SetOption("FSR2", "SampleNumber", "32")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "20")

        if var.settings.mode == var.mode.REGIR then
            SetOption( "Editor/RTXDI", "MaxHistoryLength", "8" )
            SetOption( "Editor/RTXDI", "NumInitialSamples", "10" )
            SetOption( "Editor/RTXDI", "NumEnvMapSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
            SetOption( "Editor/ReSTIRGI", "MaxHistoryLength", "8" )
            SetOption( "Editor/ReSTIRGI", "TargetHistoryLength", "6" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "8" )
            return
        end

        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "4")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32")
        SetOption("Editor/RTXDI", "NumInitialSamples", "20")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "20")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "3")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "10")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "3")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16")
            return
        end
    end

    if samples == var.samples.INSANE then
        SetOption("DLSS", "SampleNumber", "32")
        SetOption("FSR2", "SampleNumber", "32")
        SetOption("RayTracing/ReferenceScreenshot", "SampleNumber", "20")

        if var.settings.mode == var.mode.REGIR then
            SetOption( "Editor/RTXDI", "MaxHistoryLength", "8" )
            SetOption( "Editor/RTXDI", "NumInitialSamples", "12" )
            SetOption( "Editor/RTXDI", "NumEnvMapSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
            SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "10" )
            SetOption( "Editor/ReSTIRGI", "MaxHistoryLength", "8" )
            SetOption( "Editor/ReSTIRGI", "TargetHistoryLength", "6" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
            SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "10" )
            return
        end

        SetOption("Editor/ReSTIRGI", "SpatialNumSamples", "6")
        SetOption("Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32")
        SetOption("Editor/RTXDI", "NumInitialSamples", "20")
        SetOption("Editor/RTXDI", "NumEnvMapSamples", "24")

        if var.settings.mode == var.mode.PT20 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "6")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.RT_PT then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "0")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "2")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32")
            return
        end

        if var.settings.mode == var.mode.PT21 then
            SetOption("Editor/RTXDI", "MaxHistoryLength", "10")
            SetOption("Editor/RTXDI", "SpatialNumSamples", "6")
            SetOption("Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16")
        end
    end
end

return config
