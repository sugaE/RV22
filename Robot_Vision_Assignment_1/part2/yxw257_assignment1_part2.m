clear all;
close all;
%% *Part 2*


blue_marble_3 = imread("Blue_Marble.jpg");
blue_marble = rgb2gray(blue_marble_3);

chicago_downtown_3 = imread("Chicago_Downtown_Aerial_View.jpg");
chicago_downtown = rgb2gray(chicago_downtown_3);

malards_park_3 = imread("Malards_in_Golden_Gate_Park.jpg");
malards_park = rgb2gray(malards_park_3);

% ks = ["blue_marble", "chicago_downtown", "malards_park"];
% vs = {blue_marble, chicago_downtown, malards_park};
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

[aois_bm, aoin_bm] = scale_feature(dog_bm, 10, [9, 200]);
aoin_bm
show_image(blue_marble_3, "q2.3_bm");
draw_aoi(aois_bm);


[aois_cd, aoin_cd] = scale_feature(dog_cd, 19, [11, 200]);
aoin_cd
show_image(chicago_downtown_3, "q2.3_cd");
draw_aoi(aois_cd);

[aois_mp, aoin_mp] = scale_feature(dog_mp, 15, [15, 200]);
aoin_mp
show_image(malards_park_3, "q2.3_mp");
draw_aoi(aois_mp);
%% 
% *Question 2.4*
% 
% Implement a function to examine the image neighbourhood of a feature and estimate 
% the orientation of the feature. The scale of the feature should be taken into 
% account when estimating the orientation. Apply your function to the accompanying 
% three images (see above) and show your results by overlaying the feature positions, 
% sizes, and orientations on the original images. 

%

%% 
%