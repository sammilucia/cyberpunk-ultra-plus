local var =
{
	mode =
    {
		vanilla     = "Vanilla",
		pt20        = "PT20",
		pt21        = "PT21",
		rt_pt       = "RTPT",
		rt_only     = "RTOnly",
		raster      = "Raster",
	},
	samples =
    {
		vanilla     = "Vanilla",
		performance = "Performance",
		balanced    = "Balanced",
		quality     = "Quality",
	},
    dlss =
    {
        auto        = "Auto",
        dynamic     = "Dynamic",
        dlaa        = "DLAA",
        quality     = "Quality",
        balanced    = "Balanced",
        performance = "Performance",
        ultra_performance = "Ultra Performance",
    },
	settings =
    {
		mode        = "Unknown",
		samples     = "Unknown",
        rain        = 0,
	},
	timer =
    {
		cron        = 0,
		counter     = 0,
		interval    = 20.0,     -- seconds
	},
}

return var
