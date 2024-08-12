-- helpers/bumpweather.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
local Cyberpunk = require('helpers/Cyberpunk')

function Config.BumpWeather(currentWeather)
    local index
    local random

    repeat
        index = math.random(#Var.weatherLabels)
        random = Var.weatherLabels[index]
    until random ~= currentWeather

    local name = Var.weatherNames[index]

    Cyberpunk.SetWeather(random)
    Logger.info(string.format('Changed weather to: %s (%s)', name, random))
end

return Config
