%% 
% *Question 1.2*

clear all; close all; clc; 
%% 
% There are various algorithms which detect different kinds of features. An 
% image of the School of Computer Science of UoB is provided. 
% 
% Plot on a 2×3 sub-plotted figure, the 100 strongest features when using the 
% 
% Minimum Eigenvalue, SURF, KAZE, FAST, ORB and the Harris-Stephens algorithms.
% 
% Include this sub-figure in your report and ensure that when the MATLAB file 
% executes, it appears as a sub-figure. Save and include the MATLAB sub-figure 
% in your submission. 

I3 = imread("Q_1_2/UoB_CS_building.png");
I = rgb2gray(I3);
num = 100;
fig = figure;


points = detectMinEigenFeatures(I);
subplot(2,3,1);
imshow(I); hold on;
title("Minimum Eigenvalue");
plot(points.selectStrongest(num));
hold off;

points = detectSURFFeatures(I);
subplot(2,3,2);
imshow(I); hold on;
title("SURF");
plot(points.selectStrongest(num));
hold off;

points = detectKAZEFeatures(I);
subplot(2,3,3);
imshow(I); hold on;
title("KAZE");
plot(points.selectStrongest(num));
hold off;

points = detectFASTFeatures(I);
subplot(2,3,4);
imshow(I); hold on;
title("FAST");
plot(points.selectStrongest(num));
hold off;

points = detectORBFeatures(I);
subplot(2,3,5);
imshow(I); hold on;
title("ORB");
plot(points.selectStrongest(num));
hold off;

points = detectHarrisFeatures(I);
subplot(2,3,6);
imshow(I); hold on;
title("Harris-Stephens");
plot(points.selectStrongest(num));
hold off;

%%
% export image as png file
exportgraphics(fig, "yxw257_assignment2_part1_Q1_2.png", BackgroundColor="none", Resolution=600);
savefig(fig, "yxw257_assignment2_part1_Q1_2.fig");