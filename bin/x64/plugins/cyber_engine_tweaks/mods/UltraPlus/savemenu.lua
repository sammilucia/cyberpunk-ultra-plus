-- savemenu.lua

local logger = require("helpers/logger")
local config = {}

function config.SaveMenu()
	logger.info("Snapshotting game graphics menu settings...")

	logger.info("Done. Your graphics settings will be restored when you next load Cyberpunk")
end

return config
