-- helpers/bumpweather.lua

local logger = require('helpers/logger')
local var = require('helpers/var')
local Cyberpunk = require('helpers/Cyberpunk')
local config = {}

function config.BumpWeather(currentWeather)
    local index
    local random

    repeat
        index = math.random(#var.weatherLabels)
        random = var.weatherLabels[index]
    until random ~= currentWeather

    local name = var.weatherNames[index]

    Cyberpunk.SetWeather(random)
    logger.info(string.format('Changed weather to: %s (%s)', name, random))
end

return config
