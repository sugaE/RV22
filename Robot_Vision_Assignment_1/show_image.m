function re = show_image(im, file_name, fig)
% SHOW_IMAGE Image
arguments
    im
    file_name string = ""
    fig = figure
end

% if ~fig
%     fprintf("creating new figure handle")
%     fig = figure; % creates a new Figure window; return handler
t = imagesc(im);
re = t.CData;

colormap("gray"); 
axis image;  % use ratio same as original img
axis off;  % for export

% export image as png file
if strlength(file_name)
%     exportgraphics(fig, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end

end
