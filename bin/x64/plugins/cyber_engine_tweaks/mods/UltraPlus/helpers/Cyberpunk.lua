-- helpers/Cyberpunk.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local config = require('helpers/config')

local function toboolean(value)
	if value == 'true' or value == true then
		return true
	elseif value == 'false' or value == false then
		return false
	else
		return nil
	end
end

Cyberpunk = {
	SplitOption = function(string)
		-- splits an ini/CVar command into its constituents
		local category, item = string.match(string, '(.-)/([^/]+)$')
		return category, item
	end,

	Get = function(category, item)
		local value = GameOptions.Get(category, item)

		if tostring(value) == 'true' then
			return true
		end

		if tostring(value) == 'false' then
			return false
		end

		if tostring(value):match('^%-?%d+%.%d+$') then -- float
			return tonumber(value)
		end

		if tostring(value):match('^%-?%d+$') then -- integer
			return tonumber(value)
		end

		logger.info('ERROR: Error getting value for:', category .. '/' .. item, '=', value)
	end,

	GetValue = function(category, item)
		return Game.GetSettingsSystem():GetVar(category, item):GetValue()
	end,

	NeedsConfirmation = function()
		return Game.GetSettingsSystem():NeedsConfirmation()
	end,

	NeedsReload = function()
		return Game.GetSettingsSystem():NeedsLoadLastCheckpoint()
	end,

	Confirm = function()
		Game.GetSettingsSystem():ConfirmChanges()
	end,

	Save = function()
		GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():RequestSaveUserSettings()
	end,

	SetValue = function(category, item, bool)
		Game.GetSettingsSystem():GetVar(category, item):SetValue(toboolean(bool))
	end,

	GetIndex = function(category, item, index)
		return Game.GetSettingsSystem():GetVar(category, item):GetIndex()
	end,

	SetIndex = function(category, item, index)
		Game.GetSettingsSystem():GetVar(category, item):SetIndex(index)
	end,

	SetBool = function(category, item, bool)
		GameOptions.SetBool(category, item, toboolean(bool))
	end,

	SetInt = function(category, item, integer)
		GameOptions.SetInt(category, item, tonumber(integer))
	end,

	SetFloat = function(category, item, float)
		GameOptions.SetFloat(category, item, tonumber(float))
	end,

	GetOption = function(category, item)
		-- gets a live game setting, working out which method to use for different settings
		if category == 'internal' then
			if var.settings[item] == true then
				return true
			end

			return false
		end

		if string.sub(category, 1, 1) == '/' then -- graphics options
			return Cyberpunk.GetValue(category, item) -- will not work for indices
		end

		return Cyberpunk.Get(category, item)
	end,

	SetOption = function(category, item, value, valueType)
		-- sets a live game setting, working out which method to use for different settings
		if value == nil then
			logger.info('ERROR: Skipping nil value:', category .. '/' .. item, '=', value)
			return
		end

		if category == 'internal' then
			var.settings[item] = value
			return
		end

		if string.sub(category, 1, 1) == '/' and (tostring(value) == 'true' or tostring(value) == 'false') then
			if Cyberpunk.GetOption(category, item) ~= value then
				Cyberpunk.SetValue(category, item, value)
				var.gameMenuChanged = true
				logger.debug('ConfirmChanges() required')
			end
			return
		end

		if string.sub(category, 1, 1) == '/' and tostring(value):match('^%-?%d+$') then
			if Cyberpunk.GetIndex(category, item) ~= value then
				Cyberpunk.SetIndex(category, item, tonumber(value))
				var.gameMenuChanged = true
				logger.debug('ConfirmChanges() required')
			end
			return
		end

		if type(value) == 'boolean' or tostring(value) == 'false' or tostring(value) == 'true' then
			if Cyberpunk.GetOption(category, item) ~= value then
				Cyberpunk.SetBool(category, item, value)
			end
			return
		end

		if tostring(value):match('^%-?%d+%.%d+$') or valueType == 'float' then -- floats
			Cyberpunk.SetFloat(category, item, value)
			return
		end

		if tostring(value):match('^%-?%d+$') then -- integers
			Cyberpunk.SetInt(category, item, value)
			return
		end

		logger.info('ERROR: Couldn\'t set value for:', category .. '/' .. item, '=', value)
	end,

	GetPlayer = function()
		return Game.GetPlayer()
	end,

	IsPreGame = function()
		return GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():IsPreGame()
	end,

	GetHour = function()
		return Game.GetTimeSystem():GetGameTime():Hours()
	end,

	SetWeather = function(label)
		return Game.GetWeatherSystem():RequestNewWeather(label)
	end,

	GetWeather = function()
		return Game.GetWeatherSystem():GetWeatherState().name
	end,

	IsRaining = function()
		return Game.GetWeatherSystem():GetRainIntensity() > 0 and true or false
	end,
}

return Cyberpunk
