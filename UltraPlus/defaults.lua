-- defaults.lua

local defaults = {

	Experimental = {
		{
			item = "realTurbo",
			name = "PT Real Turbo",
			category = "internal",
			tooltip = "RTXDI Spatial sampling is mostly required indoors. This auto-disables it when player is outdoors.",
			defaultValue = false,
		},
		{
			item = "rainFix",
			name = "PT Rain Fix",
			category = "internal",
			tooltip = "Enables full particle integration with path tracing while it's not raining or you're indoors.",
			defaultValue = true,
		},
		{
			item = "nrdFix",
			name = "RR FPS Fix: Continually disable NRD",
			category = "internal",
			tooltip = "When using ray reconstruction, it's possible for FPS to drop during cut-scenes or while driving. Enabling this fix attempts to work around this problem.",
			defaultValue = false,
		},
		{
			item = "DLSS_D",
			name = "PT Denoiser: Ray Reconstruction",
			category = "/graphics/presets",
			tooltip = "Ultra+ allows the engine to override this avoid crashes, so this option will appear not to save (Default: N/A)",
			defaultValue = nil,
		},
		{
			item = "EnableNRD",
			name = "PT Denoiser: NRD",
			category = "RayTracing",
			tooltip = "NRD is only intended when NOT using ray reconstruction (for example AMD). The engine tries to turn this on under certain circumstances, Ultra+ Control will try and show you if it has become enabled, though there may be a bug in CP 2.1x that causes NRD to become partionally enabled (see the above PT21 FPS Fix).",
			defaultValue = false,
		},
		{
			item = "EnableRIS",
			name = "Resampled importance sampling (RIS - disable for reLIGHT)",
			category = "RayTracing/Reference",
			tooltip = "(Default: RIS - resampled importance sampling - is enabled by default, however reLIGHT requires it's disabled for correct lighting until CDPR have a fix.)",
			defaultValue = true,
		},
	},
	Features = {
		{
			item = "Bloom",
			name = "Bloom",
			category = "Developer/FeatureToggles",
			tooltip = "(Default: On)",
			defaultValue = true,
		},
		{
			item = "Distortion",
			name = "Distortion Effects",
			category = "Developer/FeatureToggles",
			tooltip = "(Default: On)",
			defaultValue = true,
		},
		{
			item = "ScreenSpaceHeatHaze",
			name = "Heat Haze",
			category = "Developer/FeatureToggles",
			tooltip = "Can distort badly with path tracing (Default: On)",
			defaultValue = true,
		},
		{
			item = "VolumetricFog",
			name = "Volumetric Fog",
			category = "Developer/FeatureToggles",
			tooltip = "",
			defaultValue = true,
		},
		{
			item = "HideFPPAvatar",
			name = "Show player avatar in reflections (except for head)",
			category = "RayTracing",
			tooltip = "(Default: Off)",
			defaultValue = false,
		},
		{
			item = "CharacterRimEnhancement",
			name = "Object (and character) rim enhancement",
			category = "Developer/FeatureToggles",
			tooltip = "Only works in raster and RT modes (Default: On)",
			defaultValue = false,
		},
		{
			item = "EnableCustomMipBias",
			name = "Force -1.0 Mip Bias",
			category = "Editor/MipBias",
			tooltip = "Caution: Not recommended for 12GB VRAM or less (Default: Off)",
			defaultValue = false,
		},
	},
	Distance = {
		{
			item = "DistantVolFog",
			name = "Distant Volumetric Fog",
			category = "Developer/FeatureToggles",
			tooltip = "Can be less obvious depending on which weather env you're using (Default: On)",
			defaultValue = true,
		},
		{
			item = "DistantFog",
			name = "Distant Fog",
			category = "Developer/FeatureToggles",
			tooltip = "Makes buildings and mountains fade into the atmosphere (Default: On)",
			defaultValue = true,
		},
		{
			item = "DistantGI",
			name = "Distant Global Illumination",
			category = "Developer/FeatureToggles",
			tooltip = "Distant global illumination (Default: On)",
			defaultValue = true,
		},
		{
			item = "DistantGiFix",
			name = "Distant GI Fix",
			category = "Rendering",
			tooltip = "Appears to be a distant GI hack (Default: On)",
			defaultValue = true,
		},
		{
			item = "DistantShadows",
			name = "Distant Shadows",
			category = "Developer/FeatureToggles",
			tooltip = "(Default: On)",
			defaultValue = true,
		},
	},
	SkinHair = {
		{
			item = "AAAA_HACK_hairModifiedLocalLightIntensity",
			name = "Reduce light intensity for hair in ray/path tracing",
			category = "Editor/Characters/Hair/HACKS",
			tooltip = "(Default: On)",
			defaultValue = false,
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

return defaults
