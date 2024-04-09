-- setstreaming.lua

local logger = require("logger")
local var = require("variables")
local config = {}

function config.SetStreaming(streaming)
    logger.info("Setting streaming to", streaming)

    if streaming == var.streaming.LOW then
        SetOption("Streaming", "MaxNodesPerFrame", "300")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "10.0")
        SetOption("Streaming", "MinStreamingDistance", "20.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
    elseif streaming == var.streaming.MEDIUM then
        SetOption("Streaming", "MaxNodesPerFrame", "300")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "300")
        SetOption("Streaming", "PrecacheDistance", "20.0")
        SetOption("Streaming", "MinStreamingDistance", "40.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "2")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "1")
    elseif streaming == var.streaming.HIGH then
        SetOption("Streaming", "MaxNodesPerFrame", "800")
        SetOption("Streaming", "EditorThrottledMaxNodesPerFrame", "800")
        SetOption("Streaming", "PrecacheDistance", "40.0")
        SetOption("Streaming", "MinStreamingDistance", "80.0")
        SetOption("ResourceLoaderThrottler", "FloodMinNonLoadingThreads", "4")
        SetOption("ResourceLoaderThrottler", "StreamMaxLoadingThreads", "4")
        SetOption("ResourceLoaderThrottler", "TrickleMaxLoadingThreads", "2")
    end
end

return config
