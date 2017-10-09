%% Make a 1 deg hex cone mosaic image

ieInit; clear; close all;

%% Set mosaic parameters
mosaicParams = struct(...
    'name', 'the hex mosaic', ...
    'resamplingFactor', 9, ...                      % Sets underlying pixel spacing; controls the rectangular sampling of the hex mosaic grid
    'fovDegs', 1, ...                               % FOV in degrees
    'eccBasedConeDensity', true, ...                % Whether to have an eccentricity based, spatially - varying density
    'sConeMinDistanceFactor', 3.0, ...              % Min distance between neighboring S-cones = f * local cone separation - used to make the S-cone lattice semi-regular
    'sConeFreeRadiusMicrons', 0.15*300, ...         % Radius of S-cone free retina, in microns (300 microns/deg).
    'spatialDensity', [0 6/10 3/10 1/10]...         % With a LMS density of of 6:3:1
    );

% 360 seconds
lowQuality.tolerance1 = 0.01*10;
lowQuality.tolerance2 = 0.001*10;
lowQuality.marginF = 1.3;
lowQuality.mosaicFileName = 'lowQMosaic.mat';
lowQuality.saveMosaic = true;

theHexMosaic = coneMosaicHex(mosaicParams.resamplingFactor, ...
    'name', mosaicParams.name, ...
    'fovDegs', mosaicParams.fovDegs, ...
    'eccBasedConeDensity', mosaicParams.eccBasedConeDensity, ...
    'sConeMinDistanceFactor', mosaicParams.sConeMinDistanceFactor, ... 
    'sConeFreeRadiusMicrons', mosaicParams.sConeFreeRadiusMicrons, ...                   
    'spatialDensity', mosaicParams.spatialDensity, ...
    'latticeAdjustmentPositionalToleranceF', qParams.tolerance1, ...   % This value is too high and is chosen to reduce the compute time. For production work, either do not set, or set to equal or lower than 0.01      
    'latticeAdjustmentDelaunayToleranceF', qParams.tolerance2, ...     % This value is too high and is chosen to reduce the compute time. For production work, either do not set, or set to equal or lower than 0.001
    'marginF', qParams.marginF ...                                     % How much larger lattice to generate so as to minimize artifacts in cone spacing near the edges. For production work, do not set this option.
);
toc

%%