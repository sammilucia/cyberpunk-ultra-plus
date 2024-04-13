UltraPlus = {
    __VERSION     = '4.0-beta07',
    __DESCRIPTION = 'Better Path Tracing, Ray Tracing and Hotfixes for CyberPunk',
    __URL         = 'https://github.com/sammilucia/cyberpunk-ultra-plus',
    __LICENSE     = [[
    MIT No Attribution

    Copyright 2024 SammiLucia, Xerme, FireKahuna, WoaDmulL

    Permission is hereby granted, free of charge, to any person obtaining a copy of this
    software and associated documentation files (the "Software"), to deal in the Software
    without restriction, including without limitation the rights to use, copy, modify,
    merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
    INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
    PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}
local logger = require("logger")
local options = require("options")
local var = require("variables")
local ui = require("ui")
local isLoaded = false
local config = {
    SetSamples = require("setsamples").SetSamples,
    SetMode = require("setmode").SetMode,
    SetQuality = require("setquality").SetQuality,
    SetStreaming = require("setstreaming").SetStreaming,
    SetVram = require("setvram").SetVram,
    DEBUG = false,
    reGIRDIHackApplied = false,
}
local timer = {
    lazy = 0,
    fast = 0,
    paused = false,
    LAZY = 20.0,
    FAST = 1.0,
}

local Detector = { isGameActive = false }
function Detector.UpdateGameStatus()
    -- check if ingame or not
    local player = Game.GetPlayer()
    local isInMenu = GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():IsPreGame()

    Detector.isGameActive = player and not isInMenu
    Debug("Player is", Detector.isGameActive and "" or "not", "in game")
end

function Debug(...)
    if not config.DEBUG then return end
    print("DEBUG:", table.concat(arg, " "))
end

local activeTimers = {}
function Wait(seconds, callback)
    -- non-blocking wait
    table.insert(activeTimers, { countdown = seconds, callback = callback })
end

function PushChanges()
    -- confirm menu changes and save UserSettings.json to try to prevent it getting out of sync
    -- currently crashes CP 2.0+ and idk why
    GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():RequestSaveUserSettings()
    Game.GetSettingsSystem():ConfirmChanges()
end

function SplitOption(string)
    -- splits an ini/CVar command into its constituents
    local category, item = string.match(string, "(.-)/([^/]+)$")

    return category, item
end

function GetOption(category, item)
    -- gets a live game setting
    if category == "internal" then
        if var.settings[item] == nil then
            return false
        end

        return nil
    end

    if string.sub(category, 1, 1) == "/" then
        return Game.GetSettingsSystem():GetVar(category, item):GetValue()
    end

    local value = GameOptions.Get(category, item)
    if value == "true" then
        return true
    end

    if value == "false" then
        return false
    end

    if string.match(value, "^%-?%d+$") then
        return tonumber(value)
    end	
	
	return value
end

function SetOption(category, item, value, valueType)
    -- sets a live game setting, working out which method to use for different setting types
    if value == nil then
        Debug("Skipping nil value:", category .. "/" .. item)
        return
    end

    if category == "internal" then
        var.settings[item] = value
        return
    end

    if string.sub(category, 1, 1) == "/" then
        Game.GetSettingsSystem():GetVar(category, item):SetValue(value)
        return
    end

    if value == "false" or value == false then
        GameOptions.SetBool(category, item, false)
        return
    end

    if value == "true" or value == true then
        GameOptions.SetBool(category, item, true)
    end

    if tostring(value):match("^%-?%d+%.%d+$") or valueType == "float" then
        GameOptions.SetFloat(category, item, tonumber(value))
        return
    end

    if tostring(value):match("^%-?%d+$") then
        GameOptions.SetInt(category, item, tonumber(value))
        return
    end

    Debug("Unsupported GameOption:", category .. "/" .. item, "=", value)
end

function LoadIni(path)
    -- pushes an ini file into live game settings
    local iniData = {}
    local category

    local file = io.open(path, "r")
    if not file then
        logger.info("Failed to open file:", path)
        return
    end

    logger.info("Loading common fixes...")
    for line in file:lines() do
        line = line:match("^%s*(.-)%s*$") -- trim whitespace

        if line == "" or string.sub(line, 1, 1) == ";" then
            goto continue
        end

        local currentCategory = line:match("%[(.+)%]") -- match category lines
        if currentCategory then
            category = currentCategory
            iniData[category] = iniData[category] or {}
            goto continue
        end

        local item, value = line:match("([^=]+)%s*=%s*([^;]+)") -- match items and values, ignore comments
        if item and value then
            item = item:match("^%s*(.-)%s*$")
            value = value:match("^%s*(.-)%s*$")
            iniData[category][item] = value
            local success, err = pcall(SetOption, category, item, value)
            if not success then
                logger.info("SetOption failed:", err)
            end
        end

        ::continue::
    end
    file:close()
end

function LoadSettings()
    -- get game's live settings, then replace with config.json settings (if they exist and are valid)
    local settingsTable = {}
    local settingsCategories = {
        options.Tweaks,
        options.Features,
    }

    for _, category in pairs(settingsCategories) do
        for _, setting in ipairs(category) do
            local currentValue = GetOption(setting.category, setting.item)
            settingsTable[setting.item] = { category = setting.category, value = currentValue }
        end
    end

    local file = io.open("config.json", "r")
    if not file then
        return
    end

    local rawJson = file:read("*a")
    file:close()

    local success, result = pcall(json.decode, rawJson)

    if not success or not result.UltraPlus then
        logger.info("Could not read config.json:", result)
        return
    end

    for item, value in pairs(result.UltraPlus) do
        if settingsTable[item] and not string.match(item, "^internal") then
            settingsTable[item].value = value
        elseif string.match(item, "^internal") then
            local key = string.match(item, "^internal%.(%w+)$")
            if key then
                logger.info("Assigning internal setting:", key, "=", value)
                var.settings[key] = value
            end
        end
    end

    logger.info("Loading user settings...")
    for item, setting in pairs(settingsTable) do
        SetOption(setting.category, item, setting.value)
    end
end

function SaveSettings()
    -- save Ultra+ settings to config.json
    local UltraPlus = {}
    local settingsCategories = {
        options.Tweaks,
        options.Features,
    }

    for _, currentCategory in pairs(settingsCategories) do
        for _, currentSetting in pairs(currentCategory) do
            UltraPlus[currentSetting.item] = currentSetting.value
        end
    end

    UltraPlus["internal.mode"] = var.settings.mode
    UltraPlus["internal.samples"] = var.settings.samples
    UltraPlus["internal.quality"] = var.settings.quality
    UltraPlus["internal.streaming"] = var.settings.streaming
    UltraPlus["internal.vram"] = var.settings.vram

    local settingsTable = { UltraPlus = UltraPlus }

    local success, result = pcall(json.encode, settingsTable)
    if not success then
        logger.info("Error saving config.json:", result)
        return
    end

    local rawJson = result
    local file = io.open("config.json", "w")
    if not file then
        logger.info("Error opening config.json for writing")
        return
    end
    file:write(rawJson)
    file:close()
end

local function ForceDlssd()
    local testDlssd = GetOption('/graphics/presets', 'DLSS_D')

    while testDlssd == false do
        Debug("/graphics/presets/DLSS_D =", testDlssd)

        SetOption("/graphics/presets", "DLSS_D", true)

        Wait(1.0, function()
            testDlssd = GetOption('/graphics/presets', 'DLSS_D')
        end)
    end

    PushChanges()

    SetOption("RayTracing", "EnableNRD", false)
    SaveSettings()
end

function ResetEngine()
    logger.info("Reloading REDengine")
    GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():RequestSaveUserSettings()
end

local function DoReGIRDI()
    config.reGIRDIHackApplied = true
    SetOption("Editor/ReGIR", "UseForDI", false)
    SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)
    Wait(1.5, function()
        SetOption("Editor/ReGIR", "UseForDI", true)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
    end)
end

local function DoRainFix()
    -- enable particle PT integration unless player is outdoors AND it's raining
    if var.settings.indoors or not var.settings.rain then
        logger.info("It's not raining... Enabling separate particle colour")
        SetOption("Rendering", "DLSSDSeparateParticleColor", true)
        return
    end

    logger.info("It's raining... Disabling separate particle colour")
    SetOption("Rendering", "DLSSDSeparateParticleColor", false)
end

local function DoRRFix()
    -- while RR is enabled, continually disable NRD to work around CP FPS slowdown bug entering vehicles or cutscenes
    timer.paused = true
    if not GetOption("/graphics/presets", "DLSS_D") then
        return
    end

    Debug("Disabling NRD")
    SetOption("RayTracing", "EnableNRD", false)
    timer.paused = false
end

local function DoFastUpdate()
    -- runs every timer.FAST seconds
    DoRRFix()

    local testRain = Game.GetWeatherSystem():GetRainIntensity() > 0 and true or false
    local testIndoors = IsEntityInInteriorArea(GetPlayer())

    if testRain ~= var.settings.rain or testIndoors ~= var.settings.indoors then
        DoRainFix()
        var.settings.rain = testRain
        var.settings.indoors = testIndoors
    end

    if GetOption("Editor/ReGIR", "Enable") and not config.reGIRDIHackApplied then
        DoReGIRDI()
    end
end

local function DoLazyUpdate()
    -- runs every timer.LAZY seconds
end

local function forcePTDenoiser()
    if GetOption("Developer/FeatureToggles", "DLSSD") then
        logger.info("Enabling RR, disabling NRD")
        SetOption("Developer/FeatureToggles", "DLSSD", true)
        SetOption("RayTracing", "EnableNRD", false)
        SetOption("/graphics/presets", "DLSS_D", true)
        --PushChanges()
    else
        logger.info("Enabling NRD, disabling RR")
        SetOption("/graphics/presets", "DLSS_D", false)
        SetOption("Developer/FeatureToggles", "DLSSD", false)
        SetOption("RayTracing", "EnableNRD", true)
        --PushChanges()
    end
end

function LoadDenoiser()
    if not GetOption("/graphics/presets", "DLSS_D") then
        logger.info("Loading RR denoiser")
        LoadIni("denoiser_nrd.ini")
        return
    end

    logger.info("Loading NRD denoiser")
    LoadIni("denoiser_rr.ini")
end

registerForEvent('onUpdate', function(delta)
    -- handle non-blocking background tasks
    Detector.UpdateGameStatus()

    if not timer.paused then
        timer.fast = timer.fast + delta
        timer.lazy = timer.lazy + delta

        -- prevent skipping temporal updates
        Game.GetPlayer():GetFPPCameraComponent():SceneDisableBlendingToStaticPosition()
    end

    if Detector.isGameActive and isLoaded then
        if timer.fast > timer.FAST then
            DoFastUpdate()
            timer.fast = 0
        end

        if timer.lazy > timer.LAZY then
            DoLazyUpdate()
            timer.lazy = 0
        end
    end

    for i = #activeTimers, 1, -1 do
        local tempTimer = activeTimers[i]
        tempTimer.countdown = tempTimer.countdown - delta

        if tempTimer.countdown < 0 then
            tempTimer.callback()
            table.remove(activeTimers, i)
        end
    end
end)

registerForEvent("onTweak", function()
    LoadIni("commonfixes.ini") -- load as early as possible to prevent crashes
    LoadDenoiser()
end)

registerForEvent("onInit", function()
    isLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not Game.GetSystemRequestsHandler():IsPreGame()

    Observe('QuestTrackerGameController', 'OnInitialize', function()
        if not isLoaded then
            Debug('Game session started')
            isLoaded = true
        end
    end)

    Observe('QuestTrackerGameController', 'OnUninitialize', function()
        if Game.GetPlayer() == nil then
            Debug('Game session ended')
            isLoaded = false
            SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)
            config.reGIRDIHackApplied = false
        end
    end)

    local file = io.open("debug", "r")
    if file then
        config.DEBUG = true
        Debug("Enabling debug output")
    end

	LoadIni("commonfixes.ini") -- load again to undo engine changing things
    LoadDenoiser()
    LoadSettings()
    config.SetMode(var.settings.mode)
    config.SetQuality(var.settings.quality)
    config.SetSamples(var.settings.samples)
    config.SetStreaming(var.settings.streaming)
    config.SetVram(var.settings.vram)

    SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)
    config.reGIRDIHackApplied = false
end)

registerForEvent("onOverlayOpen", function()
    WindowOpen = true
end)

registerForEvent("onOverlayClose", function()
    WindowOpen = false
end)

registerForEvent("onDraw", function()
    if not WindowOpen then
        return
    end

    ui.renderControlPanel()
end)
