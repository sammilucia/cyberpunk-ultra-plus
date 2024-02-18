Settings = {

	Experimental = {
		{
			item = "DLSSDSeparateParticleColor",
			name = "Do not include particle colour in path tracing",
			category = "Rendering",
			note = "Unchecking this option includes particle FX colour in path tracing (steam, smoke, fire, sparks), and generally looks better, however it can make some rain mods look weird (Default: Yes, keep particle colour separate).",
			defaultValue = false,
		},
		
		{
			item = "EnableImportanceSampling",
			name = "Path tracing importance sampling",
			category = "RayTracing",
			note = "(Default: On)",
			defaultValue = true,
		},
		
		{
			item = "EnableLocalLightImportanceSampling",
			name = "Local light importance sampling",
			category = "Editor/RTXDI",
			note = "Adjusts some local lights to be brighter (Default: Off)",
			defaultValue = true,
		},

		{
			item = "EnableRIS",
			name = "Enable resampled importance sampling (disable for reLIGHT)",
			category = "RayTracing/Reference",
			note = "(Default: RIS - resampled importance sampling - is enabled by default, however reLIGHT requires it's disabled for correct lighting until CDPR have a fix.)",
			defaultValue = true,
		},

		{
			item = "EnableNRD",
			name = "Enable NRD (path tracing) denoiser",
			category = "RayTracing",
			note = "Only intended if you're NOT using ray reconstruction, for example AMD users (Default: Off)",
			defaultValue = false,
		},

		{
			item = "EnableFixed",
			name = "Enable Reference 'Fixed' (Unknown)",
			category = "RayTracing/Reference",
			note = "(Default: On)",
			defaultValue = true,
		},
		
		{
			item = "EnableGlobalShadowCulling",
			name = "Global Shadow Culling",
			category = "RayTracing/Collector",
			note = "(Default: On)",
			defaultValue = false,
		},
	},

	Features = {
		{
			item = "ConstrastAdaptiveSharpening",
			name = "AMD Contrast Adaptive Sharpening",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},

		{
			item = "Bloom",
			name = "Bloom",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},

		{
			item = "ImageBasedFlares",
		 	name = "Lens Flare",
		 	category = "Developer/FeatureToggles",
		 	note = "(Default: On)",
			defaultValue = true,
		},

		{
			item = "Distortion",
			name = "Distortion Effects",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},

		{
			item = "ScreenSpaceHeatHaze",
			name = "Heat Haze",
			category = "Developer/FeatureToggles",
			note = "Can distort badly with path tracing (Default: On)",
			defaultValue = true,
		},

		{
			item = "VolumetricFog",
			name = "Volumetric Fog",
			category = "Developer/FeatureToggles",
			note = "",
			defaultValue = true,
		},

		{
			item = "HideFPPAvatar",
			name = "Show player avatar in reflections (except for head)",
			category = "RayTracing",
			note = "(Default: Off)",
			defaultValue = false,
		},
		
		{
			item = "CharacterRimEnhancement",
			name = "Object (and character) rim enhancement",
			category = "Developer/FeatureToggles",
			note = "Only works in raster and RT modes (Default: On)",
			defaultValue = false,
		},

		{
			item = "EnableCustomMipBias",
			name = "Force -1.0 Mip Bias",
			category = "Editor/MipBias",
			note = "Caution: Not recommended for 12GB VRAM or less (Default: Off)",
			defaultValue = false,
		},
	},

	Distance = {
		{
			item = "DistantVolFog",
			name = "Distant Volumetric Fog",
			category = "Developer/FeatureToggles",
			note = "Can be less obvious depending on which weather env you're using (Default: On)",
			defaultValue = true,
		},

		{
			item = "DistantFog",
			name = "Distant Fog",
			category = "Developer/FeatureToggles",
			note = "Makes buildings and mountains fade into the atmosphere (Default: On)",
			defaultValue = true,
		},

		{
			item = "DistantGI",
			name = "Distant Global Illumination",
			category = "Developer/FeatureToggles",
			note = "Distant global illumination (Default: On)",
			defaultValue = true,
		},

		{
			item = "DistantGiFix",
			name = "Distant GI Fix",
			category = "Rendering",
			note = "Appears to be a distant GI hack (Default: On)",
			defaultValue = true,
		},

		{
			item = "DistantShadows",
			name = "Distant Shadows",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},
--[[
		{
			item = "DistantShadowForce",
			name = "GI Distant Shadow Force",
			category = "Rendering/GlobalIllumination",
			note = "",
			defaultValue = 0.6,
		},

		{
			item = "DistantShadowBlur",
			name = "Distant Shadow Blur",
			category = "Rendering/GlobalIllumination",
			note = "",
			defaultValue = 5.0,
		},
]]--
	},

	SkinHair = {
		{
			item = "CharacterLightBlockers",
			name = "Character light blocking",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},
		
		{
			item = "AAAA_HACK_hairModifiedLocalLightIntensity",
			name = "Reduce light intensity for hair in ray/path tracing",
			category = "Editor/Characters/Hair/HACKS",
			note = "(Default: On)",
			defaultValue = true,
		},
	},
--[[
	Graphics = {

		graphics/advanced/AmbientOcclusion, "Off", "Low", "Medium", "High"			-- redraw
		graphics/advanced/ScreenSpaceReflectionsQuality, "Off", "Low", "Medium", "High", "Ultra", "Insane"		-- redraw
		graphics/advanced/SubsurfaceScatteringQuality, "Low", "Medium", "High"
		graphics/advanced/VolumetricFogResolution, "Low", "Medium", "High", "Ultra"
		graphics/advanced/VolumetricCloudsQuality, "Off", "Medium", "High", "Ultra"	-- redraw
		graphics/advanced/ContactShadows ?
		graphics/advanced/LocalShadowsQuality, "Off", "Low", "Medium", "High"		-- redraw
		graphics/advanced/ShadowMeshQuality, "Low", "Medium", "High"
		graphics/advanced/DistantShadowsResolution, "Low", "High"
		graphics/advanced/CascadedShadowsRange, "Low", "Medium", "High"
		graphics/advanced/CascadedShadowsResolution, "Low", "Medium", "High"
		graphics/basic/LensFlares, true, false
		graphics/basic/MotionBlur, "Off", "Low", "High"
		graphics/basic/FilmGrain, true, false
		graphics/basic/DepthOfField, true, false
		graphics/basic/ChromaticAberration, true, false
		graphics/advanced/FacialTangentUpdates, true, false
		graphics/raytracing/RayTracing, true, false
		graphics/advanced/MaxDynamicDecals, "Low", "Medium", "High", "Ultra"

	}
]]--
}

return Settings
