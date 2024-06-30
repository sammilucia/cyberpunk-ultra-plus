-- bumpweather.lua

local logger = require("logger")
local config = {
	WeatherStates = {
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
	WeatherFriendlyNames = {
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
}

function config.BumpWeather(currentWeather)
    local weatherIndex
    local randomWeather

    repeat
        weatherIndex = math.random(#config.WeatherStates)
        randomWeather = config.WeatherStates[weatherIndex]
    until randomWeather ~= currentWeather

    local friendlyName = config.WeatherFriendlyNames[weatherIndex]

    Game.GetWeatherSystem():RequestNewWeather(randomWeather)
    logger.info(string.format("Changed weather to: %s (%s)", friendlyName, randomWeather))
end

return config
