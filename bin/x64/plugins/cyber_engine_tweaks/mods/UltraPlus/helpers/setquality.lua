-- setquality.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetQuality(quality)

	if quality == Var.quality.VANILLA then
		Cyberpunk.SetOption('/graphics/advanced', 'GlobaIlluminationRange', '0')

		Cyberpunk.SetOption('DLSS', 'SampleNumber', '16')
		Cyberpunk.SetOption('FSR2', 'SampleNumber', '16')
		Cyberpunk.SetOption('Editor/Selection/Appearance', 'CheckerboardSize','2')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/ReGIR', 'LightSlotsCount', '128')
		Cyberpunk.SetOption('Editor/ReGIR', 'ShadingCandidatesCount', '4')
		Cyberpunk.SetOption('Editor/ReGIR', 'BuildCandidatesCount', '8')
		Cyberpunk.SetOption('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', false)
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '2000.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceCharacter', '15.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceVehicle', '40.0')
		Cyberpunk.SetOption('RayTracing/LocalLight', 'BatchSize', '64')
		Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
		Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '2')
		Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '2')
		Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
		Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		Cyberpunk.SetOption('RayTracing/ReferenceScreenshot', 'SampleNumber', '5')
		Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '20')
		Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '8')
		Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '1')
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
		Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '5')
		Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '4')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '2')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '2')
		return
	end

	if quality == Var.quality.FAST then
		Cyberpunk.SetOption('/graphics/advanced', 'GlobaIlluminationRange', '0')

		Cyberpunk.SetOption('DLSS', 'SampleNumber', '32')
		Cyberpunk.SetOption('FSR2', 'SampleNumber', '32')
		Cyberpunk.SetOption('Editor/Selection/Appearance', 'CheckerboardSize','3')				-- TEST
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/ReGIR', 'LightSlotsCount', '512')
		Cyberpunk.SetOption('Editor/ReGIR', 'ShadingCandidatesCount', '4')
		Cyberpunk.SetOption('Editor/ReGIR', 'BuildCandidatesCount', '8')						-- above 8 causes flickering lights after menus
		Cyberpunk.SetOption('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', false)
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '800.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceCharacter', '15.0')					-- WAS 12.0
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceVehicle', '35.0')
		Cyberpunk.SetOption('RayTracing/LocalLight', 'BatchSize', '128')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '2000.0')
		Cyberpunk.SetOption('RayTracing/ReferenceScreenshot', 'SampleNumber', '8')
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '100.0')

		Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '7')
		Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0')

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '0')
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '7')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '2')	
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT16 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', true)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0')										-- performance hack, leave cache enabled with no bounces
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT20 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', true)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', true)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT21 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '1')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '4')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '2')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '2')
			return
		end
	end

	if quality == Var.quality.MEDIUM then
		Cyberpunk.SetOption('/graphics/advanced', 'GlobaIlluminationRange', '0')

		Cyberpunk.SetOption('DLSS', 'SampleNumber', '32')
		Cyberpunk.SetOption('FSR2', 'SampleNumber', '32')
		Cyberpunk.SetOption('Editor/Selection/Appearance', 'CheckerboardSize','2')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/ReGIR', 'LightSlotsCount', '512')
		Cyberpunk.SetOption('Editor/ReGIR', 'ShadingCandidatesCount', '4')
		Cyberpunk.SetOption('Editor/ReGIR', 'BuildCandidatesCount', '8')						-- above 8 causes flickering lights after menus
		Cyberpunk.SetOption('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', false)
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '1500.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceCharacter', '20.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceVehicle', '40.0')
		Cyberpunk.SetOption('RayTracing/LocalLight', 'BatchSize', '128')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '300.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '3000.0')
		Cyberpunk.SetOption('RayTracing/ReferenceScreenshot', 'SampleNumber', '12')
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')

		Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '5')
		Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '1')										-- WAS 1
		
		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '0')
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '6')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '4')	
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT16 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', true)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '2')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0')										-- performance hack, leave cache enabled with no bounces
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT20 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', true)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '2')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '1')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', true)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '2')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT21 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '1')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '1')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '3')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '2')
			return
		end
	end

	if quality == Var.quality.HIGH then
		Cyberpunk.SetOption('/graphics/advanced', 'GlobaIlluminationRange', '1')

		Cyberpunk.SetOption('DLSS', 'SampleNumber', '32')										-- WAS 48
		Cyberpunk.SetOption('FSR2', 'SampleNumber', '32')										-- WAS 48
		Cyberpunk.SetOption('Editor/Selection/Appearance', 'CheckerboardSize','2')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', '5')
		Cyberpunk.SetOption('Editor/ReGIR', 'LightSlotsCount', '512')
		Cyberpunk.SetOption('Editor/ReGIR', 'ShadingCandidatesCount', '8')
		Cyberpunk.SetOption('Editor/ReGIR', 'BuildCandidatesCount', '8')		-- above 8 causes flickering lights after menus
		Cyberpunk.SetOption('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', false)
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '2000.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceCharacter', '45.0')					-- WAS 15.0
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceVehicle', '50.0')						-- WAS 50.0
		Cyberpunk.SetOption('RayTracing/LocalLight', 'BatchSize', '128')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '500.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '3000.0')
		Cyberpunk.SetOption('RayTracing/ReferenceScreenshot', 'SampleNumber', '16')
		Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
		Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '2')
		Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '2')
		Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '3')
		Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '2')

		Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '5')
		Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '2')

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '0')
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '5')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '4')	
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT16 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0')										-- performance hack, leave cache enabled with no bounces
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT20 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '4')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT21 then
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '12')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '4')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '2')
			return
		end
	end

	if quality == Var.quality.INSANE then
		Cyberpunk.SetOption('/graphics/advanced', 'GlobaIlluminationRange', '1')

		Cyberpunk.SetOption('DLSS', 'SampleNumber', '32')
		Cyberpunk.SetOption('FSR2', 'SampleNumber', '32')
		Cyberpunk.SetOption('Editor/Selection/Appearance', 'CheckerboardSize','2')				-- 5.3.4
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', '6')
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', '6')
		Cyberpunk.SetOption('Editor/ReGIR', 'LightSlotsCount', '512')
		Cyberpunk.SetOption('Editor/ReGIR', 'ShadingCandidatesCount', '8')
		Cyberpunk.SetOption('Editor/ReGIR', 'BuildCandidatesCount', '8')		-- above 8 causes flickering lights after menus
		Cyberpunk.SetOption('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', false)
		Cyberpunk.SetOption('RayTracing', 'TracingRadiusReflections', '8000.0')
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceCharacter', '45.0')					-- WAS 20.0
		Cyberpunk.SetOption('RayTracing', 'CullingDistanceVehicle', '60.0')						-- WAS 60.0
		Cyberpunk.SetOption('RayTracing/LocalLight', 'BatchSize', '128')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '900.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityCullingRadius', '9000.0')
		Cyberpunk.SetOption('RayTracing/ReferenceScreenshot', 'SampleNumber', '16')
		Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '3')
		Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '2')
		Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '5')
		Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '3')

		Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '5')
		Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '3')

		if Var.settings.mode == Var.mode.PTNEXT then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/LocalLight', 'BatchSize', '64')
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '0')
			Cyberpunk.SetOption('Editor/SHARC', 'DownscaleFactor', '4')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '4')	
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT16 then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '3')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/SHARC', 'Bounces', '0')										-- performance hack, leave cache enabled with no bounces
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT20 then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '12')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '4')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.RTOnly then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '1000.0')
			return
		end

		if Var.settings.mode == Var.mode.RT_PT then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '1000.0')
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '2')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '4')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '0')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '0')
			return
		end

		if Var.settings.mode == Var.mode.PT21 then
			Cyberpunk.SetOption('RayTracing', 'TracingRadius', '200.0')
			Cyberpunk.SetOption('RayTracing/Reference', 'EnableProbabilisticSampling', false)
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumber', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'RayNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Reference', 'BounceNumberScreenshot', '0')
			Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumInitialSamples', '16')
			Cyberpunk.SetOption('Editor/RTXDI', 'NumEnvMapSamples', '8')
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableFallbackLight', true)
			Cyberpunk.SetOption('Editor/RTXDI', 'MaxHistoryLength', '12')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumSamples', '4')
			Cyberpunk.SetOption('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', '8')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumSamples', '5')
			Cyberpunk.SetOption('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', '2')
		end
	end
end

return Config
