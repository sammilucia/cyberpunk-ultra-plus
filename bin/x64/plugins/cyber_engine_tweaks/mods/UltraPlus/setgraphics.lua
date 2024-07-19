-- setmode.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetGraphics(graphics)
	logger.info("Configuring graphics to", graphics)

	if graphics == var.graphics.FAST then
		SetOption("/graphics/raytracing", "RayTracing", false)
		PushChanges()

		SetOption("Developer/FeatureToggles", "RTXDI", false)
		SetOption("Editor/Characters/Eyes", "DiffuseBoost", "0.15")
		SetOption("Editor/SHARC", "Enable", false)
		SaveSettings()
		return
	end
end

return config
