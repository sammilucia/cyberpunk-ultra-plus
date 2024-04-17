-- variables.lua

local var = {
    mode = {
        VANILLA = "Vanilla",
        PT20 = "PT20",
        PT21 = "PT21",
        PTNEXT = "PTNext",
        RT_PT = "RTPT",
        RT_ONLY = "RTOnly",
        RASTER = "Raster",
    },
    quality = {
        VANILLA = "Vanilla",
        LOW = "Low",
        MEDIUM = "Medium",
        HIGH = "High",
        INSANE = "Insane",
    },
    streaming = {
        LOW = "Low",
        MEDIUM = "Medium",
        HIGH = "High",
        INSANE = "Insane",
    },
    vram = {
        GB4 = "4 GB",
        GB6 = "6 GB",
        GB8 = "8 GB",
        GB10 = "10 GB",
        GB12 = "12 GB",
        GB16 = "16 GB",
        GB20 = "20 GB",
        GB24 = "24 GB",
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
        mode = "Unknown",
        quality = "Unknown",
        streaming = "Unknown",
        indoors = nil,
        rain = nil,
        nrdEnabled = nil,
    },
}

return var
