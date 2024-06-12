-- variables.lua

local var = {
    mode = {
        VANILLA = "Vanilla##Mode",
        PT20 = "PT20",
        PT21 = "PT21",
        PTNEXT = "PTNext",
        RT_PT = "RTPT",
        RT_ONLY = "RTOnly",
        RASTER = "Raster",
    },
    quality = {
        VANILLA = "Vanilla##Quality",
        LOW = "Low",
        MEDIUM = "Medium",
        HIGH = "High",
        INSANE = "Insane",
    },
    vram = {
        GB4 = 4,
        GB6 = 6,
        GB8 = 8,
        GB10 = 10,
        GB12 = 12,
        GB16 = 16,
        GB20 = 20,
        GB24 = 24,
    },
    dlss = {
        AUTO = "Auto",
        DYNAMIC = "Dynamic",
        DLAA = "DLAA",
        QUALITY = "Quality",
        BALANCED = "Balanced",
        PERFORMANCE = "Performance",
        ULTRA_PERFORMANCE = "Ultra Performance",
    },
    settings = {
        uiScale = 0.88,
        mode = "Unknown",
        quality = "Unknown",
        streaming = "Unknown",
        nsgddCompatible = nil,
        indoors = nil,
        rain = nil,
        nrdEnabled = nil,
    },
}

return var
