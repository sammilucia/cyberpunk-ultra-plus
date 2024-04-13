-- setquality.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetVram(vram)
    logger.info("Setting vram to", vram)

    if vram == var.vram.GB4 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "1.5")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "600")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "512")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "64")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "128")
        return
    end

    if vram == var.vram.GB6 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "3.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "1500")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "512")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "64")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "192")
        return
    end

    if vram == var.vram.GB8 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "4.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "2000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "768")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "80")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "224")
        return
    end

    if vram == var.vram.GB10 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "5.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "2500")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "80")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "224")
        return
    end

    if vram == var.vram.GB12 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "6.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "3000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "96")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "224")
        return
    end

    if vram == var.vram.GB16 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "8.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "4000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "112")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "256")
        return
    end

    if vram == var.vram.GB24 then
        SetOption("Rendering", "FakeOverrideGPUVRAM", true)
        SetOption("Rendering", "FakeGPUVRAM", "12.0")
        SetOption("World/Streaming/PersistencyCache", "PoolBudgetKB", "6000")
        SetOption("Rendering", "DistantShadowsMaxBatchSize", "1024")
        SetOption("RayTracing", "AccelerationStructureBuildNumMax", "128")
        SetOption("RayTracing/DynamicInstance", "UpdateProxyNumMax", "320")
        return
    end
end

return config
