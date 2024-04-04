-- setquality.lua

local var = require( "variables" )
local config = {}

function config.SetQuality( quality )

	print( "---------- Ultra+: Setting", quality, "quality to", quality )

	if quality == var.quality.VANILLA then
		SetOption( "RayTracing/Reference", "RayNumber", "1" )
		SetOption( "RayTracing/Reference", "BounceNumber", "1" )
		SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", true )
		SetOption( "RayTracing/Reference", "RayNumberScreenshot", "3" )
		SetOption( "RayTracing/Reference", "BounceNumberScreenshot", "2" )
		SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
		SetOption( "Editor/SHARC", "DownscaleFactor", "5" )
		SetOption( "Editor/SHARC", "SceneScale", "50.0" )
		SetOption( "Editor/SHARC", "Bounces", "4" )
		SetOption( "Editor/ReGIR", "ShadingCandidatesCount", "4" )
		SetOption( "Editor/ReGIR", "BuildCandidatesCount", "8" )
		SetOption( "Editor/ReGIR", "LightSlotsCount", "128" )

	elseif quality == var.quality.LOW then
		SetOption( "RayTracing/Reference", "RayNumber", "1" )
		SetOption( "RayTracing/Reference", "BounceNumber", "1" )
		SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", true )
		SetOption( "RayTracing/Reference", "RayNumberScreenshot", "3" )
		SetOption( "RayTracing/Reference", "BounceNumberScreenshot", "2" )
		SetOption( "Editor/ReGIR", "ShadingCandidatesCount", "2" )
		SetOption( "Editor/ReGIR", "BuildCandidatesCount", "8" )
		SetOption( "Editor/ReGIR", "LightSlotsCount", "128" )
		SetOption( "Editor/SHARC", "Bounces", "1" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "6" )
			SetOption( "Editor/SHARC", "SceneScale", "30.0" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "6" )
			SetOption( "Editor/SHARC", "SceneScale", "30.0" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "6" )
			SetOption( "Editor/SHARC", "SceneScale", "30.0" )
		end

	elseif quality == var.quality.MEDIUM then
		SetOption( "RayTracing/Reference", "RayNumber", "1" )
		SetOption( "RayTracing/Reference", "BounceNumber", "2" )
		SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", true )
		SetOption( "RayTracing/Reference", "RayNumberScreenshot", "3" )
		SetOption( "RayTracing/Reference", "BounceNumberScreenshot", "2" )
		SetOption( "Editor/ReGIR", "ShadingCandidatesCount", "4" )
		SetOption( "Editor/ReGIR", "BuildCandidatesCount", "8" )
		SetOption( "Editor/ReGIR", "LightSlotsCount", "128" )
		SetOption( "Editor/SHARC", "Bounces", "1" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "4" )
			SetOption( "Editor/SHARC", "SceneScale", "50.0" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "4" )
			SetOption( "Editor/SHARC", "SceneScale", "50.0" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "4" )
			SetOption( "Editor/SHARC", "SceneScale", "50.0" )
		end

	elseif quality == var.quality.HIGH then
		SetOption( "RayTracing/Reference", "RayNumber", "3" )
		SetOption( "RayTracing/Reference", "BounceNumber", "2" )
		SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", false )
		SetOption( "RayTracing/Reference", "RayNumberScreenshot", "3" )
		SetOption( "RayTracing/Reference", "BounceNumberScreenshot", "2" )
		SetOption( "Editor/ReGIR", "ShadingCandidatesCount", "5" )
		SetOption( "Editor/ReGIR", "BuildCandidatesCount", "12" )
		SetOption( "Editor/ReGIR", "LightSlotsCount", "192" )
		SetOption( "Editor/SHARC", "Bounces", "3" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "4" )
			SetOption( "Editor/SHARC", "SceneScale", "75.0" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "4" )
			SetOption( "Editor/SHARC", "SceneScale", "75.0" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "4" )
			SetOption( "Editor/SHARC", "SceneScale", "75.0" )
		end

	elseif quality == var.quality.INSANE then
		SetOption( "RayTracing/Reference", "RayNumber", "5" )
		SetOption( "RayTracing/Reference", "BounceNumber", "2" )
		SetOption( "RayTracing/Reference", "EnableProbabilisticSampling", false )
		SetOption( "RayTracing/Reference", "RayNumberScreenshot", "8" )
		SetOption( "RayTracing/Reference", "BounceNumberScreenshot", "3" )
		SetOption( "Editor/ReGIR", "ShadingCandidatesCount", "6" )
		SetOption( "Editor/ReGIR", "BuildCandidatesCount", "16" )
		SetOption( "Editor/ReGIR", "LightSlotsCount", "256" )
		SetOption( "Editor/SHARC", "Bounces", "4" )

		if var.settings.mode == var.mode.PT20 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "3" )
			SetOption( "Editor/SHARC", "SceneScale", "100.0" )
		elseif var.settings.mode == var.mode.RT_PT then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.16" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "3" )
			SetOption( "Editor/SHARC", "SceneScale", "100.0" )
		elseif var.settings.mode == var.mode.PT21 then
			SetOption( "Editor/SHARC", "UsePrevFrameBiasAllowance", "0.25" )
			SetOption( "Editor/SHARC", "DownscaleFactor", "3" )
			SetOption( "Editor/SHARC", "SceneScale", "100.0" )
		end
	end
end

return config
