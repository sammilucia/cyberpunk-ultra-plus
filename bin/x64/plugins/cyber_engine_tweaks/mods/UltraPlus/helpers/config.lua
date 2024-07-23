-- helpers/config.lua

local config = {
	changed = false,
	status = "",
	SetMode = require("setmode").SetMode,
	SetQuality = require("setquality").SetQuality,
	SetSceneScale = require("setscenescale").SetSceneScale,
	SetDLSS = require("setdlss").SetDLSS,
	SetVram = require("setvram").SetVram,
	SetGraphics = require("setgraphics").SetGraphics,
	AutoScale = require("perceptualautoscale").AutoScale,
	SetDaytime = require("helpers/daytimetasks").SetDaytime,
	SaveMenu = require("savemenu").SaveMenu,
	PreviousWeather = nil,
	WasRREnabled = nil,
	ptNext = {
		active = false,
		primed = false,
	},
}

return config
