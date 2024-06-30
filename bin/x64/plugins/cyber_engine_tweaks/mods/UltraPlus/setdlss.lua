-- setdlss.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetDLSS(quality)
	logger.info("Settings DLSS to", quality)

	if quality == var.dlss.DLAA then
		SetOption("/graphics/presets", "DLSS", "DLAA")

		PushChanges()
		return
	end

	if quality == var.dlss.QUALITY then
		SetOption("/graphics/presets", "DLSS", "Quality")

		PushChanges()
		return
	end

	if quality == var.dlss.BALANCED then
		SetOption("/graphics/presets", "DLSS", "Balanced")

		PushChanges()
		return
	end

	if quality == var.dlss.PERFORMANCE then
		SetOption("/graphics/presets", "DLSS", "Performance")

		PushChanges()
		return
	end

	if quality == var.dlss.UPERFORMANCE then
		SetOption("/graphics/presets", "DLSS", "Ultra Performance")

		PushChanges()
		return
	end
end

return config
