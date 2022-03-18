%
% yxw257@student.bham.ac.uk
%
clear all;close all;clc; 
setup;
%% *Part 4*


dice1 = imread("dice1.jpg"); 

dice2 = imread("dice2.jpg"); 

dice3 = imread("dice3.jpg"); 

dice4 = imread("dice4.jpg"); 

imgs = {dice1, dice2, dice3, dice4};
names = ["dice1", "dice2", "dice3", "dice4"];

%% 
% *Question 4.1*	
% 
% Use the Circular Hough transformation (CircularHough Grd.m) for circle detection 
% on the dice images. Your task is to implement a code that detects and counts 
% the number of detected dots on the given dice images: dice1.jpg, dice2.jpg, 
% dice3.jpg, and dice4.jpg. 
% 
% Hint: Use hold on and plot functions to display the detected circles on the 
% image. 


counts = zeros(size(names));
debugging = 0;

for i=1:size(imgs, 2)
    figure
    im_c = imgs{i}; 
    rawimg = rgb2gray(im_c);  
%     laplacian of gaussian. Apply before Hough to get clean edges
    lap_g = [
        0 1 1 2 2 2 1 1 0;
        1 2 4 5 5 5 4 2 1;
        1 4 5 3 0 3 5 4 1;
        2 5 3 -12 -24 -12 3 5 2;
        2 5 0 -24 -40 -24 0 5 2;
        2 5 3 -12 -24 -12 3 5 2;
        1 4 5 3 0 3 4 4 1;
        1 2 4 5 5 5 4 2 1;
        0 1 1 2 2 2 1 1 0]; 
     
    gfimg = imfilter(rawimg, lap_g); 
    if debugging
        show_image(gfimg,"q4.1_log_"+names(i));
        [accum, circen, cirrad,dbg_LMmask,aois] = CircularHough_Grd(gfimg, [11 14], 25, 12, 1);
        draw_cir_ho(im_c,accum,circen,cirrad, names(i),aois,debugging);
    else
        [accum, circen, cirrad] = CircularHough_Grd(gfimg, [11 14], 25, 12, 1); 
        draw_cir_ho(im_c,accum,circen,cirrad, names(i));
    end
    counts(i) = size(circen, 1);
    fprintf("%s counts %d.\n",  names(i), counts(i));
end

%% 
%