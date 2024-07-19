-- variables.lua

local var = {
	mode = {
		VANILLA = "Vanilla",
		PT16 = "PT16",
		PT20 = "PT20",
		PT21 = "PT21",
		PTNEXT = "PTNext",
		RT_PT = "RTPT",
		RT= "RT",
		RASTER = "No RT",
	},
	quality = {
		VANILLA = "Vanilla",
		FAST = "Fast",
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
	sceneScale = {
		PERFORMANCE = "Performance",
		VANILLA = "Vanilla",
		BALANCED = "Balanced",
		QUALITY = "Quality",
	},
	settings = {
		uiScale = 0.88,
		mode = "Unknown",
		quality = "Unknown",
		sceneScale = 1,
		autoScale = 3,
		vram = "Unknown",
		nsgddCompatible = nil,
		indoors = nil,
		rain = nil,
		nrdEnabled = nil,
		enableTargetFps = false,
		targetFps = 30,
		enableConsole = false,
	},
}

return var
