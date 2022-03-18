%
% yxw257@student.bham.ac.uk
%
clear all;close all;clc; 
setup;
%% *Part 2*


blue_marble_3 = imread("Blue_Marble.jpg");
blue_marble = rgb2gray(blue_marble_3);

chicago_downtown_3 = imread("Chicago_Downtown_Aerial_View.jpg");
chicago_downtown = rgb2gray(chicago_downtown_3);

malards_park_3 = imread("Malards_in_Golden_Gate_Park.jpg");
malards_park = rgb2gray(malards_park_3);

%% 
% *Question 2.1*	
% 
% Implement a function to apply any difference of Gaussian filter to an image. 
% It should be possible to give the size of the filter in pixels, and the parameters 
% of the two Gaussian, as inputs to the function. You may use existing MATLAB 
% functions for filtering but must write your own code to generate difference 
% of Gaussian kernels. Implement a default set of parameters for the two Gaussian 
% that approximates the Laplacian of the Gaussian in the case where the only input 
% given to the function is the size of the filter in pixels. Apply a 15 × 15 difference 
% of Gaussian filter to the accompanying three images (see above) using your function 
% and show your results. 

% part2/dog.m
g3 = dog([3,3], 0, 1.6, 0, 5);

g3_re = conv2(blue_marble, g3);
show_image(g3_re, "q2.1_g3_blue_marble");

g15 = dog([15,15]);

g15_bm = conv2(blue_marble, g15); 
show_image(g15_bm, "q2.1_g15_blue_marble");

g15_cd = conv2(chicago_downtown, g15);
show_image(g15_cd, "q2.1_g15_chicago_downtown");

g15_mp = conv2(malards_park, g15);
show_image(g15_mp, "q2.1_g15_malards_park");
%% 
% *Question 2.2*
% 
% Implement a function to apply difference of Gaussian filters to an image at 
% different scales to produce a set of filtered images forming a scale-space pyramid. 
% Apply your function to the accompanying three images (see above) and show the 
% different scales produced by your function. 

% part2/dogwithscale.m
size_of_g = 3:2:19;
dog_bm=dogwithscale(blue_marble, size_of_g, 0, 0.8, "q2.2_bm");
dog_cd=dogwithscale(chicago_downtown, size_of_g, 0, 0.8, "q2.2_cd");
dog_mp=dogwithscale(malards_park, size_of_g, 0, 0.8, "q2.2_mp");
%% 
% *Question 2.3*
% 
% Implement a function to search a scale-space pyramid and identify strong filter 
% responses. Assume that each of the strong filter responses corresponds to a 
% feature of interest in the image. The function should return the properties 
% of each of the features, which should consist of the position and scale that 
% maximises the filter response. Apply your function to the accompanying three 
% images (see above) and show your results by overlaying the feature positions 
% and sizes on the original images. 

% part2/scale_feature.m
%
% chicago_downtown
[aois_bm, aoin_bm] = scale_feature(dog_bm, 150,"q2.3_bm_grad");
aoin_bm
fig1 = figure;
show_image(blue_marble_3, "",fig1); 
draw_aoi(aois_bm);
exportgraphics(fig1, fullfile("images/q2.3_bm.png"), BackgroundColor="none", Resolution=600);

% chicago_downtown
[aois_cd, aoin_cd] = scale_feature(dog_cd, 450,"q2.3_cd_grad");
aoin_cd
fig2 = figure;
show_image(chicago_downtown_3, "",fig2); 
draw_aoi(aois_cd);
exportgraphics(fig2, fullfile("images/q2.3_cd.png"), BackgroundColor="none", Resolution=600);

% malards_park
[aois_mp, aoin_mp] = scale_feature(dog_mp, 350,"q2.3_mp_grad");
aoin_mp
fig3 = figure;
show_image(malards_park_3, "",fig3); 
draw_aoi(aois_mp);
exportgraphics(fig3, fullfile("images/q2.3_mp.png"), BackgroundColor="none", Resolution=600);
%% 
% *Question 2.4*
% 
% Implement a function to examine the image neighbourhood of a feature and estimate 
% the orientation of the feature. The scale of the feature should be taken into 
% account when estimating the orientation. Apply your function to the accompanying 
% three images (see above) and show your results by overlaying the feature positions, 
% sizes, and orientations on the original images. 

% part2/rotate_feature.m
%
[rxy_bm,aois_bm] = rotate_feature(dog_bm, 150,"q2.4_bm_grad");
fig1 = figure;
show_image(blue_marble_3,"" ,fig1); 
draw_ori(rxy_bm, aois_bm);
exportgraphics(fig1, fullfile("images/q2.4_bm.png"), BackgroundColor="none", Resolution=600);

%
[rxy_cd,aois_cd] = rotate_feature(dog_cd, 450,"q2.4_cd_grad");
fig1 = figure;
show_image(chicago_downtown_3,"" ,fig1); 
draw_ori(rxy_cd, aois_cd);
exportgraphics(fig1, fullfile("images/q2.4_cd.png"), BackgroundColor="none", Resolution=600);

%
[rxy_mp,aois_mp] = rotate_feature(dog_mp, 350,"q2.4_mp_grad");
fig1 = figure;
show_image(malards_park_3,"" ,fig1); 
draw_ori(rxy_mp, aois_mp);
exportgraphics(fig1, fullfile("images/q2.4_mp.png"), BackgroundColor="none", Resolution=600);


%% 
%