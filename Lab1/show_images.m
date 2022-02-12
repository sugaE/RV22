function show_images(multi)
% SHOW_IMAGE Image

figure; 
colormap(gray); 
montage(multi, Size=[1 nan], BorderSize=[5 5], BackgroundColor='w')
% title('sfag')

end
