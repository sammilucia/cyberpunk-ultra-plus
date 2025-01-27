-- setgraphics.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetGraphics(graphics)
	if graphics == Var.graphics.OFF then
		Logger.info('Graphics settings are not enabled, skipping')
		return
	end

	Logger.info('Setting game graphics for', graphics)

	if graphics == Var.graphics.HIGH then
		LoadIni('config/graphics_high.ini', true)
		return
	end

	if graphics == Var.graphics.MEDIUM then
		LoadIni('config/graphics_medium.ini', true)
		return
	end

	if graphics == Var.graphics.FAST then
		LoadIni('config/graphics_fast.ini', true)
		return
	end

	if graphics == Var.graphics.POTATO then
		LoadIni('config/graphics_potato.ini', true)
		return
	end
end

return Config
