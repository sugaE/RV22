%% 
% Step1:

shakey = read_image('', 'shakey.150.gif');
% help read_image
show_image(shakey, false);
%%
load sobel.mat
% who
sobelX
sobelY
%% 
% Task1:

im_sol = task1(shakey, sobelX, sobelY, 0, 50, 'sobel-'); 
%% 
% *QUESTION 1: What do you notice regarding the effect of changing the threshold?* 
% 
% *when the threshold is too small, there's not much useful information. ( At 
% least not to human eye)*
% 
% *when the threshold reaches around the mean of the image, the edges become 
% clearer.*
% 
% *when the threshold gets larger. The edges get rblury.*
%% 
% Task2:

load roberts.mat;
robertsA
robertsB
%%

% task1(shakey, sobelX, sobelY, -1, 10, 'sobel-x-');
% task1(shakey, sobelX, sobelY, -2, 10, 'sobel-y-');
im_rob = task1(shakey, robertsA, robertsB, 0, 10, 'roberts-');
% task1(shakey, robertsA, robertsB, -1, 10, 'roberts-x-');
% task1(shakey, robertsA, robertsB, -2, 10, 'roberts-y-');
%% 
% *QUESTION 2: What do you notice regarding the difference between Sobel and 
% Roberts?*
% 
% *roberts produce more grid like noises in general because sobel is 3*3 so 
% can preserve more.*
%% 
% Task3:

im_app = task1(shakey, sobelX, sobelY, 1, 50, 'sobel-appr-');

%%
im_diff = im_sol - im_app
show_images(im_diff) 
%%
for i=[1 2 3 4 5]
    show_image(im_diff(:,:,i), ['sobel-diff-', num2str(i)])
end
%%
im_diff2 = im_rob - im_app
show_images(im_diff2)
%%

for i=[1 2 3 4 5]
    show_image(im_diff2(:,:,i), ['rob-diff-', num2str(i)])
end
%% 
% *QUESTION 3: What do you notice regarding the difference between magnitude 
% and absolute when calculating the edge?* 
% 
% 
% 
% *Denoising:*

gaussian5 = conv_gaussian(5, 1.4);
% round(gaussian5 * 159)
shakey_smooth = conv2(shakey, gaussian5, "same");
im_g5 = task1(shakey_smooth, sobelX, sobelY, 0, 50, 'gaussian5-');

im_diff5 = im_sol(:,:,1:5) - im_g5;
show_images(im_diff5)
show_image(im_diff5(:,:,3), ['g5-diff-mean']);
%%

gaussian3 = conv_gaussian(3, 1)
% gaussian5 .* 256
shakey_smooth = conv2(shakey, gaussian3, "same");
%%

im_g3 = task1(shakey_smooth, sobelX, sobelY, 0, 50, 'gaussian3-');

im_diff3 = im_sol(:,:,1:4) - im_g3;
show_images(im_diff3)
show_image(im_diff3(:,:,3), ['g3-diff-mean']);
%% 
% *Other filters:*
% 
% *Laplacian:*

laplacian = [0 -1 0 ; -1 4 -1; 0 -1 0]
laplacian_diagonal = [-1 -1 -1; -1 8 -1; -1 -1 -1]
laplacian_gaussian = [0 0 -1 0 0; 0 -1 -2 -1 0; -1 -2 16 -2 -1; 0 -1 -2 -1 0; 0 0 -1 0 0]
save("laplacian.mat", "laplacian", "laplacian_diagonal", "laplacian_gaussian");
%%
load("laplacian.mat");
im_lap = task1(shakey_smooth, laplacian, laplacian, -1, 0, 'laplacian-');
%%
show_image(abs(im_lap) >20, 'diff_lap')
%%

img3 = task2(shakey_smooth, laplacian_gaussian, 60) 
%% 
%