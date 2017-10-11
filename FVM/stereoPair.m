%% Stereo pair from TL

chdir(fullfile(wltalksRootPath,'FVM'));

%%

ieInit;

%%
load('rtbBinocular_DOF/rtbBinocular_DOF_Left','oi');
oiLeft = oi;
oiLeft = oiSet(oiLeft,'illuminance',oiCalculateIlluminance(oiLeft));
oiLeft = oiSet(oiLeft,'mean illuminance',10);
oiGet(oiLeft,'mean illuminance')

rect = [245   184   197   251];
oiLeft = oiCrop(oiLeft,rect);
ieAddObject(oiLeft); oiWindow;

load('rtbBinocular_DOF/rtbBinocular_DOF_Right','oi');
oiRight = oi;
oiRight = oiSet(oiRight,'illuminance',oiCalculateIlluminance(oiRight));
oiRight = oiSet(oiRight,'mean illuminance',10);
oiGet(oiRight,'mean illuminance')

rect = [245   184   197   251];
oiRight = oiCrop(oiRight,rect);
% oiRight = oiSet(oiRight,'hfov',fov);
ieAddObject(oiRight); oiWindow;

%%  Can we build the mosaic at some eccentricity and view a smaller patch?

% Here is a kind of big (almost 2K x 2K) mosaic
% cMosaic = coneMosaic;
% cMosaic.setSizeToFOV(12);
% cMosaic.emGenSequence(50);
% cMosaic.compute(oiLeft);
% cMosaic.window;

%%  Here we build a mosaic at 5 deg 

deg = 2; center = [0 0.0003]*deg;   

cMosaicLeft = coneMosaic('center',center);
cMosaicLeft.setSizeToFOV(10);
cMosaicLeft.name = sprintf('Chess-left-%d',deg);

cMosaicLeft.emGenSequence(100);
cMosaicLeft.compute(oiLeft);
cMosaicLeft.window;

%%
cMosaicRight = coneMosaic('center',center);
cMosaicRight.emGenSequence(100);
cMosaicRight.compute(oiRight);
cMosaicRight.name = sprintf('Chess-right-%d',deg);
cMosaicRight.window;
