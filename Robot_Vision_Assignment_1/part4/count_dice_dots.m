function [dots_count, fig] = count_dice_dots(im)

% g5 = kgauss(1, 5); % or can use gaussian_mn() from part2 
g5 = dog([7,7]);
im_gray = rgb2gray(im);
rawimg = conv2(im_gray, g5);
figure; imagesc(rawimg); axis image;
tic;
[accum, circen, cirrad] = CircularHough_Grd(rawimg, [0 360], 8, 15, 0.7)
toc;
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

