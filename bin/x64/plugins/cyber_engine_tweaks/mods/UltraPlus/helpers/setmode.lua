-- setmode.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetMode(mode)
	Logger.info('Configuring mode for', mode)

	if mode == 'Unknown' then
		if not Cyberpunk.GetOption('/graphics/raytracing', 'RayTracing') then
			Var.settings.mode = Var.mode.RASTER
			return
		end

		if not Cyberpunk.GetOption('/graphics/raytracing', 'RayTracedPathTracing') then
			Var.settings.mode = Var.mode.RT
			return
		end

		Var.settings.mode = Var.mode.PT21
	end

	if mode == Var.mode.RASTER then
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', false)
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.15')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', false)
		return
	end

	if mode == Var.mode.RASTER then
		LoadIni('config/rt.ini', true)

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', false)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', false)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '0')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '1.0')						-- fake RT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', false)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', false)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', false)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', false)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', false)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', false)
		-- Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', false)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '100.0')
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.025')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.75')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '1.0')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.35')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', false)
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', false)
		return
	end

	if mode == Var.mode.RT then
		LoadIni('config/rt.ini', true)

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', false)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '1')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '1.0')						-- fake RT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', true)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', true)
		-- Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', true)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '100.0')
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', true)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.025')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.75')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '1.0')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.35')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', false)
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', false)
		return
	end

	if mode == Var.mode.RT_PT then
		LoadIni('config/rtpt.ini', true)

		Var.settings.sceneScale = Var.sceneScale.OFF

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpaceReflection', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', false)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'EnableNRD', true)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '1')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '1.0')						-- fake PT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', true)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', true)
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', true)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '70.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '70.0')
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', true)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', true)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForDirectRadiance', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForIndirectRadiance', false)
		Cyberpunk.SetOption('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.05')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.7')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '2.0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFused', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFallbackSampling', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableBoilingFilter', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseSpatialRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseTemporalRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'MaxHistoryLength', '0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'TargetHistoryLength', '0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'UseCustomDenoiser', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialSamplingRadius', '20.0')			-- WAS 64.0
		Cyberpunk.SetOption('Editor/RTXDI', 'InitialCandidatesInTemporal', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'BoilingFilterStrength', '0.45')			-- WAS 0.45
		Cyberpunk.SetOption('Editor/RTXDI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableApproximateTargetPDF', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'ForcedShadowLightSourceRadius', '0.1')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', true)								-- WAS false 5.3.4
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIAtPrimary', false)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIWithAlbedo', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrame', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrameBiasAllowance', '0.25')
		Cyberpunk.SetOption('Editor/SHARC', 'HistoryReset', '15')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.15')
		Cyberpunk.SetOption('Editor/PathTracing', 'UseScreenSpaceData', true)
		return
	end

	if mode == Var.mode.VANILLA then
		LoadIni('config/vanilla.ini', true)

		-- Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		-- Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', true)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpaceReflection', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', true)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '1')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.5')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '1.2')
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', true)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', true)
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', true)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '100.0')
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', true)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', true)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForDirectRadiance', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForIndirectRadiance', false)
		Cyberpunk.SetOption('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.025')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.75')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '1.0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'Enable', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFallbackSampling', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableBoilingFilter', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BoilingFilterStrength', '0.4')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseSpatialRGS', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseTemporalRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'MaxHistoryLength', '8')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'TargetHistoryLength', '8')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BiasCorrectionMode', '1')
		Cyberpunk.SetOption('Editor/RTXDI', 'UseCustomDenoiser', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialSamplingRadius', '32.0')
		Cyberpunk.SetOption('Editor/RTXDI', 'PermutationSamplingMode', '2')
		Cyberpunk.SetOption('Editor/RTXDI', 'InitialCandidatesInTemporal', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'BoilingFilterStrength', '0.5')
		Cyberpunk.SetOption('Editor/RTXDI', 'BiasCorrectionMode', '2')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableApproximateTargetPDF', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'ForcedShadowLightSourceRadius', '0.1')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIAtPrimary', false)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIWithAlbedo', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrame', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrameBiasAllowance', '0.25')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.1')
		Cyberpunk.SetOption('Editor/PathTracing', 'UseScreenSpaceData', false)
		return
	end

	if mode == Var.mode.PT16 then
		LoadIni('config/pt.ini', true)

		-- leave SHaRC enabled but set to fastest; performance hack
		Var.settings.sceneScale = Var.sceneScale.OFF

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', true)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpaceReflection', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', false)
		
		Cyberpunk.SetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode', true)
		
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '0')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '0.7')			  			-- fake PT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', true)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', true)
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', true)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)				
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)				-- 1fps faster
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '70.0')		-- WAS 70.0 improves RTXDI light/shadow selection
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '70.0')		-- WAS 70.0
		Cyberpunk.SetOption('RayTracing/Reference', 'EnableFixed', true)
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForDirectRadiance', true)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForIndirectRadiance', true)
		Cyberpunk.SetOption('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.05')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.7')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '2.0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFused', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFallbackSampling', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableBoilingFilter', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseSpatialRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseTemporalRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'MaxHistoryLength', '0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'TargetHistoryLength', '0')
		Cyberpunk.SetOption('Editor/RTXDI', 'UseCustomDenoiser', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialSamplingRadius', '20.0')				-- WAS 64.0
		Cyberpunk.SetOption('Editor/RTXDI', 'PermutationSamplingMode', '2')
		Cyberpunk.SetOption('Editor/RTXDI', 'InitialCandidatesInTemporal', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'BoilingFilterStrength', '0.45')				-- WAS 0.45
		Cyberpunk.SetOption('Editor/RTXDI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableApproximateTargetPDF', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'ForcedShadowLightSourceRadius', '0.1')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', true)							-- 5.3.4
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIAtPrimary', false)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIWithAlbedo', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrame', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrameBiasAllowance', '0.25')
		Cyberpunk.SetOption('Editor/SHARC', 'HistoryReset', '0')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.4')
		Cyberpunk.SetOption('Editor/PathTracing', 'UseScreenSpaceData', true)
		return
	end

	if mode == Var.mode.PT20 then
		LoadIni('config/pt.ini', true)

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', true)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpaceReflection', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode', true)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.05')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.7')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '2.0')
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '0')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '0.7')			  			-- fake PT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', true)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', true)
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', true)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)				-- 1fps faster
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '70.0')		-- WAS 70.0 improves RTXDI light/shadow selection
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '70.0')		-- WAS 70.0
		Cyberpunk.SetOption('RayTracing/Reference', 'EnableFixed', true)
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForDirectRadiance', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForIndirectRadiance', false)
		Cyberpunk.SetOption('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFused', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFallbackSampling', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableBoilingFilter', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseSpatialRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseTemporalRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'MaxHistoryLength', '0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'TargetHistoryLength', '0')
		Cyberpunk.SetOption('Editor/RTXDI', 'UseCustomDenoiser', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialSamplingRadius', '20.0')				-- WAS 64.0
		Cyberpunk.SetOption('Editor/RTXDI', 'PermutationSamplingMode', '2')
		Cyberpunk.SetOption('Editor/RTXDI', 'InitialCandidatesInTemporal', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'BoilingFilterStrength', '0.45')				-- WAS 0.45
		Cyberpunk.SetOption('Editor/RTXDI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableApproximateTargetPDF', false)			-- WAS true
		Cyberpunk.SetOption('Editor/RTXDI', 'ForcedShadowLightSourceRadius', '0.1')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIAtPrimary', false)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIWithAlbedo', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrame', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrameBiasAllowance', '0.25')
		Cyberpunk.SetOption('Editor/SHARC', 'HistoryReset', '15')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.4')
		Cyberpunk.SetOption('Editor/PathTracing', 'UseScreenSpaceData', true)
		return
	end

	if mode == Var.mode.PT21 then
		LoadIni('config/pt.ini', true)

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', true)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', false)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpaceReflection', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', false)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '0')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '0.7')			  			-- fake PT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', true)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', false)
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', true)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)				-- 1fps faster
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '70.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '70.0')
		Cyberpunk.SetOption('RayTracing/Reference', 'EnableFixed', true)
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '1')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForDirectRadiance', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForIndirectRadiance', false)
		Cyberpunk.SetOption('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', true)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.05')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.7')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '1.0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'Enable', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFused', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFallbackSampling', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableBoilingFilter', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BoilingFilterStrength', '0.4')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseSpatialRGS', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseTemporalRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'MaxHistoryLength', '16')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'TargetHistoryLength', '8')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'UseCustomDenoiser', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', true)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialSamplingRadius', '20.0')			-- WAS 64.0
		Cyberpunk.SetOption('Editor/RTXDI', 'PermutationSamplingMode', '2')
		Cyberpunk.SetOption('Editor/RTXDI', 'InitialCandidatesInTemporal', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'BoilingFilterStrength', '0.45')			-- WAS 0.45
		Cyberpunk.SetOption('Editor/RTXDI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableApproximateTargetPDF', false)		-- WAS true
		Cyberpunk.SetOption('Editor/RTXDI', 'ForcedShadowLightSourceRadius', '0.1')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIAtPrimary', false)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIWithAlbedo', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrame', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrameBiasAllowance', '0.25')
		Cyberpunk.SetOption('Editor/SHARC', 'HistoryReset', '15')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.4')
		Cyberpunk.SetOption('Editor/PathTracing', 'UseScreenSpaceData', true)
		return
	end

	if mode == Var.mode.PTNEXT then
		LoadIni('config/pt.ini', true)

		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracing', true)
		Cyberpunk.SetOption('/graphics/raytracing', 'RayTracedPathTracing', true)
		Cyberpunk.SetOption('Editor/ReGIR', 'Enable', true)
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', true)

		Cyberpunk.SetOption('Developer/FeatureToggles', 'PathTracingForPhotoMode', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'DistantGI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'RTXDI', true)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpaceReflection', false)
		Cyberpunk.SetOption('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', false)
		Cyberpunk.SetOption('Rendering', 'AllowRTXDIRejitter', false)
		Cyberpunk.SetOption('RayTracing', 'AmbientOcclusionRayNumber', '0')
		Cyberpunk.SetOption('RayTracing', 'SunAngularSize', '0.25')
		Cyberpunk.SetOption('RayTracing', 'SkyRadianceScale', '0.7')			  		-- fake PT sunlight on buildings
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableLocalShadow', true)
		Cyberpunk.SetOption('RayTracing', 'EnableTransparentReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableDiffuseIllumination', true)
		Cyberpunk.SetOption('RayTracing', 'EnableAmbientOcclusion', false)
		Cyberpunk.SetOption('RayTracing', 'EnableReflection', true)
		Cyberpunk.SetOption('RayTracing', 'EnableShadowOptimizations', true)
		Cyberpunk.SetOption('RayTracing', 'EnableGlobalIllumination', false)
		Cyberpunk.SetOption('RayTracing', 'EnableImportanceSampling', false)
		Cyberpunk.SetOption('RayTracing', 'ForceShadowLODBiasUsage', false)
		Cyberpunk.SetOption('RayTracing/Debug', 'EnableVisibilityCheck', false)			-- 1fps faster
		Cyberpunk.SetOption('RayTracing/Collector', 'VisibilityFrustumOffset', '200.0')
		Cyberpunk.SetOption('RayTracing/Collector', 'LocalShadowCullingRadius', '100.0')
		Cyberpunk.SetOption('RayTracing/Reference', 'EnableFixed', false)
		Cyberpunk.SetOption('RayTracing/Reflection', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Reflection', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/Diffuse', 'EnableHalfResolutionTracing', '0')
		Cyberpunk.SetOption('RayTracing/Diffuse', 'AdaptiveSampling', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForDirectRadiance', false)
		Cyberpunk.SetOption('RayTracing/NRD', 'UseReblurForIndirectRadiance', false)
		Cyberpunk.SetOption('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', false)
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'Enable', false)			-- 4.8.0
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'VarianceCutoff', '0.05')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'MotionFactor', '0.7')
		Cyberpunk.SetOption('Rendering/VariableRateShading', 'ScreenEdgeFactor', '2.0')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'Enable', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFused', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableFallbackSampling', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'EnableBoilingFilter', true)	   			-- WAS false
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BoilingFilterStrength', '0.4')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseSpatialRGS', true)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'UseTemporalRGS', false)
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'MaxHistoryLength', '16')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'TargetHistoryLength', '8')
		Cyberpunk.SetOption('Editor/ReSTIRGI', 'BiasCorrectionMode', '3')
		Cyberpunk.SetOption('Editor/RTXDI', 'UseCustomDenoiser', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableRTXDIDenoising', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'SpatialSamplingRadius', '0.0')				-- WAS 64.0
		Cyberpunk.SetOption('Editor/RTXDI', 'PermutationSamplingMode', '0')
		Cyberpunk.SetOption('Editor/RTXDI', 'InitialCandidatesInTemporal', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'BoilingFilterStrength', '0.0')				-- WAS 0.35 TEST
		Cyberpunk.SetOption('Editor/RTXDI', 'BiasCorrectionMode', '0')
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableApproximateTargetPDF', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'ForcedShadowLightSourceRadius', '0.1')
		Cyberpunk.SetOption('Editor/SHARC', 'Enable', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIAtPrimary', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UseRTXDIWithAlbedo', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrame', true)
		Cyberpunk.SetOption('Editor/SHARC', 'UsePrevFrameBiasAllowance', '0.25')			-- 4.8.0
		Cyberpunk.SetOption('Editor/SHARC', 'HistoryReset', '15')
		Cyberpunk.SetOption('Editor/Characters/Eyes', 'DiffuseBoost', '0.1')
		Cyberpunk.SetOption('Editor/PathTracing', 'UseScreenSpaceData', true)
		-- Cyberpunk.SetOption('Editor/PathTracing', 'UseSSRFallback', false)
		return
	end
end

return Config
