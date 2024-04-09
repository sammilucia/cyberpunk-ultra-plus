-- logger.lua

local __log = function(level)
    return function(...)
        print(string.rep("-", 10), "Ultra+:", ...)
    end
end

local logger = {
    info = __log("info")
}

return logger
