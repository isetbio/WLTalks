%% Large mosaic 1 deg

chdir(fullfile(wltalksRootPath,'FVM'));

%%
fov = 2;

scene = sceneCreate('slanted bar');
scene = sceneSet(scene,'fov',fov);

oi = oiCreate;
oi = oiCompute(oi,scene);

%%
cMosaic = coneMosaic;
cMosaic.setSizeToFOV(fov);
cMosaic.emGenSequence(100);
cMosaic.compute(oi);
cMosaic.window;

%%