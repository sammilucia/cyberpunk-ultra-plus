-- helpers/traffic.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetTraffic(state)
	if state then
		Logger.info('    (Traffic changes enabled)')
		LoadIni('config/traffic.ini', true)
	else
		LoadIni('config/default_traffic.ini', true)
		Logger.info('    (Traffic changes NOT enabled)')
	end
end

return Config
