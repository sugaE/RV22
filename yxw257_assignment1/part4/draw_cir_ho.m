function [dots_count, fig] = draw_cir_ho(im, accum, circen, cirrad, file_name,accumAOI,debugging)

arguments
    im
    accum
    circen
    cirrad
    file_name string = "" 
    accumAOI = []
    debugging = false
end

dots_count = size(circen, 1);

if debugging
    figure; imagesc(accum); axis image;
    % draw_aoi(accumAOIsss);
    draw_aoi(accumAOI);
    title('Accumulation Array from Circular Hough Transform');
end

fig = figure;  
show_image(im, "", fig);
colormap("default"); 

hold on;
plot(circen(:,1), circen(:,2), 'r+', MarkerSize=10, LineWidth=5);
for k = 1 : size(circen, 1)
    drawcircle("Center",circen(k, :), "Radius",cirrad(k),LineWidth=3, Color='b', MarkerSize=0.1, Label=num2str(cirrad(k)), LabelVisible='hover', LabelTextColor='red');
end
hold off;

% draw_aoi(accumAOIsss);
draw_aoi(accumAOI);

% export image as png file
if strlength(file_name)
    title(file_name+", counts "+num2str(dots_count));
    exportgraphics(fig, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end

% figure; surf(accum, 'EdgeColor', 'none'); axis ij;
% title('3-D View of the Accumulation Array');

end

