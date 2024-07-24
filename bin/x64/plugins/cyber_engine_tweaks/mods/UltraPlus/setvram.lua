-- setquality.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local Cyberpunk = require('helpers/Cyberpunk')
local config = {}

function config.SetVram(vram)
	logger.info('Configuring vram for', vram, 'GB')

	if vram == var.vram.OFF then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', false)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '9.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '512')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '300')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

		logger.info('    (NSGDD compatibility force-enabled due to low VRAM)')
		var.settings.nsgddCompatible = true

		return
	end

	if vram == var.vram.GB4 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '1.5')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '600')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '512')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '128')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '300')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

		logger.info('    (NSGDD compatibility force-enabled due to low VRAM)')
		var.settings.nsgddCompatible = true

		return
	end

	if vram == var.vram.GB6 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '3.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '1500')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '512')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '300')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

		logger.info('    (NSGDD compatibility force-enabled due to low VRAM)')

		return
	end

	if vram == var.vram.GB8 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '4.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '2000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '768')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '80')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '300')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if var.settings.nsgddCompatible == false then
			logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
		else
			logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		end

		return
	end

	if vram == var.vram.GB10 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '5.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '2500')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '80')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '300')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if var.settings.nsgddCompatible == false then
			logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '10.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '20.0')
		else
			logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		end

		return
	end

	if vram == var.vram.GB12 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '6.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '3000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '96')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '400')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '400')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if var.settings.nsgddCompatible == false then
			logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '15.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '30.0')
		else
			logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		end

		return
	end

	if vram == var.vram.GB16 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '8.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '4000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '112')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '256')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '400')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '400')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		if var.settings.nsgddCompatible == false then
			logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '25.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '50.0')
		else
			logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		end

		return
	end

	if vram == var.vram.GB20 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '10.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '5000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')

		if var.settings.nsgddCompatible == false then
			logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '30.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '60.0')
		else
			logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		end

		return
	end

	if vram == var.vram.GB24 then
		Cyberpunk.SetOption('Rendering', 'FakeOverrideGPUVRAM', true)
		Cyberpunk.SetOption('Rendering', 'FakeGPUVRAM', '12.0')
		Cyberpunk.SetOption('World/Streaming/PersistencyCache', 'PoolBudgetKB', '6000')
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '1024')
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '500')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')

		if var.settings.nsgddCompatible == false then
			logger.info('    (NSGDD compatibility disabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '40.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '80.0')
		else
			logger.info('    (NSGDD compatibility enabled)')
			Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
			Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		end

		return
	end
end

return config
