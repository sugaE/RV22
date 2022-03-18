%
% yxw257@student.bham.ac.uk
%
function re = dogwithscale(im, size_range_w, mu1, sigma1, file_name, size_range_h)
% Returns the paramid of images convolved with Difference of Gaussian
% filters, in the same sequence of `size_range_w`. 
% Example input: dogwithscale(I, [3, 5, 7], 0, 0.8). 
% Will return results of I convolved with size of 3*3, 5*5, 7*7 DoG filters.

arguments
    im (:, :)  % gray scale image input
    size_range_w (1, :) % size and step of G in x-dimention. Eg. 3:2:19
    mu1 double = 0.0 % mean value for Gaussian
    sigma1 double = 1.0 % standard deviation for Gaussian
    file_name string = ""   % debug purpose, generating image file 
    size_range_h = size_range_w % size and step of G in y-dimention. Default is same as size_range_w, gives square filters.
end
 
re = [];
if(size(size_range_w) ~= size(size_range_h))
    error("Dimention dosn't match")
    return
end


for ind = 1:size(size_range_w, 2) 
    g_dog = dog([size_range_w(ind), size_range_h(ind)],mu1,sigma1);
    im2 = conv2(im, g_dog, "same");
    re = cat(3, re, im2);
%     show_image(im2);
%     title(ind);
end
 

if strlength(file_name) 
    fig = figure;
    montage(re,"BorderSize", 2, "BackgroundColor",'b', 'Size',[3,NaN]); % , "DisplayRange", [0, 255]"Size", [NaN, 3], 
%     exportgraphics(fig, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end

end

