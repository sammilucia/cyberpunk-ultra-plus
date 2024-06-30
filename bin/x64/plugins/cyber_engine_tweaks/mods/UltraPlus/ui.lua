--ui.lua

local options = require("options")
local var = require("variables")
local config = {
	SetMode = require("setmode").SetMode,
	SetQuality = require("setquality").SetQuality,
	SetSceneScale = require("setscenescale").SetSceneScale,
	SetVram = require("setvram").SetVram,
	DEBUG = true,
	isDebugTabActive = false,
	windowWidth = 485,
	windowHeight = 454,
	windowHeightDebug = 910,
	fpsWidth = 60,
}
local stats = {
	fps = 0,
}
local toggled
local ui = {

	line = function()
		ImGui.Spacing()
		ImGui.Separator()
		ImGui.Spacing()
	end,

	space = function()
		ImGui.Spacing()
	end,

	width = function(px)
		ImGui.SetNextItemWidth(px)
	end,

	align = function()
		ImGui.SameLine()
	end,

	text = function(text)
		ImGui.Text(text)
	end,

	section = function(text)
		ImGui.Spacing()
		ImGui.Separator()
		ImGui.TextWrapped(text)
		ImGui.Spacing()
	end,

	heading = function(text)
		ImGui.Spacing()
		ImGui.Text("Skin/Hair")
		ImGui.Spacing()
	end,

	tooltip = function(text)
		if ImGui.IsItemHovered() and text ~= "" then
			ImGui.BeginTooltip()
			ImGui.SetTooltip(text)
			ImGui.EndTooltip()
		end
	end,
}

local function renderTabEngineDrawer()

	ui.text("NOTE: Once happy, reload a save to fully activate the mode")

	local renderingModes = {
		{ key = "RT_ONLY", label = "RT Only", tooltip = "Regular ray tracing, with optimisations and fixes." },
		{ key = "RT_PT", label = "RT+PT", tooltip = "Normal raytracing plus path traced bounce lighting. Leave Path Tracing\ndisabled in graphics options for this to work correctly." },
		{ key = "PT20", label = "PT20", tooltip = "Path tracing from Cyberpunk 2.0.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality." },
		{ key = "PT21", label = "PT21", tooltip = "Path tracing from Cyberpunk 2.10+.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality." },
		{ key = "PTNEXT", label = "PTNext", tooltip = "For this mode to work, you MUST load a save game, or start CyberPunk with\nPTNext enabled. Changing graphics/DLSS will also require a reload.\n\nNOTE: For other PT modes we recommend increasing DLSS/FSR3 and lowering PT\nquality for the best visuals. However for PTNext we recommend the opposite:\nRun PTNext as high as you can and turn upscaling down a step." }
	}
	ui.space()
	if ImGui.CollapsingHeader("Rendering Mode", ImGuiTreeNodeFlags.DefaultOpen) then
		for _, mode in ipairs(renderingModes) do
			local modeValue = var.mode[mode.key]
			if ImGui.RadioButton(mode.label, var.settings.mode == modeValue) then
				var.settings.mode = modeValue
				config.SetMode(var.settings.mode)
				config.SetQuality(var.settings.quality)
				config.SetSceneScale(var.settings.sceneScale)
				SaveSettings()
			end
			ui.tooltip(mode.tooltip)
			ui.align()
		end
	end

	local qualityOrder = { "VANILLA", "LOW", "MEDIUM", "HIGH", "INSANE" }
	ui.space()
	if ImGui.CollapsingHeader("Quality Level", ImGuiTreeNodeFlags.DefaultOpen) then
		for _, key in ipairs(qualityOrder) do
			local qualityLabel = var.quality[key] .. "##Quality"
			local qualityValue = var.quality[key]
			if ImGui.RadioButton(qualityLabel, var.settings.quality == qualityValue) then
				var.settings.quality = qualityValue

				if key ~= "VANILLA" then
					local iniFilename = "config_" .. string.lower(key) .. ".ini"
					LoadIni(iniFilename)
				end

				config.SetQuality(var.settings.quality)
				SaveSettings()
			end
			ui.align()
		end
	end

	local sceneScaleOrder = { "LOW", "VANILLA", "MEDIUM", "HIGH" }
	ui.space()
	if ImGui.CollapsingHeader("Radiance Cache Accuracy", ImGuiTreeNodeFlags.DefaultOpen) then
		for _, key in ipairs(sceneScaleOrder) do
			local scaleLabel = var.sceneScale[key] .. "##SS"
			local scaleValue = var.sceneScale[key]
			if ImGui.RadioButton(scaleLabel, var.settings.sceneScale == scaleValue) then
				var.settings.sceneScale = scaleValue
				config.SetSceneScale(var.settings.sceneScale)
				SaveSettings()
			end
			ui.align()
		end
	end

	ui.space()
	if ImGui.CollapsingHeader("VRAM Configuration (GB)", ImGuiTreeNodeFlags.DefaultOpen) then
		local vramSorted = {}
		for key, value in pairs(var.vram) do
			table.insert(vramSorted, value)
		end

		table.sort(vramSorted)

		for _, v in ipairs(vramSorted) do
			if ImGui.RadioButton(tostring(v), var.settings.vram == v) then
				var.settings.vram = v
				config.SetVram(var.settings.vram)
				SaveSettings()
			end
			ui.align()
		end
	end

	ui.space()
	if ImGui.CollapsingHeader("Tweaks", ImGuiTreeNodeFlags.DefaultOpen) then
		for _, setting in pairs(options.Tweaks) do
			setting.value = GetOption(setting.category, setting.item)
			setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
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
	var.settings.enableConsole, toggled = ImGui.Checkbox("Console", var.settings.enableConsole)
	ui.tooltip("Ultra+ will log what it's doing to the CET console")
	if toggled then
		SaveSettings()
	end

	ImGui.SameLine(163)
	var.settings.enableTargetFps, toggled = ImGui.Checkbox("Enable Target FPS", var.settings.enableTargetFps)
	ui.tooltip("Ultra+ will use basic perceptual auto-scaling of ray/path\tracing quality to target consistent FPS")
	if toggled then
		SaveSettings()
	end

	if var.settings.enableTargetFps then
		ImGui.SameLine(250)
		ui.align()
		ui.width(130)
		var.settings.targetFps, toggled = ImGui.InputInt("", var.settings.targetFps, 1)

		if toggled then
			SaveSettings()
		end
	end
end

local function renderRenderingFeaturesDrawer()
	ui.space()
	for _, setting in pairs(options.Features) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end
end

local function renderDebugDrawer()
	ui.line()
	for _, setting in pairs(options.RTXDI) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.RTXGI) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.REGIR) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.RELAX) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.NRD) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.RTOPTIONS) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.SHARC) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.RTINT) do
		setting.value = GetOption(setting.category, setting.item)
		ui.width(140)
		setting.value, toggled = ImGui.InputInt(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end

	ui.line()
	for _, setting in pairs(options.RTFLOAT) do
		setting.value = GetOption(setting.category, setting.item)
		ui.width(180)
		setting.value, toggled = ImGui.InputFloat(setting.name, tonumber(setting.value))
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value, "float")
			SaveSettings()
		end
	end
end

local function renderTabs()
	if ImGui.BeginTabBar("Tabs") then
		if ImGui.BeginTabItem("Ultra+ Config") then
			renderTabEngineDrawer()
			ImGui.EndTabItem()
		end

		if ImGui.BeginTabItem("Rendering Features") then
			renderRenderingFeaturesDrawer()
			ImGui.EndTabItem()
		end

		if ImGui.BeginTabItem("Debug") and config.DEBUG then
			config.isDebugTabActive = true
			renderDebugDrawer()
			ImGui.EndTabItem()
		else
			config.isDebugTabActive = false
		end

		ImGui.EndTabBar()

		if stats.fps == 0 then
			return
		end

		local padding = config.windowWidth - config.fpsWidth
		config.fpsWidth = ImGui.CalcTextSize("0000000000000")
		ImGui.SameLine(padding)
		ImGui.Text("Real FPS: "..tostring(math.floor(stats.fps)))
	end
end

ui.renderUI = function(fps)
	stats.fps = fps

	ImGui.SetNextWindowPos(10, 300, ImGuiCond.FirstUseEver)

	config.windowWidth = ImGui.GetWindowWidth() * 1.37
	config.windowHeight = config.windowWidth * 1.09

	if config.isDebugTabActive then
		ImGui.SetNextWindowSize(config.windowWidth, config.windowHeightDebug)
	else
	   	ImGui.SetNextWindowSize(config.windowWidth, config.windowHeight)
	end

	-- begin actual render
	if ImGui.Begin("Ultra+ v"..UltraPlus.__VERSION, true) then
		ImGui.SetWindowFontScale(var.settings.uiScale)
		renderTabs()
		ImGui.End()
	end
end

return ui
