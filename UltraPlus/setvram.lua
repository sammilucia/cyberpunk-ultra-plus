-- setquality.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetVram(vram)
    logger.info("Setting vram to", vram)

    if vram == var.vram.OFF then
        SetOption("Rendering", "FakeOverrideGPUVRAM", false)
        SetOption("Rendering", "FakeGPUVRAM", "9.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "4000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "512")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "64")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "128")

        SetOption("Streaming", "MaxNodesPerFrame", "400")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "0.0")
        SetOption("Streaming", "MinStreamingDistance", "0.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB4 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "1.5")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "600")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "512")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "64")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "128")

        SetOption("Streaming", "MaxNodesPerFrame", "300")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "0.0")
        SetOption("Streaming", "MinStreamingDistance", "0.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB6 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "3.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "1500")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "512")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "64")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "192")

        SetOption("Streaming", "MaxNodesPerFrame", "300")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "0.0")
        SetOption("Streaming", "MinStreamingDistance", "0.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB8 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "4.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "2000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "768")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "80")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "224")

        SetOption("Streaming", "MaxNodesPerFrame", "300")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "10.0")
        SetOption("Streaming", "MinStreamingDistance", "20.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB10 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "5.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "2500")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "80")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "224")

        SetOption("Streaming", "MaxNodesPerFrame", "300")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "10.0")
        SetOption("Streaming", "MinStreamingDistance", "20.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB12 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "6.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "3000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "96")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "224")

        SetOption("Streaming", "MaxNodesPerFrame", "400")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "400")
        SetOption("Streaming", "PrecacheDistance", "15.0")
        SetOption("Streaming", "MinStreamingDistance", "30.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB16 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "8.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "4000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "112")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "256")

        SetOption("Streaming", "MaxNodesPerFrame", "500")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "500")
        SetOption("Streaming", "PrecacheDistance", "25.0")
        SetOption("Streaming", "MinStreamingDistance", "50.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "3")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "3")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
        return
    end

    if vram == var.vram.GB20 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "10.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "5000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "128")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "320")

        SetOption("Streaming", "MaxNodesPerFrame", "600")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "600")
        SetOption("Streaming", "PrecacheDistance", "30.0")
        SetOption("Streaming", "MinStreamingDistance", "60.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "4")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "4")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "2")
        return
    end

    if vram == var.vram.GB24 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "12.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "6000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "128")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "320")

        SetOption("Streaming", "MaxNodesPerFrame", "800")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "800")
        SetOption("Streaming", "PrecacheDistance", "40.0")
        SetOption("Streaming", "MinStreamingDistance", "80.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "4")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "4")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "2")
        return
    end
end

return config
