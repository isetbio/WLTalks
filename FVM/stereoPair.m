%% Stereo pair from TL
%
% Used to illustrate the PBRT/RenderToolbox4 stuff we are doing.
%

chdir(fullfile(wltalksRootPath,'FVM'));

%%

ieInit;

%% I chose the crop to center on the pawn

load('rtbBinocular_DOF/rtbBinocular_DOF_Left','oi');
oi = oiSet(oi,'illuminance',oiCalculateIlluminance(oi));
oi = oiSet(oi,'name','Left eye view');
oi = oiInterpolateW(oi, 400:10:690);  % Causes some bug in width spatial resolution

ieAddObject(oi); hOI = oiWindow;
set(hOI,'position',[0.0117    0.3465    0.4035    0.5938]);
wave = oiGet(oi,'wave');

%% Show the lens pigmentation
L = Lens('wave',wave);  % L.transmittance
oiLens = oiSPDScale(oi,L.transmittance,'*');
oiLens = oiSet(oiLens,'name','Left with Lens');
ieAddObject(oiLens); oiWindow;

%% Crop the left

rect = [245   184   224   224];

oiLeft = oiLens;
oiLeft = oiSet(oiLeft,'illuminance',oiCalculateIlluminance(oiLeft));
oiLeft = oiSet(oiLeft,'mean illuminance',10);
oiGet(oiLeft,'mean illuminance')

oiLeft = oiCrop(oiLeft,rect);
ieAddObject(oiLeft); oiWindow;

%%  Here we build a mosaic at some eccentricity deg 

% The number of cones depends on the eccentricity because the aperture
% grows with eccentricity.  We should plot that function as part of
% this tutorial.

deg = .5; center = [0 0.0003]*deg; fov = 7;
cMosaicLeft = coneMosaic('center',center);
cMosaicLeft.setSizeToFOV(fov);
cMosaicLeft.name = sprintf('Chess-left-%2.1f',deg);
emParameters = emCreate;
nFrames = 100; 
scaleTremor = 5;
emParameters.tremor.amplitude = emParameters.tremor.amplitude*scaleTremor;
cMosaicLeft.emGenSequence(nFrames,'nTrials',1,'em',emParameters);

cMosaicLeft.compute(oiLeft);
hCM = cMosaicLeft.window;
set(hCM,'position',[0.0117    0.3465    0.4035    0.5938]);

%%
deg = 10; center = [0 0.0003]*deg; 
cMosaicLeft = coneMosaic('center',center);
cMosaicLeft.setSizeToFOV(fov);
cMosaicLeft.name = sprintf('Chess-left-%2.1f',deg);

cMosaicLeft.emGenSequence(100);
cMosaicLeft.compute(oiLeft);
hCM = cMosaicLeft.window;
set(hCM,'position',[0.0117    0.3465    0.4035    0.5938]);

%% 
cMosaicLeft.computeCurrent;
% cMosaicLeft.window;

clear bpL bpMosaicParams
bpL = bipolarLayer(cMosaicLeft);

ii = 1;
bpMosaicParams.spread  = 2;  % RF diameter w.r.t. input samples
bpMosaicParams.stride  = 2;  % RF diameter w.r.t. input samples
bpL.mosaic{ii} = bipolarMosaic(cMosaicLeft,'on midget',bpMosaicParams);
bpL.mosaic{ii}.compute;

bpL.window;

%% Now the right.

load('rtbBinocular_DOF/rtbBinocular_DOF_Right','oi');
oi = oiSet(oi,'illuminance',oiCalculateIlluminance(oiLeft));
oi = oiSet(oi,'name','Right eye view');
oi = oiInterpolateW(oi, wave);
ieAddObject(oi); oiWindow;

%% Show the lens pigmentation
oiLens = oiSPDScale(oi,L.transmittance,'*');
oiLens = oiSet(oiLens,'name','Right with Lens');
ieAddObject(oiLens); oiWindow;

%%
oiRight = oiLens;
oiRight = oiSet(oiRight,'illuminance',oiCalculateIlluminance(oiRight));
oiRight = oiSet(oiRight,'mean illuminance',10);
oiRight = oiCrop(oiRight,rect);
ieAddObject(oiRight); oiWindow;

%%
cMosaicRight = coneMosaic('center',center);
cMosaicRight.setSizeToFOV(fov);
cMosaicRight.pigment.wave = wave;

% cMosaicRight.emGenSequence(100);
cMosaicRight.compute(oiRight);
cMosaicRight.name = sprintf('Chess-right-%d',deg);
hCM = cMosaicRight.window;
set(hCM,'position',[0.0117    0.3465    0.4035    0.5938]);

%%
