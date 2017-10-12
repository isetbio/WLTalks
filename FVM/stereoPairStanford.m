%% Stereo pair from TL

chdir(fullfile(wltalksRootPath,'FVM'));

%%

ieInit;

%% I chose the crop to center on the pawn

load('rtbBinocular_DOF/rtbBinocular_DOF_Left','oi');
oiLeft = oi;
oiLeft = oiSet(oiLeft,'illuminance',oiCalculateIlluminance(oiLeft));
oiLeft = oiSet(oiLeft,'mean illuminance',10);
ieAddObject(oiLeft); hOI = oiWindow;
pos = [ 0.0117    0.4479    0.3383    0.4924];
set(hOI,'position',pos);

wave = oiGet(oiLeft,'wave');
L = Lens('wave',wave);
oiLeftLens = oiSPDScale(oiLeft,L.transmittance,'*');

% 700 is bad, so deleted it.
oiLeftLens = oiInterpolateW(oiLeftLens,400:10:690);
ieAddObject(oiLeftLens); oiWindow;

%%

rect = [245   184   224   224];
oiLeftCropped = oiCrop(oiLeftLens,rect);
oiLeftCropped = oiSet(oiLeftCropped,'name','Cropped-lens-sleft');
ieAddObject(oiLeftCropped); oiWindow;

%%
load('rtbBinocular_DOF/rtbBinocular_DOF_Right','oi');
oiRight = oi;
oiRight = oiSet(oiRight,'illuminance',oiCalculateIlluminance(oiRight));
oiRight = oiSet(oiRight,'mean illuminance',10);
ieAddObject(oiRight); hOI = oiWindow;

wave = oiGet(oiRight,'wave');
L = Lens('wave',wave);
oiRightLens = oiSPDScale(oiRight,L.transmittance,'*');

% 700 is bad, so deleted it.
oiRightLens = oiInterpolateW(oiRightLens,400:10:690);
ieAddObject(oiRightLens); oiWindow;

%%  Here we build a mosaic at some eccentricity deg 

% The number of cones depends on the eccentricity because the aperture
% grows with eccentricity.  We should plot that function as part of
% this tutorial.

deg = 10; center = [0 0.0003]*deg;   
fov = 7;
cMosaicLeft = coneMosaic('center',center);
cMosaicLeft.setSizeToFOV(fov);
cMosaicLeft.name = sprintf('Chess-left-%d',deg);

cMosaicLeft.emGenSequence(100);
cMosaicLeft.compute(oiLeft);
cMosaicLeft.window;

%% Now the right.

cMosaicRight = coneMosaic('center',center);
cMosaicRight.setSizeToFOV(fov);

cMosaicRight.emGenSequence(100);
cMosaicRight.compute(oiRight);
cMosaicRight.name = sprintf('Chess-right-%d',deg);
cMosaicRight.window;
