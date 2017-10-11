%% Stereo pair from TL

chdir(fullfile(wltalksRootPath,'FVM'));

%%

ieInit;

%% I chose the crop to center on the pawn

load('rtbBinocular_DOF/rtbBinocular_DOF_Left','oi');
ieAddObject(oi); oiWindow;

%%

rect = [245   184   224   224];

oiLeft = oi;
oiLeft = oiSet(oiLeft,'illuminance',oiCalculateIlluminance(oiLeft));
oiLeft = oiSet(oiLeft,'mean illuminance',10);
oiGet(oiLeft,'mean illuminance')

oiLeft = oiCrop(oiLeft,rect);
ieAddObject(oiLeft); oiWindow;

load('rtbBinocular_DOF/rtbBinocular_DOF_Right','oi');
oiRight = oi;
oiRight = oiSet(oiRight,'illuminance',oiCalculateIlluminance(oiRight));
oiRight = oiSet(oiRight,'mean illuminance',10);
oiGet(oiRight,'mean illuminance')

oiRight = oiCrop(oiRight,rect);
% oiRight = oiSet(oiRight,'hfov',fov);
ieAddObject(oiRight); oiWindow;

%%  Here we build a mosaic at some eccentricity deg 

% The number of cones depends on the eccentricity because the aperture
% grows with eccentricity.  We should plot that function as part of
% this tutorial.

deg = 1; center = [0 0.0003]*deg;   
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
