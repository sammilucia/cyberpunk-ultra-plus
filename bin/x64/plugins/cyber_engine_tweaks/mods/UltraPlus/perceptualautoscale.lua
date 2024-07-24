-- perceptualautoscale.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local Cyberpunk = require('helpers/Cyberpunk')
local config = {}

function config.AutoScale(quality)
	local percentage = math.floor((quality / 6) * 100)
	logger.info('    (Auto-scaling perceptual quality to', percentage..'% to try and hit FPS target)')

	if quality == 1 then
		if var.settings.mode == var.mode.PT16 then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 0)
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 0)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '1000.0')
			Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '800.0')
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '100.0')
		end
		return
	end

	if quality == 2 then
		if var.settings.mode == var.mode.PT16 then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 0)
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 6)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '1500.0')
			Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '1500.0')
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '100.0')
		end
		return
	end

	if quality == 3 then
		if var.settings.mode == var.mode.PT16 then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 5)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
			Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '1500.0')
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
		end
		return
	end

	if quality == 4 then
		if var.settings.mode == var.mode.PT16 then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 4)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
			Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '5000.0')
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '300.0')
		end
		return
	end

	if quality == 5 then
		if var.settings.mode == var.mode.PT16 then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 3)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
			Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '8000.0')
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '400.0')
		end
		return
	end

	if quality == 6 then
		if var.settings.mode == var.mode.PT16 then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 2)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 4)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
			Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '8000.0')
		end

		if var.settings.mode == var.mode.RT_PT
		or var.settings.mode == var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '1000.0')
		end
		return
	end
end

return config
