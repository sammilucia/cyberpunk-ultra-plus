-- setscenescale.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetSceneScale(scale)
	Logger.info('Settings SceneScale to', scale)

	if scale == Var.sceneScale.OFF then
		Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0') -- performance hack, leave cache enabled with no bounces
		return
	end

	if scale == Var.sceneScale.FAST then
		if Cyberpunk.GetOption('Editor/SHARC', 'Clear') then
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '8.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
		end
		Logger.info('Set SHaRC ' .. Cyberpunk.GetOption('Editor/SHARC', 'SceneScale'))
		return
	end

	if scale == Var.sceneScale.VANILLA then
		if Cyberpunk.GetOption('Editor/SHARC', 'Clear') then
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '12.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
		end
		Logger.info('Set SHaRC ' .. Cyberpunk.GetOption('Editor/SHARC', 'SceneScale'))
		return
	end

	if scale == Var.sceneScale.HIGH then
		if Cyberpunk.GetOption('Editor/SHARC', 'Clear') then
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '20.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '100.0')
		end
		Logger.info('Set SHaRC ' .. Cyberpunk.GetOption('Editor/SHARC', 'SceneScale'))
		return
	end

	if scale == Var.sceneScale.INSANE then
		if Cyberpunk.GetOption('Editor/SHARC', 'Clear') then
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '200.0')
		end
		Logger.info('Set SHaRC ' .. Cyberpunk.GetOption('Editor/SHARC', 'SceneScale'))
		return
	end

	if scale == Var.sceneScale.CRAZY then
		if Cyberpunk.GetOption('Editor/SHARC', 'Clear') then
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '40.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '400.0')
		end
		Logger.info('Set SHaRC ' .. Cyberpunk.GetOption('Editor/SHARC', 'SceneScale'))
		return
	end
end

return Config
