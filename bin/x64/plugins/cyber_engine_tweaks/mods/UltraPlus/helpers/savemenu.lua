-- savemenu.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SaveMenu()
	Logger.info('Snapshotting game graphics menu settings...')
--[[
	Cyberpunk.GetOption('/graphics/presets', 'ResolutionScaling')
	Cyberpunk.GetOption('/graphics/presets', 'DLSS')
	Cyberpunk.GetOption('/graphics/presets', 'DLSS_NewSharpness') -- 0.0..1.0
	Cyberpunk.GetOption('/graphics/presets', 'DLAA_NewSharpness') -- 0.0..1.0
	Cyberpunk.GetOption('/graphics/presets', 'DLSSFrameGen') -- true false
	Film Grain true false
	Anamorphic true false
	Vignette true false
	Lens Flare true false
	Motion Blur 0 1 2
]]
	Logger.info('Done. Graphics menu will be restored when you next load Cyberpunk')
end

return Config
