function visualizeExtantMosaic()
%% Visualize a previously saved mosaic
%

% Select mosaic file to visualize
[theDir,~] = fileparts(which(mfilename()));
load(fullfile(theDir, 'coneMosaicHexOneDeg.mat'));

% Set axes limits
XYTicks =  150*[-1 -0.5 0 0.5 1]*1e-6;
XYTickLabels = sprintf('%2.0f\n', XYTicks*1e6);
XYLims = [XYTicks(1) XYTicks(end)];

% Visualize the inner segment, the outer-segment, or both?
visualizedAperture = 'lightCollectingArea';                             % choose between 'both', 'lightCollectingArea', 'geometricArea'

hFig = figure(); clf;
set(hFig, 'Position', [10 10 2048 1024], 'Color', [1 1 1]);

% 
ax = subplot('Position', [0.03 0.05 0.45 0.94]);
theHexMosaic.visualizeGrid(...
    'axes', ax, ...
    'visualizedConeAperture', visualizedAperture, ...
    'apertureShape', 'disks', ...                                       % choose from {'hexagons' and 'disks'}
    'labelConeTypes', false, ...                                        % do not label cones
    'overlayHexMesh', true, ...                                         % show the hex mesh
    'overlayConeDensityContour', 'theoretical_and_measured', ...        % choose from {'theoretical_and_measured', 'theoretical', 'measured'}
    'coneDensityContourLevels', 1000*(110:25:240), ...                  % iso-density levels (cones/mm^2)
    'generateNewFigure', false);
xlabel('microns', 'FontWeight', 'bold');
ylabel('microns', 'FontWeight', 'bold');
box on
set(ax, 'XLim', XYLims, 'YLim', XYLims, ...
         'XTick', XYTicks, 'YTick', XYTicks, ...
         'XTickLabel', XYTickLabels,'YTickLabel', XYTickLabels, ...
         'FontSize', 18, 'LineWidth', 1.5);


ax = subplot('Position', [0.52 0.05 0.45 0.94]);
theHexMosaic.visualizeGrid(...
    'axes', ax, ...
    'visualizedConeAperture', visualizedAperture, ...
    'apertureShape', 'disks', ...
    'labelConeTypes', true, ...
    'overlayHexMesh', false, ...
    'generateNewFigure', false);
xlabel('microns', 'FontWeight', 'bold');
box on
set(ax, 'XLim', XYLims, 'YLim', XYLims, ...
         'XTick', XYTicks, 'YTick', XYTicks, ...
         'XTickLabel', XYTickLabels,'YTickLabel', XYTickLabels, ...
         'FontSize', 18, 'LineWidth', 1.5);

NicePlot.exportFigToPDF('mosaic.pdf', hFig, 300);
    
end


