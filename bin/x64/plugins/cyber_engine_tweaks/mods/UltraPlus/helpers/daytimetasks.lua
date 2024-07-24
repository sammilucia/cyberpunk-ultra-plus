-- helpers/daytimetasks.lua

local logger = require('helpers/logger')
local config = {
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

function config.SetDaytime(hour)
	if hour ~= config.PreviousHour then
		local timeDescription = (hour == 6) and 'dawn' or (hour == 18) and 'dusk' or (hour == 12) and 'midday' or (hour == 20) and 'night time' or string.format('%02d:00', hour)
		logger.info(string.format('    (Doing daytime tasks for: %s)', timeDescription))

		local sunAngularSize = config.SunAngularSizes[hour]
		if sunAngularSize then
			Cyberpunk.SetOption('RayTracing', 'SunAngularSize', sunAngularSize)
		end
	end

	config.PreviousHour = hour
end

return config
