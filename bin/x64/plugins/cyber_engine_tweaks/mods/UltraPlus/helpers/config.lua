-- helpers/Config.lua

local Config = {
	status = 'Ready.',
	ptNext = {
		active = false,
		stage1 = false,
		stage2 = false,
	},
	gameSession = {
		gameSessionActive = false,
		gameMenuActive = false,
		photoModeActive = false,
		tutorialActive = false,
		fastTravelActive = false,
		lastTime = 0,
		previousWeather = nil,
	},
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
