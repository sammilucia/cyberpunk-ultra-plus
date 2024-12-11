-- setquality.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetVram(vram)
	Logger.info('Configuring vram for', vram, 'GB')

	if vram == Var.vram.OFF then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '512')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')			-- vanilla value is 500
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

		Logger.info('    (NSGDD compatibility force-enabled due to low VRAM)')
		Var.settings.nsgddCompatible = true

		return
	end

	if vram == Var.vram.GB4 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')		-- how does this not OOM?
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '512')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '128')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

		Logger.info('    (NSGDD compatibility force-enabled due to low VRAM)')
		Var.settings.nsgddCompatible = true

		return
	end

	if vram == Var.vram.GB6 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')		-- WAS 1500
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '512')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

		Logger.info('    (NSGDD compatibility force-enabled due to low VRAM)')

		return
	end

	if vram == Var.vram.GB8 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')		-- WAS 2000
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '768')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '80')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if Var.settings.nsgddCompatible == false then
			Logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		else
			Logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')
		end

		return
	end

	if vram == Var.vram.GB10 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')		-- WAS 2500
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '80')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if Var.settings.nsgddCompatible == false then
			Logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		else
			Logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')
		end

		return
	end

	if vram == Var.vram.GB12 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')		-- WAS 3000
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '96')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if Var.settings.nsgddCompatible == false then
			Logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		else
			Logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')
		end

		return
	end

	if vram == Var.vram.GB16 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '112')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '256')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if Var.settings.nsgddCompatible == false then
			Logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		else
			Logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')
		end

		return
	end

	if vram == Var.vram.GB20 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '5000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')

		if Var.settings.nsgddCompatible == false then
			Logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')						-- WAS 500
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')		-- WAS 500
		else
			Logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')						-- WAS 500
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')		-- WAS 500
		end

		return
	end

	if vram == Var.vram.GB24 then
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '6000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')

		if Var.settings.nsgddCompatible == false then
			Logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')						-- WAS 500
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')		-- WAS 500
		else
			Logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
			Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')						-- WAS 500
			Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')		-- WAS 500
		end

		return
	end
end

return Config
