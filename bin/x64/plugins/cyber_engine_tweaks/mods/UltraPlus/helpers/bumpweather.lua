-- helpers/bumpweather.lua

local logger = require("helpers/logger")
local var = require("helpers/var")

function BumpWeather(currentWeather)
    local index
    local random

    repeat
        index = math.random(#var.weatherStates)
        random = var.weatherStates[index]
    until random ~= currentWeather

    local name = var.weatherNames[index]

    Game.GetWeatherSystem():RequestNewWeather(random)
    logger.info(string.format("Changed weather to: %s (%s)", name, random))
end

return BumpWeather
