function fig = show_image(im, file_name)
% SHOW_IMAGE Image
arguments
    im
    file_name string = ''
end

fig = figure; % creates a new Figure window; return handler
colormap(gray); 
imagesc(im);

axis image;  % use ratio same as original img
axis off;  % for export

% export image as png file
if strlength(file_name)
    exportgraphics(fig, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end

end
