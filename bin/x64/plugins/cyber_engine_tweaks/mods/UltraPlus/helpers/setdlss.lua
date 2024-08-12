-- setdlss.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetDLSS(quality)
	Logger.info('Setting DLSS to', quality)

	if quality == Var.dlss.DLAA then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'DLAA')
		return
	end

	if quality == Var.dlss.QUALITY then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Quality')
		return
	end

	if quality == Var.dlss.BALANCED then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Balanced')
		return
	end

	if quality == Var.dlss.PERFORMANCE then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Performance')
		return
	end

	if quality == Var.dlss.UPERFORMANCE then
		Cyberpunk.SetOption('/graphics/presets', 'DLSS', 'Ultra Performance')
		return
	end
end

return Config
