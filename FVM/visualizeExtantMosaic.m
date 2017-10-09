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

% Export the figure ?
exportAsPDF = false;

hFig = figure(); clf;
set(hFig, 'Position', [10 10 2048 1024], 'Color', [1 1 1]);

% Show the mesh and and the density contours but do not label the cones
ax = subplot('Position', [0.03 0.05 0.45 0.94]);
% Visualize the inner segment
visualizedAperture = 'lightCollectingArea';

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

% Label the cones, plot on dark background, show outer-segment for better visibility
ax = subplot('Position', [0.52 0.05 0.45 0.94]);
% Visualize the the outer-segment
visualizedAperture = 'geometricArea';
backgroundColor = [0.8 0.8 0.8];
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
         'FontSize', 18, 'LineWidth', 1.5, ...
         'Color', backgroundColor);

if (exportAsPDF)
NicePlot.exportFigToPDF('mosaic.pdf', hFig, 300);
end

end


