-- helpers/variables.lua

local var = {
	window = {
		open = false,
		scale = 1.0,
		startX = 0,
		startY = 0,
		finishX = 0,
		finishY = 0,
		initialWidth = 0,
		initialHeight = 0,
		intSize = 100,
		floatSize = 100,
		filterText = "",
	},
	settings = {
		mode = "Unknown",
		quality = "Unknown",
		vram = "Unknown",
		graphics = "Unknown",
		sceneScale = 1,
		autoScale = 3,
		nsgddCompatible = nil,
		rayReconstruction = nil,
		indoors = nil,
		rain = nil,
		nrdEnabled = nil,
		enableTargetFps = false,
		targetFps = 30,
		enableConsole = false,
	},
	mode = {
		VANILLA = "Vanilla",
		PT16 = "PT16",
		PT20 = "PT20",
		PT21 = "PT21",
		PTNEXT = "PTNext",
		RT_PT = "RTPT",
		RT= "RT",
		RASTER = "Raster",
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
	graphics = {
		POTATO = "Potato",
		FAST = "Fast",
		MEDIUM = "Medium",
		HIGH = "High",
	},
	weatherStates = {
		[1] = '24h_weather_sunny',
		[2] = '24h_weather_fog',
		[3] = '24h_weather_pollution',
		[4] = '24h_weather_light_clouds',
		[5] = '24h_weather_cloudy',
		[6] = '24h_weather_heavy_clouds',
		[7] = 'q302_squat_morning',
		[8] = 'q302_deeb_blue',
		[9] = 'sa_courier_clouds',
		[10] = 'q306_epilogue_cloudy_morning',
	},
	watherNames = {
		[1] = "Sunny",
		[2] = "Fog",
		[3] = "Pollution",
		[4] = "Light Clouds",
		[5] = "Cloudy",
		[6] = "Heavy Clouds",
		[7] = "Squat Morning (Like rain but not blue)",
		[8] = "Deep Blue",
		[9] = "Courier Clouds",
		[10] = "Cloudy Morning",
	},
	sceneScale = {
		PERFORMANCE = "Performance",
		VANILLA = "Vanilla",
		BALANCED = "Balanced",
		QUALITY = "Quality",
	},
}

return var