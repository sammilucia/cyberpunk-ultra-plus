local config = {}

function config.CommonFixes()
	print( "---------- Ultra+: Resetting all settings" )
	local category

	category = "Streaming"
		SetOption( category, "MaxNodesPerFrame", "300" )
		SetOption( category, "MaxNodesPerFrameWhileLoading", "100000" )
		SetOption( category, "MaxStreamingDistance", "8000.0" )
		SetOption( category, "EditorThrottledMaxNodesPerFrame", "300" )
		SetOption( category, "TimeLimitAttachingPerFrame", "0.5" )
		SetOption( category, "TimeLimitSectorLoadPerFrame", "2.5" )
		SetOption( category, "TimeLimitSectorUnloadPerFrame", "1.5" )
		SetOption( category, "TimeLimitStreamedPerFrame", "5.0" )
		SetOption( category, "TimeLimitStreamedPerFrameWhileLoading", "8.0" )
		SetOption( category, "ObserverVelocityOffsetEnabled", true )
		SetOption( category, "ObserverMaxOnFootForwardVelocity", "40.0" )
		SetOption( category, "ObserverMaxNonAirVehicleForwardVelocity", "600.0" )
		SetOption( category, "ObserverMaxAirVehicleForwardVelocity", "200.0" )

	category = "Streaming/Editor"
		SetOption( category, "TimeLimitAttachingPerFrame", "0.5" )
		SetOption( category, "TimeLimitDetachingPerFrame", "1.0" )
		SetOption( category, "TimeLimitStreamedPerFrame", "3.0" )

	category = "Editor/Streaming"
		SetOption( category, "ForceAutoHideDistanceMax", "0.0" )

	category = "Streaming/QueryZoom"
		SetOption( category, "Enabled", true )
		SetOption( category, "MaxSpeed", "2.0" )
		SetOption( category, "MinActivationZoomFactor", "2.0" )
		SetOption( category, "MaxZoomFactor", "4.0" )

	category = "DLSS"
		-- SetOption( category, "SampleNumber", "24" )
		SetOption( category, "EnableMirrorScaling", false )
		SetOption( category, "MirrorScaling", "1.0" )

	category = "FSR2"
		-- SetOption( category, "SampleNumber", "24" )
		SetOption( category, "EnableMirrorScaling", false )
		SetOption( category, "MirrorScaling", "1.0" )

	category = "Rendering/LUT"
		SetOption( category, "Size", "128" )
		SetOption( category, "MinRange", "0.000000000001" )
		SetOption( category, "MaxRange", "100.0" )

	category = "Editor/VolumetricFog"
		SetOption( category, "Exponent", "5.0" )

	category = "RayTracing/NRD"
		SetOption( category, "UseReblurForDirectRadiance", false )
		SetOption( category, "UseReblurForIndirectRadiance", false )

	category = "RayTracing/Reference"
		-- SetOption( category, "BounceNumber", "1" )
		-- SetOption( category, "RayNumber", "1" )
		-- SetOption( category, "EnableProbabilisticSampling", true )
		-- SetOption( category, "BounceNumberScreenshot", "2" )
		-- SetOption( category, "RayNumberScreenshot", "3" )

	category = "Editor/ReSTIRGI"
		SetOption( category, "EnableBoilingFilter", true )
		-- SetOption( category, "UseTemporalRGS", true )

	category = "Editor/SHARC"
		SetOption( category, "Enable", true )

	category = "Editor/PathTracing"
		SetOption( category, "UseScreenSpaceData", true )

	category = "Editor/Characters/Eyes"
		SetOption( category, "UseAOOnEyes", true )

	category = "Editor/Characters/Skin"
		SetOption( category, "AllowSkinAmbientMix", false )
		SetOption( category, "SkinAmbientMix_Factor", "1.0" )
		SetOption( category, "SubsurfaceSpecularTintWeight", "0.5" )
		SetOption( category, "SkinAmbientIntensity_Factor", "0.3" )
		SetOption( category, "SubsurfaceSpecularTint_R", "0.26" )
		SetOption( category, "SubsurfaceSpecularTint_G", "0.17" )
		SetOption( category, "SubsurfaceSpecularTint_B", "0.19" )
end

return config
