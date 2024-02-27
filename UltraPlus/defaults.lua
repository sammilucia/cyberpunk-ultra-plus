Defaults = {

	Experimental = {
		{
			item = "nrd_fix",
			name = "PT21 FPS Fix: Continually disable NRD",
			category = "internal",
			note = "",
			defaultValue = false,
		},

		{
			item = "DLSS_D",
			name = "PT Denoiser: Ray Reconstruction",
			category = "/graphics/presets",
			note = "NRD is only intended if you're NOT using ray reconstruction, for example AMD users. The engine tries to turn this on under certain circumstances, Ultra+ Control will show you if it has become enabled (Default: Off)",
			defaultValue = false,
		},

		{
			item = "EnableNRD",
			name = "PT Denoiser: NRD",
			category = "RayTracing",
			note = "NRD is only intended when NOT using ray reconstruction (for example AMD). The engine tries to turn this on under certain circumstances, Ultra+ Control will try and show you if it has become enabled, though there may be a bug in CP 2.1x that causes NRD to become partionally enabled (see the above PT21 FPS Fix).",
			defaultValue = false,
		},

		{
			item = "EnableRIS",
			name = "Resampled importance sampling (RIS - disable for reLIGHT)",
			category = "RayTracing/Reference",
			note = "(Default: RIS - resampled importance sampling - is enabled by default, however reLIGHT requires it's disabled for correct lighting until CDPR have a fix.)",
			defaultValue = true,
		},

		{
			item = "UseReblurForIndirectRadiance",
			name = "Use ReBLUR instead of ReLAX (PT20 and RT+PT only)",
			category = "RayTracing/NRD",
			note = "Forces ReBLUR for indirect lighting instead of ReLAX. ReBLUR may be removed in 2.11, I can no longer see a difference (Default: Off)",
			defaultValue = false,
		},

		{
			item = "DLSSDSeparateParticleColor",
			name = "Don't include particles in PT",
			category = "Rendering",
			note = "Unchecking this option includes particle FX colour in path tracing (steam, smoke, fire, sparks), and generally looks better, however it can make some rain mods look weird (Default: Yes, keep particle colour separate).",
			defaultValue = true,
		},

		{
			item = "particle_fix",
			name = "Particle Fix: Auto-toggle on rain",
			category = "internal",
			note = "Automatically toggles the above setting (Don't include particles in PT) when rain is detected",
			defaultValue = true,
		},
	},

	Features = {
		{
			item = "ConstrastAdaptiveSharpening",
			name = "AMD Contrast Adaptive Sharpening",
			category = "Developer/FeatureToggles",
			note = "I don't believe this is used in 2.11 anymore, it's here for testing (Default: On)",
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

return Defaults
