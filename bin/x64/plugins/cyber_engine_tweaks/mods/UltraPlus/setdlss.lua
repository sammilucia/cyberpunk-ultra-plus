-- setdlss.lua

local logger = require("helpers/logger")
local var = require("helpers/variables")
local config = {}

function config.SetDLSS(quality)
	logger.info("Setting DLSS to", quality)

	if quality == var.dlss.DLAA then
		SetOption("/graphics/presets", "DLSS", "DLAA")
		return
	end

	if quality == var.dlss.QUALITY then
		SetOption("/graphics/presets", "DLSS", "Quality")
		return
	end

	if quality == var.dlss.BALANCED then
		SetOption("/graphics/presets", "DLSS", "Balanced")
		return
	end

	if quality == var.dlss.PERFORMANCE then
		SetOption("/graphics/presets", "DLSS", "Performance")
		return
	end

	if quality == var.dlss.UPERFORMANCE then
		SetOption("/graphics/presets", "DLSS", "Ultra Performance")
		return
	end
end

return config
