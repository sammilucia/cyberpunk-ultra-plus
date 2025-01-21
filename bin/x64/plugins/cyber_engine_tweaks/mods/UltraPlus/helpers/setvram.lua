-- setquality.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetVram(vram)

	Logger.info('Configuring vram for', vram, 'GB')

	if vram == Var.vram.OFF then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '4096.000000')				-- vanilla 4096
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '500')  				-- vanilla 500
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxTrianglesPerBatch', '400000')	-- vanilla 400000
		Cyberpunk.SetOption('Rendering', 'RainMapBatchMaxSize', '300')  					-- vanilla 300
		Cyberpunk.SetOption('Rendering', 'RainMapBatchMaxTrianglesPerBatch', '200000')  	-- vanilla 200000

		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')

	end

	if vram == Var.vram.GB4 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096

		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')				-- vanilla 64
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')			-- vanilla 192

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

		return
	end

	if vram == Var.vram.GB6 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096

		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')				-- vanilla 64
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')			-- vanilla 192

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

		return
	end

	if vram == Var.vram.GB8 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096

		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')				-- vanilla 64
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')			-- vanilla 192

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB10 then
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '80')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB12 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '96')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB16 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '112')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '256')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB20 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')					-- vanilla 4096
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128')
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB24 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.000000')				-- vanilla 4096
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128') 		
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320') 		

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')

		Cyberpunk.SetOption('Streaming', 'PrecacheDistance', '0.0')
		Cyberpunk.SetOption('Streaming', 'MinStreamingDistance', '1.0')
		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')
	end
end

return Config
