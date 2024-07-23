-- setscenescale.lua

local logger = require("helpers/logger")
local var = require("helpers/variables")
local config = {}

function config.SetSceneScale(scale)
	logger.info("Settings SceneScale to", scale)

	if scale == var.sceneScale.PERFORMANCE then
		SetOption("Editor/SHARC", "SceneScale", "30.0")
		return
	end

	if scale == var.sceneScale.VANILLA then
		SetOption("Editor/SHARC", "SceneScale", "50.0")
		return
	end

	if scale == var.sceneScale.BALANCED then
		SetOption("Editor/SHARC", "SceneScale", "100.0")
		return
	end

	if scale == var.sceneScale.QUALITY then
		SetOption("Editor/SHARC", "SceneScale", "200.0")
		return
	end
	
	if scale == var.sceneScale.EXTREME then
		SetOption("Editor/SHARC", "SceneScale", "400.0")
		return
	end
end

return config
