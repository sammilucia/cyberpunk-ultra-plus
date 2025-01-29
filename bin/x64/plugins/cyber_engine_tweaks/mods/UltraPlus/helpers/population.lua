-- helpers/population.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetPopulation(state)
	if state then
		Logger.info('    (Crowd changes enabled)')
		LoadIni('config/crowds.ini', true)
	else
		LoadIni('config/default_crowds.ini', true)
		Logger.info('    (Crowd changes NOT enabled)')
	end
end

return Config
