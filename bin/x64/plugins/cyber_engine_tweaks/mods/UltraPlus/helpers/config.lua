-- helpers/Config.lua

Config = {
	Status = 'Nova.',
	SetMode = require('helpers/setmode').SetMode,
	SetQuality = require('helpers/setquality').SetQuality,
	SetSceneScale = require('helpers/setscenescale').SetSceneScale,
	SetDLSS = require('helpers/setdlss').SetDLSS,
	SetVram = require('helpers/setvram').SetVram,
	SetGraphics = require('helpers/setgraphics').SetGraphics,
	AutoScale = require('helpers/perceptualautoscale').AutoScale,
	SetDaytime = require('helpers/daytimetasks').SetDaytime,
	SaveMenu = require('helpers/savemenu').SaveMenu,
	BumpWeather = require('helpers/bumpweather').BumpWeather,
}

return Config
