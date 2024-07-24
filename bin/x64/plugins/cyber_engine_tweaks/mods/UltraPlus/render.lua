-- render.lua

local var = require("helpers/variables")
local config = require("helpers/config")
local options = require("helpers/options")
local ui = require("helpers/ui")
local stats = {
	fps = 0,
}
local toggled
local render = {}

local function renderMainTab()
	ui.text(config.status)

	ui.sameLine()
	local renderingModes = {
		{ key = "RASTER", label = "Rast", tooltip = "Configures normal raster, with optimisations and fixes." },
		{ key = "RT", label = "RT", tooltip = "Configures normal ray tracing, with optimisations and fixes." },
		{ key = "RT_PT", label = "RT+PT", tooltip = "Normal raytracing plus path traced bounce lighting. Leave Path Tracing\ndisabled in graphics options for this to work correctly." },
		{ key = "PT16", label = "16", tooltip = "Path tracing from Cyberpunk 1.6x. Requires NRD (disable Ray Reconstruction)" },
		{ key = "PT20", label = "20", tooltip = "Path tracing from Cyberpunk 2.0.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality." },
		{ key = "PT21", label = "21", tooltip = "Path tracing from Cyberpunk 2.10+.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality." },
		{ key = "PTNEXT", label = "Next", tooltip = "For this mode to work, you MUST load a save game, or start CyberPunk with\nPTNext enabled. Changing graphics/DLSS will also require a reload.\n\nNOTE: For other PT modes we recommend increasing DLSS/FSR3 and lowering PT\nquality for the best visuals. However for PTNext we recommend the opposite:\nRun PTNext as high as you can and turn upscaling down a step." }
	}
	ui.space()
	if ui.header("Rendering Mode                 | PT >") then
		for _, mode in ipairs(renderingModes) do
			local modeValue = var.mode[mode.key]
			if ui.radio(mode.label, var.settings.mode == modeValue) then
				var.settings.mode = modeValue

				config.SetMode(var.settings.mode)
				config.SetQuality(var.settings.quality)
				config.SetGraphics(var.settings.graphics)
				config.SetSceneScale(var.settings.sceneScale)
				SaveSettings()
			end
			ui.tooltip(mode.tooltip)
			ui.sameLine()
		end
	end

	local qualityOrder = { "VANILLA", "FAST", "MEDIUM", "HIGH", "INSANE" }
	ui.space()
	if ui.header("Quality Level") then
		for _, key in ipairs(qualityOrder) do
			local value = var.quality[key]
			if ui.radio(value .. "##Quality", var.settings.quality == value) then
				var.settings.quality = value
				config.SetQuality(var.settings.quality)
				SaveSettings()
			end
			ui.sameLine()
		end
	end

	local sceneScaleOrder = { "PERFORMANCE", "VANILLA", "BALANCED", "QUALITY" }
	ui.space()

	local disableRadianceCache = var.settings.mode == var.mode.RASTER or var.settings.mode == var.mode.RT or var.settings.mode == var.mode.RT_PT -- or var.settings.mode == var.mode.PT16 -- also test RT+PT
	if disableRadianceCache then
		ImGui.BeginDisabled(true)
	end

	if ui.header("Bounce Lighting Accuracy") then
		for _, key in ipairs(sceneScaleOrder) do
			local value = var.sceneScale[key]
			if ui.radio(value .. "##Scenescale", var.settings.sceneScale == value) then
				var.settings.sceneScale = value

				config.SetSceneScale(var.settings.sceneScale)
				SaveSettings()
			end
			ui.sameLine()
		end
	end

	if disableRadianceCache then
		ImGui.EndDisabled()
	end

	local graphicsOrder = { "POTATO", "FAST", "MEDIUM", "HIGH" }
	ui.space()
	if ui.header("Game Graphics Settings (plus raster tweaks)") then
		for _, key in ipairs(graphicsOrder) do
			local value = var.graphics[key]
			if ui.radio(value .. "##Graphics", var.settings.graphics == value) then
				var.settings.graphics = value

				config.SetGraphics(var.settings.graphics)
				SaveSettings()
			end
			ui.sameLine()
		end
	end

	ui.space()
	if ui.header("VRAM Configuration (GB)") then
		local vramSorted = {}
		for _, value in pairs(var.vram) do
			table.insert(vramSorted, value)
		end
		table.sort(vramSorted)

		for _, key in ipairs(vramSorted) do
			if ui.radio(tostring(key) .. "##GB", var.settings.vram == key) then
				var.settings.vram = key

				config.SetVram(var.settings.vram)
				SaveSettings()
			end
			ui.sameLine()
		end
	end

	ui.space()
	if ui.header("Tweaks") then
		for _, setting in pairs(options.tweaks) do
			setting.value = GetOption(setting.category, setting.item)
			setting.value, toggled = ui.checkbox(setting.name, setting.value)
			ui.tooltip(setting.tooltip)

			if toggled then
				SetOption(setting.category, setting.item, setting.value)

				if setting.item == "nsgddCompatible" then
					config.SetVram(var.settings.vram)
				end

				SaveSettings()
			end
		end
	end

	ui.space()
	var.settings.enableConsole, toggled = ui.checkbox("Console", var.settings.enableConsole)
	ui.tooltip("Ultra+ will log what it's doing to the CET console")
	if toggled then
		SaveSettings()
	end

	ui.sameLine(136)
	var.settings.enableTargetFps, toggled = ui.checkbox("Enable Target FPS", var.settings.enableTargetFps)
	ui.tooltip("Ultra+ will use basic perceptual auto-scaling of ray/path\tracing quality to target consistent FPS")
	if toggled then
		SaveSettings()
	end

	if var.settings.enableTargetFps then
		ui.sameLine()
		ui.width(var.window.intSize)
		var.settings.targetFps, toggled = ui.inputInt("", var.settings.targetFps, 1)

		if toggled then
			SaveSettings()
		end
	end
end

local function renderSetting(setting, inputType, width)
	setting.value = GetOption(setting.category, setting.item)

	ui.width(width)
	if inputType == "Checkbox" then
		setting.value, toggled = ui.checkbox(setting.name, setting.value)
	elseif inputType == "InputInt" then
		setting.value, toggled = ui.inputInt(setting.name, setting.value)
	elseif inputType == "InputFloat" then
		setting.value, toggled = ui.inputFloat(setting.name, tonumber(setting.value))
	end

	ui.tooltip(setting.tooltip)

	if toggled then
		if inputType == "InputFloat" then
			SetOption(setting.category, setting.item, setting.value, "float")
		else
			SetOption(setting.category, setting.item, setting.value)
		end
		SaveSettings()
	end
end

local function renderFeaturesTab()
    local settingGroups = {
        { options.ptFeatures, "Path Tracing", "Checkbox" },
        { options.rasterFeatures, "Raster", "Checkbox" },
		{ options.postProcessFeatures, "Post Process", "Checkbox" },
		{ options.miscFeatures, "Misc", "Checkbox" },
    }

	for i, group in ipairs(settingGroups) do
		local settings, heading, inputType = table.unpack(group)
		ui.header(heading)
		for _, setting in pairs(settings) do
			if var.window.filterText == "" or string.find(string.lower(setting.name), string.lower(var.window.filterText)) then
				renderSetting(setting, inputType)
			end
		end
	end
end

local function renderDebugTab()
	local settingGroups = {
		{ options.rtxDi, "Checkbox" },
		{ options.rtxGi, "Checkbox" },
		{ options.reGir, "Checkbox" },
		{ options.reLax, "Checkbox" },
		{ options.reBlur, "Checkbox" },
		{ options.nrd, "Checkbox" },
		{ options.rtOptions, "Checkbox" },
		{ options.sharc, "Checkbox" },
		{ options.rtInt, "InputInt", var.window.intSize },
		{ options.rtFloat, "InputFloat", var.window.floatSize },
	}

	ui.space()
	ui.text("Filter by:")
	ui.sameLine()
	ui.width(120)
	var.window.filterText = ui.filter("##Filter", var.window.filterText, 100)

	ui.separator()
	for _, group in ipairs(settingGroups) do
		local settings, inputType, width = table.unpack(group)
		local hasVisibleItems = false
		for _, setting in pairs(settings) do
			if var.window.filterText == "" or string.find(string.lower(setting.name), string.lower(var.window.filterText)) then
				if not hasVisibleItems then
					hasVisibleItems = true
				end
				renderSetting(setting, inputType, width)
			end
		end
		if hasVisibleItems then
			ui.separator()
		end
	end
end

local function renderTabs()
	ui.tabBar(function()
		ui.tab("Ultra+ Config", renderMainTab)
		ui.tab("Rendering Features", renderFeaturesTab)
		ui.tab("Debug", renderDebugTab)
	end)
end

local function renderFps()
	if stats.fps == 0 then
		return
	end

	local fpsText = string.format("Real FPS: %.0f", stats.fps) -- lazy makeshift round function
	ui.sameLine(296)
	ui.text(fpsText)
end

render.renderUI = function(fps, open)
	stats.fps = fps

	ui.window("Ultra+ v"..UltraPlus.__VERSION, ImGuiWindowFlags.NoResize, function()
		renderTabs()
		renderFps()
	end)
end

return render
