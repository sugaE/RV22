function [dots_count, fig] = draw_cir_ho(im, accum, circen, cirrad)

dots_count = size(circen, 1);
figure; imagesc(accum); axis image;
title('Accumulation Array from Circular Hough Transform');
fig = figure; imagesc(im); colormap('gray'); axis image;
hold on;
plot(circen(:,1), circen(:,2), 'r+');
for k = 1 : size(circen, 1)
 drawcircle("Center",circen(k, :), "Radius",cirrad(k), Color='b', MarkerSize=0.1, Label=num2str(cirrad(k)), LabelVisible='hover', LabelTextColor='red');
end
hold off;
title(['Raw Image with Circles Detected ', ...
 '(center positions and radii marked)']);
figure(3); surf(accum, 'EdgeColor', 'none'); axis ij;
title('3-D View of the Accumulation Array');

end

