-- perceptualautoscale.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.AutoScale(quality)
	local percentage = math.floor((quality / 6) * 100)
	logger.info("    (Auto-scaling perceptual quality to", percentage.."% to try and hit FPS target)")

	if quality == 1 then
		if var.settings.mode == var.mode.PT16 then
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
		else
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
			SetOption("RayTracing/Collector", "VisibilityCullingRadius", "1000.0")
			SetOption("RayTracing", "TracingRadiusReflections", "800.0")
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			SetOption("RayTracing", "TracingRadius", "100.0")
			LoadIni("config_fast.ini")
		end
		return
	end

	if quality == 2 then
		if var.settings.mode == var.mode.PT16 then
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
		else
			SetOption("Editor/SHARC", "DownscaleFactor", 6)
			SetOption("RayTracing/Collector", "VisibilityCullingRadius", "1500.0")
			SetOption("RayTracing", "TracingRadiusReflections", "1500.0")
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			SetOption("RayTracing", "TracingRadius", "100.0")
			LoadIni("config_fast.ini")
		end
		return
	end

	if quality == 3 then
		if var.settings.mode == var.mode.PT16 then
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
		else
			SetOption("Editor/SHARC", "DownscaleFactor", 5)
			SetOption("RayTracing/Collector", "VisibilityCullingRadius", "2000.0")
			SetOption("RayTracing", "TracingRadiusReflections", "1500.0")
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			SetOption("RayTracing", "TracingRadius", "200.0")
			LoadIni("config_medium.ini")
		end
		return
	end

	if quality == 4 then
		if var.settings.mode == var.mode.PT16 then
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
		else
			SetOption("Editor/SHARC", "DownscaleFactor", 4)
			SetOption("RayTracing/Collector", "VisibilityCullingRadius", "2000.0")
			SetOption("RayTracing", "TracingRadiusReflections", "5000.0")
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			SetOption("RayTracing", "TracingRadius", "300.0")
			LoadIni("config_medium.ini")
		end
		return
	end

	if quality == 5 then
		if var.settings.mode == var.mode.PT16 then
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
		else
			SetOption("Editor/SHARC", "DownscaleFactor", 3)
			SetOption("RayTracing/Collector", "VisibilityCullingRadius", "2000.0")
			SetOption("RayTracing", "TracingRadiusReflections", "8000.0")
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			SetOption("RayTracing", "TracingRadius", "400.0")
			LoadIni("config_high.ini")
		end
		return
	end

	if quality == 6 then
		if var.settings.mode == var.mode.PT16 then
			SetOption("Editor/SHARC", "DownscaleFactor", 7)
		else
			SetOption("Editor/SHARC", "DownscaleFactor", 2)
			SetOption("RayTracing/Collector", "VisibilityCullingRadius", "2000.0")
			SetOption("RayTracing", "TracingRadiusReflections", "8000.0")
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			SetOption("RayTracing", "TracingRadius", "1000.0")
			LoadIni("config_insane.ini")
		end
		return
	end
end

return config
