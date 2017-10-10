%% Hex mosaic 1 deg

chdir(fullfile(wltalksRootPath,'FVM'));

load('coneMosaicHexOneDeg','theHexMosaic');

scene = sceneCreate('slanted bar');
scene = sceneSet(scene,'fov',1);
oi = oiCreate;
oi = oiCompute(oi,scene);

%%
theHexMosaic.emGenSequence(100);
theHexMosaic.compute(oi);
theHexMosaic.window;

%%