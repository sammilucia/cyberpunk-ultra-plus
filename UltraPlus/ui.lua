--ui.lua

local options = require("options")
local var = require("variables")
local config = {
    SetMode = require("setmode").SetMode,
    SetQuality = require("setquality").SetQuality,
    SetVram = require("setvram").SetVram,
    DEBUG = true,
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

    if ImGui.CollapsingHeader("Rendering Mode", ImGuiTreeNodeFlags.DefaultOpen) then
        --[[
        if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", var.settings.mode == var.mode.RASTER ) then
            var.settings.mode = var.mode.RASTER
            config.SetMode( var.settings.mode )
        end
]]
        if ImGui.RadioButton("RT Only", var.settings.mode == var.mode.RT_ONLY) then
            var.settings.mode = var.mode.RT_ONLY
            config.SetMode(var.settings.mode)
            LoadIni("config_rt.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
        ui.tooltip("Regular ray tracing, with optimisations and fixes.")

        ui.align()
        if ImGui.RadioButton("RT+PT", var.settings.mode == var.mode.RT_PT) then
            var.settings.mode = var.mode.RT_PT
            config.SetMode(var.settings.mode)
            LoadIni("config_rtpt.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
        ui.tooltip("Normal raytracing plus path traced bounce lighting. Leave Path Tracing\ndisabled in graphics options for this to work correctly.")

        ui.align()
        if ImGui.RadioButton("PT20", var.settings.mode == var.mode.PT20) then
            var.settings.mode = var.mode.PT20
            config.SetMode(var.settings.mode)
            LoadIni("config_pt.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
        ui.tooltip("Path tracing from Cyberpunk 2.0.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality.")

        ui.align()
        if ImGui.RadioButton("PT21", var.settings.mode == var.mode.PT21) then
            var.settings.mode = var.mode.PT21
            config.SetMode(var.settings.mode)
            LoadIni("config_pt.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
        ui.tooltip("Path tracing from Cyberpunk 2.10+.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality.")

        ui.align()
        if ImGui.RadioButton("PTNext", var.settings.mode == var.mode.PTNEXT) then
            var.settings.mode = var.mode.PTNEXT
            config.SetMode(var.settings.mode)
            LoadIni("config_pt.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
        ui.tooltip("For this mode to work, you MUST load a save game, or start CyberPunk with\nPTNext enabled. Changing graphics?DLSS will also require a reload.\n\nNOTE: For other PT modes we recommend increasing DLSS/FSR3 and lowering PT\nquality for the best visuals. However for PTNext we recommend the opposite:\nRun PTNext as high as you can and turn upscaling down a step.")
    end

    ui.space()
    if ImGui.CollapsingHeader("Indirect Lighting Quality", ImGuiTreeNodeFlags.DefaultOpen) then
        if ImGui.RadioButton("Vanilla##QualityVanilla", var.settings.quality == var.quality.VANILLA) then
            var.settings.quality = var.quality.VANILLA
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Low", var.settings.quality == var.quality.LOW) then
            var.settings.quality = var.quality.LOW
            LoadIni("config_low.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Medium", var.settings.quality == var.quality.MEDIUM) then
            var.settings.quality = var.quality.MEDIUM
            LoadIni("config_medium.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("High", var.settings.quality == var.quality.HIGH) then
            var.settings.quality = var.quality.HIGH
            LoadIni("config_high.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Insane", var.settings.quality == var.quality.INSANE) then
            var.settings.quality = var.quality.INSANE
            LoadIni("config_insane.ini")
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
    end

    ui.space()
    if ImGui.CollapsingHeader("VRAM Configuration (GB)", ImGuiTreeNodeFlags.DefaultOpen) then
        if ImGui.RadioButton("4", var.settings.vram == var.vram.GB4) then
            var.settings.vram = var.vram.GB4
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("6", var.settings.vram == var.vram.GB6) then
            var.settings.vram = var.vram.GB6
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("8", var.settings.vram == var.vram.GB8) then
            var.settings.vram = var.vram.GB8
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("10", var.settings.vram == var.vram.GB10) then
            var.settings.vram = var.vram.GB10
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("12", var.settings.vram == var.vram.GB12) then
            var.settings.vram = var.vram.GB12
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("16", var.settings.vram == var.vram.GB16) then
            var.settings.vram = var.vram.GB16
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("20", var.settings.vram == var.vram.GB20) then
            var.settings.vram = var.vram.GB20
            config.SetVram(var.settings.vram)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("24", var.settings.vram == var.vram.GB24) then
            var.settings.vram = var.vram.GB24
            config.SetVram(var.settings.vram)
            SaveSettings()
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
                setting.value = setting.value
                SaveSettings()
            end
        end
    end
	
	ui.line()
    ui.text("NOTE: Once happy, reload a save to fully activate the mode")
end

local function renderRenderingFeaturesDrawer()
    ui.space()
    for _, setting in pairs(options.Features) do
        setting.value = GetOption(setting.category, setting.item)
        setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
        ui.tooltip(setting.tooltip)

        if toggled then
            SetOption(setting.category, setting.item, setting.value)
            setting.value = setting.value
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
            setting.value = setting.value
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
            setting.value = setting.value
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
            setting.value = setting.value
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
            setting.value = setting.value
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
            setting.value = setting.value
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
            setting.value = setting.value
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
            setting.value = setting.value
            SaveSettings()
        end
    end

    ui.line()
    for _, setting in pairs(options.RTINT) do
        setting.value = GetOption(setting.category, setting.item)
		ui.width(120)
        setting.value, toggled = ImGui.InputInt(setting.name, setting.value)
        ui.tooltip(setting.tooltip)

        if toggled then
            SetOption(setting.category, setting.item, setting.value)
            setting.value = setting.value
            SaveSettings()
        end
    end

    ui.line()
    for _, setting in pairs(options.RTFLOAT) do
        setting.value = GetOption(setting.category, setting.item)
		ui.width(100)
        setting.value, toggled = ImGui.InputFloat(setting.name, tonumber(setting.value))
        ui.tooltip(setting.tooltip)

        if toggled then
            SetOption(setting.category, setting.item, setting.value, "float")
            setting.value = setting.value
            SaveSettings()
        end
    end
end

local function renderTabs()
    if ImGui.BeginTabBar("Tabs") then
        if ImGui.BeginTabItem("Engine Config") then
            renderTabEngineDrawer()
            ImGui.EndTabItem()
        end

        if ImGui.BeginTabItem("Rendering Features") then
            renderRenderingFeaturesDrawer()
            ImGui.EndTabItem()
        end

        if ImGui.BeginTabItem("Debug") and config.DEBUG then
            renderDebugDrawer()
            ImGui.EndTabItem()
        end

        ImGui.EndTabBar()
    end
end

ui.renderControlPanel = function()
    -- SET DEFAULTS
    ImGui.SetNextWindowPos(200, 200, ImGuiCond.FirstUseEver)
    ImGui.SetNextWindowSize(440, 540, ImGuiCond.Appearing)

    -- BEGIN ACTUAL RENDER
    if ImGui.Begin("Ultra+ v" .. UltraPlus.__VERSION, true) then
        ImGui.SetWindowFontScale(0.90)
        renderTabs()
        ImGui.End()
    end
end

return ui
