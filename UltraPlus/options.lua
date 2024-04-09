-- options.lua

local options = {
    Tweaks = {
--[[        {
            item = "turboHack",
            name = "Enable PT Turbo (slightly reduce quality outdoors)",
            category = "internal",
            tooltip = "RTXDI spatial sampling is mostly needed indoors. This tweak reduces it while\noutdoors to try and maintain FPS in complex outdoor areas. It CAN reduce\nvisual quality outdoors in certain situations (white cars\nand highly reflective surfaces in particular).",
        },
        {
            item = "rainFix",
            name = "Enable PT Rain Fix",
            category = "internal",
            tooltip = "Enables full particle integration with path tracing while it's not raining\nor you're indoors." },]]
        {
            item = "DLSS_D",
            name = "Enable PT Denoiser: Ray Reconstruction",
            category = "/graphics/presets",
            tooltip = "Ultra+ allows the engine to override this avoid crashes, so this option will\nappear not to save (Default: N/A)",
        },
        {
            item = "reGIR",
            name = "Enable ReGIR Optimisation",
            category = "internal",
            tooltip = "Enables Reservoir-based Grid Importance Resampling. Performance optimisation\n and attempts to add detail to the areas that need it most (Default: Off)",
        },
        {
            item = "EnableNRD",
            name = "Enable PT Denoiser: NRD",
            category = "RayTracing",
            tooltip = "NRD is only intended when NOT using ray reconstruction (for example AMD).\nThe engine tries to turn this on under certain circumstances, Ultra+ Control\nwill try and show you if it has become enabled, though there may be a bug in\nCP 2.1x that causes NRD to become partionally enabled (see the above PT21\nFPS Fix).",
        },
        {
            item = "EnableRIS",
            name = "Enable resampled importance sampling (RIS)",
            category = "RayTracing/Reference",
            tooltip = "RIS is resampled importance sampling. It is enabled by default, but disable\nit for reLIGHT.",
        },
        {
            item = "Enable",
            name = "Enable SHaRC Bounce Cache",
            category = "Editor/SHARC",
            tooltip = "(Default: On)",
        },
        {
            item = "EnableGradients",
            name = "Enable RTXDI Gradients",
            category = "Editor/RTXDI",
            tooltip = "(Default: Off)",
        },
        {
            item = "EnableSeparateDenoising",
            name = "Enable RTXDI Separate Denoising",
            category = "Editor/RTXDI",
            tooltip = "(Default: On)",
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
            item = "DistantShadows",
            name = "Distant Shadows",
            category = "Developer/FeatureToggles",
            tooltip = "(Default: On)",
        },
        {
            item = "HideFPPAvatar",
            name = "Hide player in reflections (except for head)",
            category = "RayTracing",
            tooltip = "Because why would we want the head? (Default: Off)",
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
        },
    },
}

return options
