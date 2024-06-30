-- logger.lua

local var = require("variables")

local __log = function(level)
    return function(...)
        if var.settings.enableConsole then
            print("          Ultra+:", ...)
        end
    end
end

local logger = {
    info = __log("info"),
}

return logger
