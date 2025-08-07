-- setquality.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetVram(vram)

	Logger.info('Configuring vram for', vram, 'GB')

	if vram == Var.vram.OFF then
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxBatchSize', '500')					-- vanilla 500
		Cyberpunk.SetOption('Rendering', 'DistantShadowsMaxTrianglesPerBatch', '400000')		-- vanilla 400000
		Cyberpunk.SetOption('Rendering', 'RainMapBatchMaxSize', '300')							-- vanilla 300
		Cyberpunk.SetOption('Rendering', 'RainMapBatchMaxTrianglesPerBatch', '200000')			-- vanilla 200000

		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '4096.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')				-- PT default is 256
		-- controlled by General Shadow Fixes
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '300')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '500')
	end

	if vram == Var.vram.GB4 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '64')
		-- controlled by General Shadow Fixes
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '192')			-- PT default is 256

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

		return
	end

	if vram == Var.vram.GB10 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '80')
		-- controlled by General Shadow Fixes
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')			-- PT default is 256

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB12 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '96')
		-- controlled by General Shadow Fixes
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '224')			-- PT default is 256

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB16 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '112')
		-- controlled by General Shadow Fixes
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '256')			-- PT default is 256

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '2')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '2')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '1')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB20 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '128')
		-- controlled by General Shadow Fixes
		Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '320')			-- PT default is 256

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')

	end

	if vram == Var.vram.GB32 then
		Cyberpunk.SetOption('World', 'StreamingTeleportMagSq', '8192.0')						-- vanilla 4096.0
		-- controlled by game based on RT mode, changing causes instability
		--Cyberpunk.SetOption('RayTracing', 'AccelerationStructureBuildNumMax', '144')
		-- controlled by General Shadow Fixes
		--Cyberpunk.SetOption('RayTracing/DynamicInstance', 'UpdateProxyNumMax', '384')			-- PT default is 256	

		Cyberpunk.SetOption('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', '3')		-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', '3')			-- vanilla 2
		Cyberpunk.SetOption('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', '2')			-- vanilla 1

		Cyberpunk.SetOption('Streaming', 'MaxNodesPerFrame', '700')
		Cyberpunk.SetOption('Streaming', 'EditorThrottledMaxNodesPerFrame', '700')
	end
end

return Config
