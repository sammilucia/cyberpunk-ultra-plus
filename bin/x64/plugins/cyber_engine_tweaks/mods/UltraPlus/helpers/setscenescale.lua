-- setscenescale.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetSceneScale(scale)
	Logger.info('Settings SceneScale to', scale)

	if scale == Var.sceneScale.FAST then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
		return
	end

	if scale == Var.sceneScale.VANILLA then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
		return
	end

	if scale == Var.sceneScale.MEDIUM then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '100.0')
		return
	end

	if scale == Var.sceneScale.HIGH then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '200.0')
		return
	end

	if scale == Var.sceneScale.EXTREME then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '400.0')
		return
	end
end

return Config
