-- helpers/daytimetasks.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetDaytime(hour)
	if hour ~= Config.PreviousHour then
		local timeDescription = (hour == 6) and 'dawn' or (hour == 18) and 'dusk' or (hour == 12) and 'midday' or (hour == 20) and 'night time' or string.format('%02d:00', hour)
		Logger.info(string.format('    (Doing daytime tasks for: %s)', timeDescription))

		local sunAngularSize = Var.sunAngularSizes[hour]
		if sunAngularSize then
			Cyberpunk.SetOption('RayTracing', 'SunAngularSize', sunAngularSize)
		end
	end

	Config.PreviousHour = hour
end

return Config
