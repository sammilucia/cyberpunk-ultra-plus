-- helpers/Variables.lua

local Var = {
	confirmationRequired = false,
	configFile = 'UltraPlusConfig.ini',
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
		filterText = '',
	},
	mode = {
		PT16 = 'PT16',
		PT20 = 'PT20',
		PT21 = 'PT21',
		PTNEXT = 'PTNext',
		RT_PT = 'RTPT',
		RT= 'RT',
		RASTER = 'Raster',
	},
	quality = {
		VANILLA = 'Vanilla',
		FAST = 'Fast',
		MEDIUM = 'Med',
		HIGH = 'High',
		INSANE = 'Insane',
	},
	vram = {
		GB4 = '4',
		GB6 = '6',
		GB8 = '8',
		GB10 = '10',
		GB12 = '12',
		GB16 = '16',
		GB20 = '20',
		GB24 = '24',
	},
	sceneScale = {
		OFF = 'Off',
		FAST = 'Fast',
		VANILLA = 'Vanilla',
		MEDIUM = 'Med',
		HIGH = 'High',
		CRAZY = 'Crazy',
	},
	graphics = {
		POTATO = 'Potato',
		FAST = 'Fast',
		MEDIUM = 'Med',
		HIGH = 'High',
		OFF = 'Off',
	},
	weatherLabels = {
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
		[1] = 'Sunny',
		[2] = 'Fog',
		[3] = 'Pollution',
		[4] = 'Light Clouds',
		[5] = 'Cloudy',
		[6] = 'Heavy Clouds',
		[7] = 'Squat Morning (Like rain but not blue)',
		[8] = 'Deep Blue',
		[9] = 'Courier Clouds',
		[10] = 'Cloudy Morning',
	},
	SunAngularSizes = {
		[0] = '0.35',
		[1] = '0.35',
		[2] = '0.35',
		[3] = '0.35',
		[4] = '0.35',
		[5] = '0.35',
		[6] = '0.35',
		[7] = '0.325',
		[8] = '0.3',
		[9] = '0.275',
		[10] = '0.25',
		[11] = '0.225',
		[12] = '0.225',
		[13] = '0.225',
		[14] = '0.225',
		[15] = '0.25',
		[16] = '0.275',
		[18] = '0.3',
		[19] = '0.325',
		[20] = '0.35',
		[21] = '0.35',
		[22] = '0.35',
		[23] = '0.35',
		PreviousHour = -1,
	},
}

Var.settings = {
	mode = 'Unknown',
	quality = Var.quality.VANILLA,
	vram = Var.vram.GB24,
	graphics = Var.graphics.OFF,
	sceneScale = Var.sceneScale.VANILLA,
	autoScale = 3,
	lastAutoScale = 3,
	rayReconstruction = nil,
	indoors = nil,
	rain = nil,
	nrdEnabled = nil,
	enableTargetFps = false,
	targetFps = 30,
	enableConsole = false,
	enableTraffic = nil,
	enableCrowds = nil,
}

return Var
