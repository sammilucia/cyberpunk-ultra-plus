-- helpers/logger.lua

local var = require("helpers/variables")
local logger = {}

local __log = function(level)
	return function(...)
		local args = {...}
		for i, v in ipairs(args) do
			if type(v) == "boolean" then
				args[i] = tostring(v)
			end
		end

		if var.settings.enableConsole then
			print("        Ultra+:", table.concat(args, " "))
		end
	end
end

local logger = {
	info = __log("info"),
	debug = __log("debug"),
}

return logger
