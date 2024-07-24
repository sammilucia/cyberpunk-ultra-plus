-- setscenescale.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local Cyberpunk = require('helpers/Cyberpunk')
local config = {}

function config.SetSceneScale(scale)
	logger.info('Settings SceneScale to', scale)

	if scale == var.sceneScale.PERFORMANCE then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
		return
	end

	if scale == var.sceneScale.VANILLA then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
		return
	end

	if scale == var.sceneScale.BALANCED then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '100.0')
		return
	end

	if scale == var.sceneScale.QUALITY then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '200.0')
		return
	end

	if scale == var.sceneScale.EXTREME then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '400.0')
		return
	end
end

return config
