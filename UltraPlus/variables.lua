-- variables.lua

local var = {

    mode = {
        VANILLA = "Vanilla",
        PT20 = "PT20",
        PT21 = "PT21",
        REGIR = "ReGIR",
        RT_PT = "RTPT",
        RT_ONLY = "RTOnly",
        RASTER = "Raster",
    },
    samples = {
        VANILLA = "Vanilla",
        LOW = "Low",
        MEDIUM = "Medium",
        HIGH = "High",
        INSANE = "Insane",
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
        samples = "Unknown",
        quality = "Unknown",
        streaming = "Unknown",
        turboHack = false,
        reGIR = false,
        indoors = nil,
        rain = nil,
    },
}

return var
