function re = dogwithscale(im, size_range_w,   mu1, sigma1, file_name, size_range_h)

arguments
    im 
    size_range_w (1, :)
%     size_kernel (1,2) int32 
    mu1 double = 0.0
    sigma1 double = 1.0
    file_name string = ""
    size_range_h = size_range_w
%     ss (1, :) double = [1.6]
end
 
re = [];
if(size(size_range_w) ~= size(size_range_h))
    error("Dimention dosn't match")
    return
end


for ind = 1:size(size_range_w, 2)
%     gf = gaussian_mn([size_range_w(ind), size_range_h(ind)], sigma1, mu1)
    g_dog = dog([size_range_w(ind), size_range_h(ind)],mu1,sigma1);
    im2 = conv2(im, g_dog, "same");
    re = cat(3, re, im2);
%     show_image(im2);
%     title(ind);
end

if strlength(file_name) 
    fig = figure;
    montage(re,"BorderSize", 2, "BackgroundColor",'b', 'Size',[3,NaN]); % , "DisplayRange", [0, 255]"Size", [NaN, 3], 
    exportgraphics(fig, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end

end

