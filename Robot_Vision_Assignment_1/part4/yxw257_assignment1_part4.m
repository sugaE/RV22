clear all;
close all;
%% *Part 4*

figure;

dice1 = imread("dice1.jpg");
% dice1 = rgb2gray(dice1);
% subplot(1, 4, 1);
% imshow(dice1)

dice2 = imread("dice2.jpg");
% dice2 = rgb2gray(dice2);
% subplot(1, 4, 2);
% imshow(dice2)

dice3 = imread("dice3.jpg");
% dice3 = rgb2gray(dice3);
% subplot(1, 4, 3);
% imshow(dice3)


dice4 = imread("dice4.jpg");
% dice4 = rgb2gray(dice4);
% subplot(1, 4, 4);
% imshow(dice4)

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

% imglist = [dice1, dice2, dice3, dice4];
% g5 = dog([5,5]); % or can use gaussian_mn() from part2 
% rawimg = filter2(g5 , dice1);
% figure; imagesc(rawimg);axis image;
% 
% g5 = kgauss(1, 5); % or can use gaussian_mn() from part2 
% rawimg = filter2(g5 , dice4);
% figure; imagesc(rawimg);axis image;


count_dice_dots(dice1)
count_dice_dots(dice2)
count_dice_dots(dice3)
count_dice_dots(dice4)
%%
im = dice1
im = rgb2gray(im);

g5 = dog([9,9]);
% rawimg = conv2(im_gray, g5)
% rawimg = edge(im, "sobel") .* 1.0
rawimg = conv2(im, kgauss(1))
figure; imagesc(rawimg); axis image; 
[accum, circen, cirrad] = CircularHough_Grd(rawimg, [10, 15], 0, 15, 1)
draw_cir_ho(im, accum, circen, cirrad)
%%
im = dice2;
im = rgb2gray(im);
 
% rawimg = conv2(im_gray, g5)
rawimg = edge(im, "log") .* 1.0
rawimg = conv2(rawimg, kgauss(1));
figure; imagesc(rawimg); axis image; 
[accum, circen, cirrad] = CircularHough_Grd(rawimg, [10, 15], 0.08, 19, 1)
draw_cir_ho(im, accum, circen, cirrad)
%%
im = dice3;
im = rgb2gray(im);
 
% rawimg = conv2(im_gray, g5)
rawimg = edge(im, "log") .* 1.0
rawimg = conv2(rawimg, kgauss(1));
figure; imagesc(rawimg); axis image; 
[accum, circen, cirrad] = CircularHough_Grd(rawimg, [10, 15], 0.12, 19, 1)
draw_cir_ho(im, accum, circen, cirrad)
%%
im = dice4;
im = rgb2gray(im);
 
g5 = dog([9,9]);
% rawimg = conv2(im_gray, g5)
rawimg = edge(im, "log") .* 1.0
rawimg = conv2(rawimg, kgauss(0.9));
figure; imagesc(rawimg); axis image; 
[accum, circen, cirrad] = CircularHough_Grd(rawimg, [10, 15], 0.14, 22, 1)
draw_cir_ho(im, accum, circen, cirrad)
%% 
%