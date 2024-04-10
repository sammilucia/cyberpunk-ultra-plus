UltraPlus = {
    __VERSION     = '4.0-alpha14',
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
    --    turboHack = false,
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
    -- non-blocking wait()
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
end

function SetOption(category, item, value)
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

    if type(value) == "boolean" then
        GameOptions.SetBool(category, item, value)
        return
    end

    if tostring(value):match("^%-?%d+%.%d+$") then
        GameOptions.SetFloat(category, item, tonumber(value))
        return
    end

    if tostring(value):match("^%-?%d+$") then
        GameOptions.SetInt(category, item, tonumber(value))
        return
    end

    Debug("Unsupported GameOption:", category .. "/" .. item, "=", value)
end

local function doGuess(againstTable, currentOpts, guessName)
    for requiredOpts, mode in pairs(againstTable) do
        if currentOpts == requiredOpts then
            logger.info("Guessed", guessName, "mode is", mode)
            return mode
        end
    end
end

function GuessMode()
    local opts = {
        rayTracing = GetOption("/graphics/raytracing", "RayTracing"),
        pathTracing = GetOption("/graphics/raytracing", "RayTracedPathTracing"),
        reGIR = GetOption("Editor/ReGIR", "Enable"),
        reSTIR = GetOption("Editor/ReSTIRGI", "Enable"),
        NRD = GetOption("Raytracing", "EnableNRD"),
        proxyLightRejection = GetOption("Editor/RTXDI", "EnableEmissiveProxyLightRejection"),
    }

    local renderingModes = {
        -- [{rayTracing = bool, pathTracing = bool, reGIR = boolean, reSTIR = boolean, NRD = boolean, proxyLightRejection = boolean}] = mode
        [{ -- VANILLA
            rayTracing = true,
            pathTracing = true,
            reGIR = opts.reGIR,
            reSTIR = true,
            NRD = opts.NRD,
            proxyLightRejection = false,
        }] = var.mode.VANILLA,

        [{ -- RASTER
            rayTracing = false,
            pathTracing = false,
            reGIR = opts.reGIR,
            reSTIR = opts.reSTIR,
            NRD = opts.NRD,
            proxyLightRejection = opts.proxyLightRejection,
        }] = var.mode.RASTER,

        [{ -- RT_ONLY
            rayTracing = false,
            pathTracing = false,
            reGIR = opts.reGIR,
            reSTIR = opts.reSTIR,
            NRD = false,
            proxyLightRejection = opts.proxyLightRejection,
        }] = var.mode.RT_ONLY,

        [{ -- RT_PT
            rayTracing = true,
            pathTracing = false,
            reGIR = opts.reGIR,
            reSTIR = opts.reSTIR,
            NRD = true,
            proxyLightRejection = opts.proxyLightRejection,
        }] = var.mode.RT_PT,

        [{ -- PT20
            rayTracing = true,
            pathTracing = true,
            reGIR = opts.reGIR,
            reSTIR = false,
            NRD = opts.NRD,
            proxyLightRejection = true,
        }] = var.mode.PT20,

        [{ -- PT21
            rayTracing = true,
            pathTracing = true,
            reGIR = opts.reGIR,
            reSTIR = true,
            NRD = opts.NRD,
            proxyLightRejection = true,
        }] = var.mode.PT21,
    }

    local guess = doGuess(renderingModes, opts, "rendering")
    if guess then
        return guess
    end

    logger.info("Could not guess rendering mode")
end

function GuessQuality()
    local opts = {
        reGIR = GetOption("Editor/ReGIR", "Enable"),
        shades = GetOption("Editor/ReGIR", "ShadingCandidatesCount"),
        rays = GetOption("RayTracing/Reference", "RayNumber"),
        bounces = GetOption("RayTracing/Reference", "BounceNumber"),
    }

    local qualityModes = {
        -- [{reGIR = boolean, shades = integer, rays = integer, bounces = integer}] = mode
        [{ -- VANILLA
            reGIR = false,
            shades = opts.shades,
            rays = 2,
            bounces = 2,
        }] = var.quality.VANILLA,

        [{ -- LOW
            reGIR = false,
            shades = opts.shades,
            rays = 1,
            bounces = 1,
        }] = var.quality.LOW,

        [{ -- reGIR LOW
            reGIR = true,
            shades = 8,
            rays = opts.rays,
            bounces = opts.bounces,

        }] = var.quality.LOW,

        [{ -- MEDIUM
            reGIR = false,
            shades = opts.shades,
            rays = opts.rays,
            bounces = 2,

        }] = var.quality.MEDIUM,

        [{ -- reGIR MEDIUM
            reGIR = true,
            shades = 10,
            rays = opts.rays,
            bounces = opts.bounces,
        }] = var.quality.MEDIUM,

        [{ -- HIGH
            reGIR = false,
            shades = opts.shades,
            rays = 3,
            bounces = 2,
        }] = var.quality.HIGH,

        [{ -- reGIR HIGH
            reGIR = true,
            shades = 14,
            rays = opts.rays,
            bounces = opts.bounces,
        }] = var.quality.HIGH,

        [{ -- INSANE
            reGIR = false,
            shades = opts.shades,
            rays = opts.rays,
            bounces = 3,
        }] = var.quality.INSANE,

        [{ -- reGIR INSANE
            reGIR = true,
            shades = 18,
            rays = opts.rays,
            bounces = opts.bounces,
        }] = var.quality.INSANE,
    }

    local guess = doGuess(qualityModes, opts, "quality")
    if guess then
        return guess
    end

    logger.info("Could not guess quality mode")
end

function GuessSamples()
    local opts = {
        reGIR = GetOption("Editor/ReGIR", "Enable"),
        samples = GetOption("Editor/RTXDI", "NumInitialSamples"),
    }

    local samplingModes = {
        -- [{ reGIR = boolean, samples = integer}] = mode
        [{ -- VANILLA
            reGIR = false,
            samples = 8,
        }] = var.samples.VANILLA,

        [{ -- LOW
            reGIR = false,
            samples = 16,
        }] = var.samples.LOW,

        [{ -- reGIR LOW
            reGIR = true,
            samples = 6,
        }] = var.samples.LOW,

        [{ -- MEDIUM
            reGIR = false,
            samples = 18,
        }] = var.samples.MEDIUM,

        [{ -- reGIR MEDIUM
            reGIR = true,
            samples = 8,
        }] = var.samples.MEDIUM,

        [{ -- HIGH
            reGIR = false,
            samples = 20,
        }] = var.samples.HIGH,

        [{ -- reGIR HIGH
            reGIR = true,
            samples = 10,
        }] = var.samples.HIGH,

        [{ -- INSANE
            reGIR = false,
            samples = 24,
        }] = var.samples.INSANE,

        [{ -- reGIR INSANE
            reGIR = true,
            samples = 12,
        }] = var.samples.INSANE,
    }

    local guess = doGuess(samplingModes, opts, "sampling")
    if guess then
        return guess
    end

    logger.info("Could not guess sampling mode")
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
    Wait(0.5, function()
        SetOption("Editor/ReGIR", "UseForDI", true)
        SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
    end)
end

--[[
local function DoTurboHack()
    -- reduce detail outdoors
    if not var.settings.turboHack or var.settings.indoors then
        config.SetSamples(var.settings.samples)
        config.SetQuality(var.settings.quality)
    else
        logger.info("PT Turbo - reducing detail oudoors")

        if var.settings.samples == var.samples.VANILLA then
            SetOption("Editor/RTXDI", "SpatialNumSamples", "0")

        elseif var.settings.samples == var.samples.LOW then
            if var.settings.mode == var.mode.PT20 then
                SetOption("Editor/SHARC", "DownscaleFactor", "7")
                SetOption("Editor/SHARC", "SceneScale", "35.7142857143")
            elseif var.settings.mode == var.mode.RT_PT then
                SetOption("Editor/SHARC", "DownscaleFactor", "7")
                SetOption("Editor/SHARC", "SceneScale", "35.7142857143")
            elseif var.settings.mode == var.mode.PT21 then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "0")
            end

        elseif var.settings.samples == var.samples.MEDIUM then
            if var.settings.mode == var.mode.PT20 then

            elseif var.settings.mode == var.mode.RT_PT then

            elseif var.settings.mode == var.mode.PT21 then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            end

        elseif var.settings.samples == var.samples.HIGH then
            if var.settings.mode == var.mode.PT20 then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            elseif var.settings.mode == var.mode.RT_PT then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "0")
            elseif var.settings.mode == var.mode.PT21 then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            end

        elseif var.settings.samples == var.samples.INSANE then
            if var.settings.mode == var.mode.PT20 then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "3")
            elseif var.settings.mode == var.mode.RT_PT then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "1")
            elseif var.settings.mode == var.mode.PT21 then
                SetOption("Editor/RTXDI", "SpatialNumSamples", "3")
            end
        end

        if var.quality.mode == var.quality.MEDIUM then
            SetOption("RayTracing/Reference", "BounceNumber", "1")
        elseif var.quality.mode == var.quality.HIGH then
            SetOption("RayTracing/Reference", "RayNumber", "2")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", true)
        elseif var.quality.mode == var.quality.INSANE then
            SetOption("RayTracing/Reference", "RayNumber", "3")
            SetOption("RayTracing/Reference", "EnableProbabilisticSampling", false)
        end
    end
end
]]

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
    --[[
    if config.turboHack ~= var.settings.turboHack then
        DoTurboHack()
        config.turboHack = var.settings.turboHack
    end
]]
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

registerForEvent('onUpdate', function(delta)
    -- handle non-blocking background tasks
    Detector.UpdateGameStatus()

    if not timer.paused then
        timer.fast = timer.fast + delta
        timer.lazy = timer.lazy + delta
    end

    if Detector.isGameActive then
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
        timer = activeTimers[i]
        timer.countdown = timer.countdown - delta

        if timer.countdown < 0 then
            timer.callback()
            table.remove(activeTimers, i)
        end
    end
end)

registerForEvent("onTweak", function()
    LoadIni("commonfixes.ini")
    --[[
    var.settings.mode = GuessMode()
    config.SetMode(var.settings.mode)

    var.settings.samples = GuessSamples()
    config.SetSamples(var.settings.samples)

    var.settings.quality = GuessQuality()
    config.SetQuality(var.settings.quality)
]]
    --  SetOption("Editor/RTXDI", "EnableSeparateDenoising", false) -- already applied by commonfixes
    --  config.reGIRDIHackApplied = false -- already set at start

    LoadSettings()
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
            SetOption("Editor/RTXDI", "EnableSeparateDenoising", true)
            config.reGIRDIHackApplied = false
        end
    end)

    local file = io.open("debug", "r")
    if file then
        config.DEBUG = true
        Debug("Enabling debug output")
    end

    SetOption("Editor/RTXDI", "EnableSeparateDenoising", false)
    config.SetMode(var.settings.mode)
    config.SetStreaming(var.settings.streaming)
    config.SetSamples(var.settings.samples)
    config.SetQuality(var.settings.quality)
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
