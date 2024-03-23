-- defaults.lua

local options = {

	Experimental = {
		{
			item = "turboHack",
			name = "Enable PT Turbo while outdoors",
			category = "internal",
			tooltip = "RTXDI spatial sampling is mostly needed indoors. This tweak reduces it while\noutdoors to try and maintain FPS in complex outdoor areas. It CAN reduce\nvisual quality outdoors in certain situations (white cars\nand highly reflective surfaces in particular).",
			defaultValue = true,
		},
		{
			item = "rainFix",
			name = "Enable PT Rain Fix",
			category = "internal",
			tooltip = "Enables full particle integration with path tracing while it's not raining\nor you're indoors.",
			defaultValue = true,
		},
		{
			item = "nrdFix",
			name = "Enable Ray Reconstruction FPS Fix",
			category = "internal",
			tooltip = "When using ray reconstruction, it's possible for FPS to drop during cut-\nscenes or while driving. Enabling this fix attempts to work around this\nproblem.",
		},
		{
			item = "DLSS_D",
			name = "Enable PT Denoiser: Ray Reconstruction",
			category = "/graphics/presets",
			tooltip = "Ultra+ allows the engine to override this avoid crashes, so this option will\nappear not to save (Default: N/A)",
		},
		{
			item = "EnableNRD",
			name = "Enable PT Denoiser: NRD",
			category = "RayTracing",
			tooltip = "NRD is only intended when NOT using ray reconstruction (for example AMD).\nThe engine tries to turn this on under certain circumstances, Ultra+ Control\nwill try and show you if it has become enabled, though there may be a bug in\nCP 2.1x that causes NRD to become partionally enabled (see the above PT21\nFPS Fix).",
		},
		{
			item = "EnableRIS",
			name = "Enable Resampled importance sampling (RIS)",
			category = "RayTracing/Reference",
			tooltip = "RIS is resampled importance sampling. It is enabled by default, but disable\nit for reLIGHT.",
		},
	},
	Features = {
		{
			item = "Bloom",
			name = "Bloom",
			category = "Developer/FeatureToggles",
			tooltip = "(Default: On)",
		},
		{
			item = "Distortion",
			name = "Distortion Effects",
			category = "Developer/FeatureToggles",
			tooltip = "(Default: On)",
		},
		{
			item = "ScreenSpaceHeatHaze",
			name = "Heat Haze",
			category = "Developer/FeatureToggles",
			tooltip = "Can distort badly with path tracing (Default: On)",
		},
		{
			item = "VolumetricFog",
			name = "Volumetric Fog",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "HideFPPAvatar",
			name = "Hide player avatar in reflections (except for head)",
			category = "RayTracing",
			tooltip = "(Default: Off)",
		},
		{
			item = "CharacterRimEnhancement",
			name = "Object (and character) rim enhancement",
			category = "Developer/FeatureToggles",
			tooltip = "Only works in raster and RT modes (Default: On)",
		},
		{
			item = "EnableCustomMipBias",
			name = "Force INI Mip Bias",
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
		},
		{
			item = "DistantFog",
			name = "Distant Fog",
			category = "Developer/FeatureToggles",
			tooltip = "Makes buildings and mountains fade into the atmosphere (Default: On)",
		},
		{
			item = "DistantGI",
			name = "Distant Global Illumination",
			category = "Developer/FeatureToggles",
			tooltip = "Distant global illumination (Default: On)",
		},
		{
			item = "DistantGiFix",
			name = "Distant GI Fix",
			category = "Rendering",
			tooltip = "Appears to be a distant GI hack (Default: On)",
		},
		{
			item = "DistantShadows",
			name = "Distant Shadows",
			category = "Developer/FeatureToggles",
			tooltip = "(Default: On)",
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

return options
