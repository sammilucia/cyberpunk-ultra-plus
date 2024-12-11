-- helpers/population.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetPop(enableCrowds)
	if Var.settings.enableCrowds == true then
		Logger.info('    (Crowd changes enabled)')
		LoadIni('crowds')
	else
		LoadIni('default_crowds')
		Logger.info('    (Crowd changes NOT enabled)')
	end
end

function Config.SetCars(enableTraffic)
	if Var.settings.enableTraffic == true then
		Logger.info('    (Traffic changes enabled)')
		LoadIni('traffic')
	else
		LoadIni('default_traffic')
		Logger.info('    (Traffic changes NOT enabled)')
	end
end

return Config
