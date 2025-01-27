-- helpers/Cyberpunk.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')

local function toboolean(value)
	if value == 'true' or value == true then
		return true
	elseif value == 'false' or value == false then
		return false
	else
		return nil
	end
end

local Cyberpunk = {
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

		Logger.info('ERROR: Error getting value for:', category .. '/' .. item, '=', value)
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
		-- can only be run with CET overlay closed or CTD
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
			if Var.settings[item] == true then
				return true
			end

			return false
		end

		if string.sub(category, 1, 1) == '/' then -- graphics options
			local value = Cyberpunk.GetValue(category, item)

			if tostring(value) == 'true' or tostring(value) == 'false' then
				return value
			else
				return Cyberpunk.GetIndex(category, item)
			end
		end

		return Cyberpunk.Get(category, item)
	end,

	SetOption = function(category, item, value, valueType)
		-- sets a live game setting, working out which method to use for different settings
		if value == nil then
			Logger.info('ERROR: Skipping nil value:', category .. '/' .. item, '=', value)
			return
		end

		if category == 'internal' then
			Var.settings[item] = value
			return
		end

		if string.sub(category, 1, 1) == '/' then -- graphics options
			if tostring(value) == 'true' or tostring(value) == 'false' then
				if Cyberpunk.GetOption(category, item) ~= value then
					Logger.info(string.format('    (Was: %s)', type(Cyberpunk.GetOption(category, item))))
					Logger.info('Set value for:', category .. '/' .. item, '=', value)
					Cyberpunk.SetValue(category, item, value)
				end
				return
			elseif tostring(value):match('^%-?%d+$') then -- integer (index) values
				if Cyberpunk.GetIndex(category, item) ~= tonumber(value) then
					Logger.info(string.format('    (Was: %s)', type(Cyberpunk.GetOption(category, item))))
					Logger.info('Set index for:', category .. '/' .. item, '=', value)
					Cyberpunk.SetIndex(category, item, tonumber(value))
				end
				return
			end
		end

		if tostring(value) == 'false' or tostring(value) == 'true' then -- test without type test
			if Cyberpunk.GetOption(category, item) ~= toboolean(value) then
				Logger.info(string.format('    (Was: %s %s)', type(Cyberpunk.GetOption(category, item)), Cyberpunk.GetOption(category, item)))
				Logger.info('Set bool for:', category .. '/' .. item, '=', value)
				Cyberpunk.SetBool(category, item, value)
			end
			return
		end

		if tostring(value):match('^%-?%d+%.%d+$') or valueType == 'float' then -- floats
			if Cyberpunk.GetOption(category, item) ~= tonumber(value) then
				Logger.info(string.format('    (Was: %s %s)', type(Cyberpunk.GetOption(category, item)), Cyberpunk.GetOption(category, item)))
				Logger.info('Set float for:', category .. '/' .. item, '=', value)
				Cyberpunk.SetFloat(category, item, value)
			end
			return
		end

		if tostring(value):match('^%-?%d+$') then -- integers
			if Cyberpunk.GetOption(category, item) ~= tonumber(value) then
				Logger.info(string.format('    (Was: %s %s)', type(Cyberpunk.GetOption(category, item)), Cyberpunk.GetOption(category, item)))
				Logger.info('Set int for:', category .. '/' .. item, '=', value)
				Cyberpunk.SetInt(category, item, tonumber(value))
			end
			return
		end

		Logger.info('ERROR: Couldn\'t set value for:', category .. '/' .. item, '=', value)
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

	GetPlayTime = function()
		return Game.GetPlaythroughTime():ToFloat()
	end,
}

return Cyberpunk
