-- setsamples.lua

local var = require( "variables" )
local config = {}

function config.setSamples( samples )

	print( "---------- Ultra+: Setting RTXDI", samples )

	if samples == var.samples.VANILLA
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "5" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2" )
		SetOption( "Editor/RTXDI", "MaxHistoryLength", "20" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "8" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "8" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
		SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "5" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )

	elseif samples == var.samples.PERFORMANCE
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "8" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "14" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "6" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "0" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "4" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		end

	elseif samples == var.samples.BALANCED
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "14" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "4" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "0" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		end

	elseif samples == var.samples.QUALITY
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "20" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "20" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "3" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "3" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "3" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		end

	elseif samples == var.samples.CINEMATIC
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "20" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "24" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "2" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "6" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/RTXDI", "MaxHistoryLength", "4" )
			SetOption( "Editor/RTXDI", "SpatialNumSamples", "6" )
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "24" )
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		end
	end
end

return config
