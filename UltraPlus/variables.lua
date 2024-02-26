local _var = {
	mode = {
		vanilla = "Vanilla",
		pt20 = "PT20",
		pt21 = "PT21",
		rtpt = "RTPT",
		rtOnly = "RTOnly",
		raster = "Raster",
	},
	samples = {
		vanilla = "Vanilla",
		performance = "Performance",
		balanced = "Balanced",
		quality = "Quality",
	},
    dlss = {
        auto = "Auto",
        dlaa = "DLAA",
        quality = "Quality",
        balanced = "Balanced",
        performance = "Performance",
        ultraperf = "Ultra Performance",
        dynamic = "Dynamic",
    },
	settings = {
		mode = "Unknown",
		samples = "Unknown",
		nrdFix = false,
	},
	timer = {
		cron = 0,
		counter = 0,
		interval = 20.0,
	},
}

return _var