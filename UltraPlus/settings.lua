Settings = {

	Mode = {
		{
			item = "UltraPlus",
			name = "RTPT",
			category = "",
			note = "",
			defaultValue = true,
		},

		{
			item = "UltraPlus",
			name = "PT21",
			category = "",
			note = "",
			defaultValue = false,
		},

		{
			item = "UltraPlus",
			name = "PT20",
			category = "",
			note = "",
			defaultValue = false,
		},
		
		{
			item = "UltraPlus",
			name = "Vanilla",
			category = "",
			note = "",
			defaultValue = false,
		},
	},

	Experimental = {
		{
			item = "EnableApproximateTargetPDF",
			name = "RTXDI approximate PDF",
			category = "Editor/RTXDI",
			note = "PDF is probability density function. Evaluates the final BRDF, which is almost ideal (Default: Off)",
			defaultValue = true,
		},

		{
			item = "DLSSDSeparateParticleColor",
			name = "Particle colour in path tracing",
			category = "Rendering",
			note = "Integrates particle FX (steam, smoke, fire, sparks) better into path tracing (Default: Off)",
			defaultValue = true,
		},

		{
			item = "UseRTXDIAtPrimary",
			name = "UseRTXDIAtPrimary",
			category = "Editor/SHARC",
			note = "(Default: Off)",
			defaultValue = false,
		},
	},

	Features = {
		{
			item = "ConstrastAdaptiveSharpening",
			name = "AMD Constrast Adaptive Sharpening",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = false,
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
			item = "RainMap",
			name = "Rain map",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},

		{
			item = "EnableTransparentReflection",
			name = "(Ray traced?) reflections on transparent",
			category = "RayTracing",
			note = "E.g. reflections on glass (Default: On)",
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
		{
			item = "DistantShadowsUseTodVis",
			name = "DistantShadowsUseTodVis",
			category = "Rendering",
			note = "Distant shadow hack (Default: Off)",
			defaultValue = false,
		},
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
			item = "CharacterRimEnhancement",
			name = "Character rim enhancement",
			category = "Developer/FeatureToggles",
			note = "Default (On)",
			defaultValue = true,
		},

		{
			item = "CharacterSubsurfaceScattering",
			name = "Skin Subsurface Scattering",
			category = "Developer/FeatureToggles",
			note = "(Default: On)",
			defaultValue = true,
		},

		{
			item = "CharacterSubsurfaceTranslucency",
			name = "Skin Translucency",
			category = "Developer/FeatureToggles",
			note = "(Default: Off)",
			defaultValue = false,
		},
		
		{
			item = "UseReferenceImplementation",
			name = "Include hair in path tracing",
			category = "Editor/Characters/Hair",
			note = "(Default: Off)",
			defaultValue = false,
		},
		
		{
			item = "AAAA_HACK_hairModifiedLocalLightIntensity",
			name = "Hair local light intensity hack for ray tracing (path tracing?)",
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
