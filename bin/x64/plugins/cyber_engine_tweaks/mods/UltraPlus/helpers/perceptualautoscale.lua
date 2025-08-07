-- perceptualautoscale.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.AutoScale(quality)

	local percentage = math.floor((quality / 6) * 100)
	Logger.info('    (Target FPS: Auto-scaling perceptual quality to', percentage..'%)')

	if quality == 1 then
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '100.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '800.0')

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.RTOnly or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '7')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '0')
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '1000.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '7')
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '0')
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', 1)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', 1)
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.PT21 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0')
		end

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '1')
		end

		return
	end

	if quality == 2 then
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '100.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '800.0')

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.RTOnly or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 0)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '1500.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', 1)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', 1)
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.PT21 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '1')
		end

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '2')
		end

		return
	end

	if quality == 3 then
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '1500.0')

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.RTOnly or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '3000.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 6)
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', 2)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', 1)
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.PT21 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '1')
		end

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '2')
		end

		return
	end

	if quality == 4 then
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '300.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '1500.0')

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.RTOnly or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 1)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '3000.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 6)
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', 2)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', 2)
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.PT21 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '2')
		end

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '3')
		end

		return
	end

	if quality == 5 then
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '400.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '8000.0')

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.RTOnly or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '9000.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 5)
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', 2)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', 3)
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.PT21 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '3')
		end

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '4')
		end

		return
	end

	if quality == 6 then
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '1000.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '8000.0')

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.RTOnly or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 7)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 2)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '9000.0')
		else
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', 5)
			Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '100.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', 3)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 then
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', 3)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', 3)
		end

		if Var.settings.mode == Var.mode.PT16 or Var.settings.mode == Var.mode.PT20 or Var.settings.mode == Var.mode.PT21 or Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '3')
		end

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '4')
		end

		return
	end
end

return Config
