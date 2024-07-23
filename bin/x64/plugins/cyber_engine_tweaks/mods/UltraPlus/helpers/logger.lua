-- helpers/logger.lua

local var = require("helpers/variables")

local logger = {}

local __log = function(level)
	return function(...)
		local message = table.concat({...}, " ")
		if var.settings.enableConsole then
			print("        Ultra+:", message)
		end
	end
end

local logger = {
	info = __log("info"),
	debug = __log("debug"),
	status = logger.info,
}

return logger
