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
	ui.tooltip('Why do I need to \'click apply\'? There is a bug in CET that causes a CTD if we do it for you. We hope the CET team will fix it soon.')

	ui.sameLine()
	local renderingModes = {
		{ key = 'RASTER', label = 'Rast', tooltip = 'Configures normal raster, with optimisations and fixes.' },
		{ key = 'RT', label = 'RT', tooltip = 'Configures normal ray tracing, with optimisations and fixes.' },
		{ key = 'RT_PT', label = 'RT+PT', tooltip = 'Normal raytracing plus path traced bounce lighting. Leave Path Tracing disabled in graphics options for this to work correctly.\n\nRT+PT is an excellent compromise for lower end PCs which cannot achieve full path tracing.' },
		{ key = 'PT16', label = '16', tooltip = 'PT16 is the path tracing method of Cyberpunk 1.63. Requires NRD (disable Ray Reconstruction).\n\nPT16 is lower detail, but is extremely fast and very consistent. It\'s great for playthroughs on lower-end PCs.' },
		{ key = 'PT20', label = '20', tooltip = 'PT20 is the path tracing method from Cyberpunk 2.0.\n\nPT20 is very fast at low quality (Fast, Medium) but becomes very expensive at higher qualities.' },
		{ key = 'PT21', label = '21', tooltip = 'PT21 is the path tracing method from Cyberpunk 2.10 to 2.21.\n\nPT21 has good performance and is consistent for playthroughs, but is generally obsoleted by PTNextV2.' },
		{ key = 'PTNEXT', label = 'NextV2', tooltip = 'PTNextV2 is an unreleased, more advanced, path tracing method that is in Cyberpunk, but not available.\n\nNote: For PTNextV2 to work, you MUST load a save game, or set Ultra+ to PTNextV2 from the main menu (before a game is loaded). Changing the Graphics Menu may also require a reload.\n\nNote2: Occasionally PTNext has a bug where a shadow appears at the top of the screen. To fix this, open inventory -> close it again. We haven\'t found a solution for this yet.' }
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
			if key == 'VANILLA' and Var.settings.mode ~= Var.mode.PT21 then
				goto continue
			end

			local value = Var.quality[key]
			if ui.radio(value .. '##Quality', Var.settings.quality == value) then
				Var.settings.quality = value
				Config.SetQuality(Var.settings.quality)
				SaveConfig()
			end

			ui.sameLine()
			::continue::
		end
	end

	local sceneScaleOrder = { 'OFF', 'FAST', 'VANILLA', 'HIGH', 'INSANE', 'CRAZY' }
	ui.space()

	local disableRadianceCache = Var.settings.mode == Var.mode.RASTER or Var.settings.mode == Var.mode.RT or Var.settings.mode == Var.mode.RT_PT or Var.settings.mode == Var.mode.PT16 -- also test RT+PT
	if disableRadianceCache then
		ImGui.BeginDisabled(true)
	end

	if ui.header('SHaRC Lighting Cache') then
		ui.sameLine()
		ui.info('Nvidia SHaRC draws and caches large blobs of colour from traced rays.\n\nRays are drawn on a colored background instead of a black background, giving denoisers less work to do (although I\'m not convinced CDPR has implemented this part correctly).\n\nBecause of how it works, SHaRC speeds up path tracing and adds additional bounce lighting information.\n\nNote: Generally stay around 50 to 100. High SHaRC values might add detail, but slow down screen updates even on high end computers.', true)
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

	local graphicsOrder = { 'OFF', 'POTATO', 'FAST', 'MEDIUM', 'HIGH' }
	ui.space()
	if ui.header('Control Graphics Menu Settings') then
		ui.sameLine()
		ui.info('Ultra+ will take control of the game\'s Graphics Menu, using optimised settings based on several reputable benchmarks of all the settings.\n\nUse this feature if you don\'t want to configure the graphics menu yourself (to disable this functionality, set to: Off).', true)
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

	local vramOrder = { '4/6/8', '8', '10', '12', '16', '20/24', '32+' }
	ui.space()
	if ui.header('VRAM Gigabiggies') then
		ui.sameLine()
		ui.info('Ultra+ will optimise your streaming settings based on your VRAM.\n\nNote: This is not exact, there are a number of assumptions we make about your PC based on your VRAM. You can try slightly higher or lower than your actual VRAM, until streaming is smooth for you.\n\nNote2: If you run out of VRAM (due to texture mods etc.) this setting won\'t help. If you have less than 12GB VRAM try lowering Texture Quality to \'Medium\' in the main menu (accessible only before you load a game).', true)
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
			local disabled = false
			if setting.item == 'EnableRIS' and Var.settings.mode == Var.mode.PTNEXT then
				disabled = true
			end

			if disabled then
				ImGui.BeginDisabled(true)
			end

			setting.value = Cyberpunk.GetOption(setting.category, setting.item)
			setting.value, toggled = ui.checkbox(setting.name, setting.value)
			ui.tooltip(setting.tooltip)

			if toggled then
				Cyberpunk.SetOption(setting.category, setting.item, setting.value)
				SaveConfig()
			end

			if disabled then
				ImGui.EndDisabled()
			end
		end

		local lightingEnabled, toggled = ui.checkbox('Enable PT Lighting Adjustments', toboolean(Var.settings.ptLightingAdjustments))
		if toggled then
			Var.settings.ptLightingAdjustments = lightingEnabled
			if lightingEnabled then
				Logger.info('Enabling PT lighting adjustments')
				LoadIni('config/ptlighting_on.ini', true)
			else
				Logger.info('Disabling PT lighting adjustments')
				LoadIni('config/ptlighting_off.ini', true)
			end
			SaveConfig()
		end

		local hairEnabled, toggled = ui.checkbox('Enable Hair Adjustments', toboolean(Var.settings.hairAdjustments))
		ui.sameLine()
		ui.info('Adjusts hair to look more realistic with path traced lighting.', false)
		if toggled then
			Var.settings.hairAdjustments = hairEnabled
			DoHairAdjustments()
			SaveConfig()
		end

		local preemHair, toggled = ui.checkbox('Preem Hair Support', toboolean(Var.settings.preemHair))
		ui.sameLine()
		ui.info('Adjusts hair to look more realistic with path traced lighting. Only intended to be used with Preem Hair/Beards.', false)
		if toggled then
			Var.settings.preemHair = preemHair
			DoHairAdjustments()
			SaveConfig()
		end
	end

	ui.space()
	Var.settings.console, toggled = ui.checkbox('Console', toboolean(Var.settings.console))
	ui.tooltip('When checked, Ultra+ will log what it\'s doing to the CET console.')
	if toggled then
		SaveConfig()
	end

	ui.sameLine(115)
	Var.settings.tooltips, toggled = ui.checkbox('Tooltips', toboolean(Var.settings.tooltips))
	ui.tooltip('When checked, Ultra+ will display tooltips when you hover over items.', true)
	if toggled then
		SaveConfig()
	end

	ui.sameLine(220)
	Var.settings.stableFps, toggled = ui.checkbox('FPS Target', toboolean(Var.settings.stableFps))
	ui.tooltip('When enabled, Ultra+ will adjust the quality of ray/path tracing in real-time to maintain the FPS target you set.\n\nTo set an FPS Target, choose a number just below your real FPS. Ultra+ will try to maintain this FPS.\n\nNote: FPS Target is in real FPS. You can see your \'Real FPS\' at the top of Ultra+.')
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
