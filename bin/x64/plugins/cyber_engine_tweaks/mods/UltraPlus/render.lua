-- render.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = require('helpers/config')
Cyberpunk = require('helpers/Cyberpunk')

Stats = {
	fps = 0,
}
local options = require('helpers/options')
local ui = require('helpers/ui')
local toggled
local render = {}

local function toboolean(value)
	if value == 'true' or value == true then
		return true
	elseif value == 'false' or value == false then
		return false
	else
		return nil
	end
end

local function renderMainTab()
	ui.text(Config.Status)

	ui.sameLine()
	local renderingModes = {
		{ key = 'RASTER', label = 'Rast', tooltip = 'Configures normal raster, with optimisations and fixes.' },
		{ key = 'RT', label = 'RT', tooltip = 'Configures normal ray tracing, with optimisations and fixes.' },
		{ key = 'RT_PT', label = 'RT+PT', tooltip = 'Normal raytracing plus path traced bounce lighting. Leave Path Tracing\ndisabled in graphics options for this to work correctly.' },
		{ key = 'PT16', label = '16', tooltip = 'Path tracing method of Cyberpunk 1.63. Requires NRD (disables Ray Reconstruction)' },
		{ key = 'PT20', label = '20', tooltip = 'Path tracing method of Cyberpunk 2.0.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality.' },
		{ key = 'PT21', label = '21', tooltip = 'Path tracing method of Cyberpunk 2.10+.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality.' },
		{ key = 'PTNEXT', label = 'Next', tooltip = 'For this mode to work, you MUST load a save game, or start CyberPunk with\nPTNext enabled. Changing graphics/DLSS will also require a reload.\n\nNOTE: For other PT modes we recommend increasing DLSS/FSR3 and lowering PT\nquality for the best visuals. However for PTNext we recommend the opposite:\nRun PTNext as high as you can and turn upscaling down a step.' }
	}
	ui.space()
	if ui.header('Rendering Mode                | PT >') then
		for _, mode in ipairs(renderingModes) do
			local value = Var.mode[mode.key]
			if ui.radio(mode.label, Var.settings.mode == value) then
				if Var.settings.mode ~= value then
					Var.settings.mode = value
					Var.settings.modeChanged = true
				end

				Config.SetMode(Var.settings.mode)
				Config.SetQuality(Var.settings.quality)
				Config.SetGraphics(Var.settings.graphicsMenuOverrides)
				Config.SetSceneScale(Var.settings.sceneScale)
				SaveConfig()
			end
			ui.tooltip(mode.tooltip)
			ui.sameLine()
		end
	end

	local qualityOrder = { 'VANILLA', 'FAST', 'MEDIUM', 'HIGH', 'INSANE' }
	ui.space()
	if ui.header('Quality Level') then
		for _, key in ipairs(qualityOrder) do
			local value = Var.quality[key]
			if ui.radio(value .. '##Quality', Var.settings.quality == value) then
				Var.settings.quality = value
				Config.SetQuality(Var.settings.quality)
				SaveConfig()
			end
			ui.sameLine()
		end
	end

	local sceneScaleOrder = { 'OFF', 'FAST', 'VANILLA', 'HIGH', 'INSANE', 'CRAZY' }
	ui.space()

	local disableRadianceCache = Var.settings.mode == Var.mode.RASTER or Var.settings.mode == Var.mode.RT or Var.settings.mode == Var.mode.RT_PT or Var.settings.mode == Var.mode.PT16 -- also test RT+PT
	if disableRadianceCache then
		ImGui.BeginDisabled(true)
	end

	if ui.header('SHaRC Lighting Cache Accuracy') then
		ui.tooltip('Nvidia SHaRC predicts the color/brightness of areas of the screen before\ntracing rays. This helps denoisers by giving them more context (rays are\ndrawn on a colored background instead of black). It\'s not desinged to add\ndetail, but at extreme settings it might - at the cost of slow lighting\nupdates as you move. \'Fast\' to \'High\' are recommended.')
		for _, key in ipairs(sceneScaleOrder) do
			local value = Var.sceneScale[key]
			if ui.radio(value .. '##Scenescale', Var.settings.sceneScale == value) then
				Var.settings.sceneScale = value

				Config.SetSceneScale(Var.settings.sceneScale)
				SaveConfig()
			end
			ui.sameLine()
		end
	end

	if disableRadianceCache then
		ImGui.EndDisabled()
	end

	local graphicsOrder = { 'POTATO', 'FAST', 'MEDIUM', 'HIGH', 'OFF' }
	ui.space()
	if ui.header('Override Game Graphics Menu Settings') then
		for _, key in ipairs(graphicsOrder) do
			local value = Var.graphics[key]
			if ui.radio(value .. '##Graphics', Var.settings.graphicsMenuOverrides == value) then
				Var.settings.graphicsMenuOverrides = value

				Config.SetGraphics(Var.settings.graphicsMenuOverrides)
				SaveConfig()
			end
			ui.sameLine()
		end
	end

	local vramOrder = { '4', '6', '8', '10', '12', '16', '20', '24' }
	ui.space()
    if ui.header('VRAM Configuration (GB)') then
        for _, key in ipairs(vramOrder) do
            local value = key
            if ui.radio(key .. '##GB', Var.settings.vram == value) then
                Var.settings.vram = value

                Config.SetVram(Var.settings.vram)
                SaveConfig()
            end
            ui.sameLine()
        end
    end

	ui.space()
	if ui.header('Tweaks') then
		for _, setting in pairs(options.tweaks) do
			setting.value = Cyberpunk.GetOption(setting.category, setting.item)
			setting.value, toggled = ui.checkbox(setting.name, setting.value)
			ui.tooltip(setting.tooltip)

			if toggled then
				Cyberpunk.SetOption(setting.category, setting.item, setting.value)

				SaveConfig()
			end
		end
	end

	ui.space()
	Var.settings.console, toggled = ui.checkbox('Console Output', toboolean(Var.settings.console))
	ui.tooltip('Ultra+ will log what it\'s doing to the CET console')
	if toggled then
		SaveConfig()
	end

	ui.sameLine(175)
	Var.settings.stableFps, toggled = ui.checkbox('Stable FPS Target', toboolean(Var.settings.stableFps))
	ui.tooltip('Ultra+ will use basic perceptual auto-scaling of ray/path\tracing quality to target consistent FPS')
	if toggled then
		SaveConfig()
	end

	if Var.settings.stableFps then
		ui.sameLine()
		ui.width(Var.window.intSize)
		Var.settings.stableFpsTarget, toggled = ui.inputInt('', tonumber(Var.settings.stableFpsTarget), 1)

		if toggled then
			SaveConfig()
		end
	end
end

local function renderSetting(setting, inputType, width)
	setting.value = Cyberpunk.GetOption(setting.category, setting.item)

	ui.width(width)
	if inputType == 'Checkbox' then
		setting.value, toggled = ui.checkbox(setting.name, setting.value)
	elseif inputType == 'InputInt' then
		setting.value, toggled = ui.inputInt(setting.name, setting.value)
	elseif inputType == 'InputFloat' then
		setting.value, toggled = ui.inputFloat(setting.name, tonumber(setting.value))
	end

	ui.tooltip(setting.tooltip)

	if toggled then
		if inputType == 'InputFloat' then
			Cyberpunk.SetOption(setting.category, setting.item, setting.value, 'float')
		else
			Cyberpunk.SetOption(setting.category, setting.item, setting.value)
		end
		SaveConfig()
	end
end

local function renderFeaturesTab()
    local settingGroups = {
        { options.ptFeatures, 'Path Tracing', 'Checkbox' },
        { options.rasterFeatures, 'Raster', 'Checkbox' },
		{ options.postProcessFeatures, 'Post Process', 'Checkbox' },
		{ options.miscFeatures, 'Misc', 'Checkbox' },
    }

	for i, group in ipairs(settingGroups) do
		local settings, heading, inputType = table.unpack(group)
		ui.header(heading)
		if type(settings) == "table" then
			for _, setting in pairs(settings) do
				renderSetting(setting, inputType)
			end
		else
			Logger.info("ERROR: 'settings' is not a table for group " .. heading)
		end
	end
end

local function renderDebugTab()
	local settingGroups = {
		{ options.rtxDi, 'Checkbox' },
		{ options.rtxGi, 'Checkbox' },
		{ options.reGir, 'Checkbox' },
		{ options.reLax, 'Checkbox' },
		{ options.reBlur, 'Checkbox' },
		{ options.nrd, 'Checkbox' },
		{ options.rtOptions, 'Checkbox' },
		{ options.sharc, 'Checkbox' },
		{ options.rtInt, 'InputInt', Var.window.intSize },
		{ options.rtFloat, 'InputFloat', Var.window.floatSize },
	}

	ui.space()
	ui.text('Filter by:')
	ui.sameLine()
	ui.width(120)
	Var.window.filterText = ui.filter('##Filter', Var.window.filterText, 100)

	ui.separator()
	for _, group in ipairs(settingGroups) do
		local settings, inputType, width = table.unpack(group)
		if type(settings) == "table" then
			local hasVisibleItems = false
			for _, setting in pairs(settings) do
				if Var.window.filterText == '' or string.find(string.lower(setting.name), string.lower(Var.window.filterText)) then
					if not hasVisibleItems then
						hasVisibleItems = true
					end
					renderSetting(setting, inputType, width)
				end
			end
			if hasVisibleItems then
				ui.separator()
			end
		else
			Logger.info("ERROR: 'settings' is not a table for input type: " .. tostring(inputType))
		end
	end
end

local function renderTabs()
	ui.tabBar(function()
		ui.tab('Ultra+ Config', renderMainTab)
		ui.tab('Rendering Features', renderFeaturesTab)
		ui.tab('Debug', renderDebugTab)
	end)
end

local function renderFps()
	if Stats.fps == 0 then
		return
	end

	local fpsText = string.format('Real FPS: %.0f', Stats.fps) -- lazy makeshift round function
	ui.sameLine(340)
	ui.text(fpsText)
end

render.renderUI = function(fps, open)
	Stats.fps = fps

	ui.window('Ultra+ v'..UltraPlus.__VERSION, ImGuiWindowFlags.NoResize, function()
		renderTabs()
		renderFps()
	end)
end

return render
