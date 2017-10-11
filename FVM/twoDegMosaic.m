%% Large mosaic 1 deg

chdir(fullfile(wltalksRootPath,'FVM'));
cMosaic = coneMosaic;
cMosaic.setSizeToFOV(5); 

%%

scene = sceneCreate('slanted bar');
scene = sceneSet(scene,'fov',5);
oi = oiCreate;
oi = oiCompute(oi,scene);

%%

cMosaic.emGenSequence(100);
cMosaic.compute(oi);
cMosaic.window;

%%