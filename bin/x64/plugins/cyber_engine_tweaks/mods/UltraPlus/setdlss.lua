-- setdlss.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local Cyberpunk = require('helpers/Cyberpunk')
local config = {}

function config.SetDLSS(quality)
	logger.info('Setting DLSS to', quality)

	if quality == var.dlss.DLAA then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'DLAA')
		return
	end

	if quality == var.dlss.QUALITY then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Quality')
		return
	end

	if quality == var.dlss.BALANCED then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Balanced')
		return
	end

	if quality == var.dlss.PERFORMANCE then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Performance')
		return
	end

	if quality == var.dlss.UPERFORMANCE then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Ultra Performance')
		return
	end
end

return config
