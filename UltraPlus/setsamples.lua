-- setsamples.lua

local var = require( "variables" )
local config = {}

function config.setSamples( samples )

	print( "---------- Ultra+: Switching to Vanilla RTXDI", samples )

	if samples == var.samples.VANILLA
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "5" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "2" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "2" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "8" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "8" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
		SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )

	elseif samples == var.samples.PERFORMANCE
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "16" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "0" )

		if var.settings.mode == var.mode.PT20
		or var.settings.mode == var.mode.RT_PT
		then
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
		else
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "4" )
		end

	elseif samples == var.samples.BALANCED
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "16" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "20" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "1" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )

		if var.settings.mode == var.mode.PT20
		or var.settings.mode == var.mode.RT_PT
		then
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
		else
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "8" )
		end

	elseif samples == var.samples.QUALITY
	then
		SetOption( "RayTracing/ReferenceScreenshot", "SampleNumber", "24" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumSamples", "4" )
		SetOption( "Editor/ReSTIRGI", "SpatialNumDisocclusionBoostSamples", "32" )
		SetOption( "Editor/RTXDI", "NumInitialSamples", "24" )
		SetOption( "Editor/RTXDI", "NumEnvMapSamples", "0" )
		SetOption( "Editor/RTXDI", "SpatialNumSamples", "2" )

		if var.settings.mode == var.mode.PT20
		or var.settings.mode == var.mode.RT_PT
		then
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "32" )
		else
			SetOption( "Editor/RTXDI", "SpatialNumDisocclusionBoostSamples", "16" )
		end
	end
end

return config
