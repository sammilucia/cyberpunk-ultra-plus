-- setgraphics.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local config = {}

function config.SetGraphics(graphics)
	logger.info('Setting game graphics for', graphics)

	if graphics == var.graphics.HIGH then
		LoadIni('graphics_high')
		return
	end

	if graphics == var.graphics.MEDIUM then
		LoadIni('graphics_medium')
		return
	end

	if graphics == var.graphics.LOW then
		LoadIni('graphics_low')
		return
	end

	if graphics == var.graphics.POTATO then
		LoadIni('graphics_potato')
		return
	end
end

return config
