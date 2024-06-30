-- setscenescale.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetSceneScale(scale)
	logger.info("Settings SceneScale to", scale)

	if scale == var.sceneScale.LOW then
		SetOption("Editor/SHARC", "SceneScale", "30.0")
		return
	end

	if scale == var.sceneScale.VANILLA then
		SetOption("Editor/SHARC", "SceneScale", "50.0")
		return
	end

	if scale == var.sceneScale.MEDIUM then
		SetOption("Editor/SHARC", "SceneScale", "100.0")
		return
	end

	if scale == var.sceneScale.HIGH then
		SetOption("Editor/SHARC", "SceneScale", "200.0")
		return
	end
end

return config
