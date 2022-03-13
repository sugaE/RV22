clear all;
close all;
%% *Part 3*

checkerboardP = imread("checkerboardPhoto.png"); 
figure; checkerboardP = imagesc(checkerboardP);
checkerboardP = checkerboardP.CData();
axis image; colormap("gray");

circleP = imread("circlePhoto.png"); 
figure; circleP = imagesc(circleP); 
circleP = circleP.CData();
axis image; colormap("gray"); 
%% 
% *Question 3.1*	
% 
% Load the checkerboardPhoto.png and circlePhoto.png images. Convert them to 
% grayscale. 
% 
% Write a function, convolve, which takes a filter, F, and an image, I, as input 
% and calculates the 2D convolutions of I with F via the use of ‘for’ loops. Zero-pad 
% the image within the function to ensure that the filtered image is the same 
% size as the original image. You may assume that F always has an odd value for 
% its height and width. DO NOT USE the existing conv, conv2, convn, filter, or 
% filter2 functions. Apply a 15×15 Gaussian filter with a standard deviation of 
% 5 to both images using the convolve function. Show the results. 
% 
% Hint: The built-in function padarray is useful for zero-padding.

g15 = gaussian_mn([15, 15], 5); % defined in folder `part2/`, need to add `part2/` to path
checker_g15 = convolve(checkerboardP, g15);
circle_g15 = convolve(circleP, g15);
show_image(checker_g15 ,'q3.1_checker_g15');
show_image(circle_g15 ,'q3.1_circle_g15');
%% 
% *Question 3.2*		
% 
% Apply a 15×15 box filter to the loaded images using the convolve function. 
% Show the results. 

b_15 = box_blur(15); % 15×15 box filter; box_blur defined in part3/
checker_b15 = convolve(checkerboardP, b_15); % convolve defined in part3/
circle_b15 = convolve(circleP, b_15); % convolve defined in part3/
show_image(checker_b15 ,'q3.2_checker_b15');
show_image(circle_b15 ,'q3.2_circle_b15');
%% 
% *Question 3.3*	
% 
% Implement a nonlinear filter — a median filter. While the Gaussian filter 
% works by computing locally-weighted values of the signal, the median filter 
% first sorts the signal values within a window and then takes the middle value 
% (i.e., the median). 
% 
% Implement a function, simpleMedian, which takes as input an image, I, and 
% the dimensions of the median filter, W and H, and returns a median filtered 
% image. Zero-pad the image within the function to ensure that the filtered image 
% is the same size as the original image. 
% 
% Apply a 15×15 median filter to the loaded images. Show the results.

% simpleMedian is super slow becuase no optimised sort is used
checker_med = simpleMedian(checkerboardP, 15, 15); % convolve defined in part3/
circle_med = simpleMedian(circleP, 15, 15);
show_image(checker_med ,'q3.3_checker_med');
show_image(circle_med ,'q3.3_circle_med');
%% 
% *Question 3.4*				
% 
% Load the Malards in Golden Gate Park.jpg image from part 2. Convert it to 
% grayscale. Corrupt it with: 
% 
% i. Salt and Pepper Noise (noise density = 0.075):
% 
% ii. Gaussian Noise (mean = 0.1, variance = 0.15): 		
% 
% Examples of the two types of noise are shown in Figure 2 Then examine the 
% effects of your Gaussian, Box, and Median filters in turn on the two types of 
% noise. Display the results in a 2 × 4 figure with subplots, with the noise type 
% changing between the rows and the columns displaying the filter used (no filter, 
% Gaussian, Box, and Median). The layout is shown in Figure 3. 
% 
% Which filter performs the best on each noise and why? Explain what you see. 
% Hint: The built-in function imnoise is useful for adding noise. 

% loading image
malards_park_3 = imread("Malards_in_Golden_Gate_Park.jpg");
figure; malards_p = imagesc(rgb2gray(malards_park_3)); axis image; colormap("gray");
malards_p = malards_p.CData();
%%
% add noises
figure;
malards_sp = imnoise(malards_p, 'salt & pepper', 0.075); 
% show_image(malards_sp ,'q3.4_malards_sp');

malards_g = imnoise(malards_p, 'gaussian', 0.1, 0.15);  
% show_image(malards_g ,'q3.4_malards_g');
%%
% n = 3;
for n=[3, 7, 11]
    g_n = gaussian_mn([n,n], n/2);
    b_n = box_blur(n);
    
    malards_sp_g15 = convolve(malards_sp, g_n); 
    malards_sp_b15 = convolve(malards_sp, b_n); 
    malards_sp_med = simpleMedian(malards_sp, n, n); 
    
    malards_g_g15 = convolve(malards_g, g_n); 
    malards_g_b15 = convolve(malards_g, b_n); 
    malards_g_med = simpleMedian(malards_g, n, n); 
    
    fig4 = figure;  
    subplot(2, 4, 1); imshow(malards_sp); title("S&P corrupted")
    subplot(2, 4, 2); imagesc(malards_sp_g15); axis image; axis off; title("Gaussian on S&P, "+num2str(n))
    subplot(2, 4, 3); imagesc(malards_sp_b15); axis image; axis off; title("Box on S&P, "+num2str(n))
    subplot(2, 4, 4); imagesc(malards_sp_med); axis image; axis off; title("Median on S&P, "+num2str(n))
    subplot(2, 4, 5); imshow(malards_g); title("Gaussian corrupted")
    subplot(2, 4, 6); imagesc(malards_g_g15); axis image; axis off; title("Gaussian on Gaussian, "+num2str(n))
    subplot(2, 4, 7); imagesc(malards_g_b15); axis image; axis off; title("Box on Gaussian, "+num2str(n))
    subplot(2, 4, 8); imagesc(malards_g_med); axis image; axis off; title("Median on Gaussian, "+num2str(n))
    colormap("gray");
    exportgraphics(fig4, fullfile("images/q3.4_g"+n+".png"), BackgroundColor="none", Resolution=600);
end


%% 
%