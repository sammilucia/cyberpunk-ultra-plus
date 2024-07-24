-- helpers/logger.lua

local var = require('helpers/variables')
local DEBUG = false

local function init()
	local file = io.open('debug', 'r')
	if file then
		DEBUG = true
		file:close()
	end
end

local __log = function(level)
	return function(...)
		local args = {...}
		for i, v in ipairs(args) do
			if type(v) == 'boolean' then
				args[i] = tostring(v)
			end
		end

		if var.settings.enableConsole then
			print('        Ultra+:', table.concat(args, ' '))
		end

		if level == 'debug' and DEBUG then
			print('        Ultra+ [DEBUG]:', table.concat(args, ' '))
		end
	end
end

local logger = {
	info = __log('info'),
	debug = __log('debug'),
}

init()

return logger
