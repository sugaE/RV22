%
% yxw257@student.bham.ac.uk
%
function [accumAOI, aoiN, pyramidi, grdmag, Px, Py, figs] = scale_feature(pyramid, grad_thrd, file_name, win_size, minmax) 
% Output:  
% accumAOI   (:, 4)  detected scale invariant features
% aoiN       number  number of accumAOI
% pyramidi   number  index of `pyramid` used for feature detection
% grad_thrd (:, :)  gradient map
% Px        (:, :)  gradient map of axis X
% Py        (:, :)  gradient map of axis Y
% figs              debug purpose, generating image file 
% Example input: scale_feature(I, 150)
 
arguments
    pyramid (:,:,:) % gray scale image arrays; output of function dogwithscale.m
    grad_thrd  = 1  % difference threshold for searching the DoG paramids. 
                    % When 2 adjacent DoG has difference less than `grad_thrd`, 
                    % use this layer of pyramid to do feature search.
    file_name string = ""       % debug purpose, generating image file 
    win_size = 1    % window size for gradient computation 
    minmax (1,2) = [9 , 1000]   % min and max size of features during detection
end
 


% search 
pyramidi = 0;
for i=1:(size(pyramid, 3)-1)
    diff_i = sum(abs(pyramid(:,:,i) - pyramid(:,:,i+1)), "all");
    if diff_i < 1  
        pyramidi = i;
        break
    end
end

if pyramidi == 0
    error("pyramid gaussian not working :( ")
    return;
end

im2 = pyramid(:,:,pyramidi);

% gradient map
[Px, Py] = gradient(im2, win_size);
% grdmag = sqrt(Px.^2 + Py.^2-grdx.*Py); 

% [TFx, Px] = islocalmax(im2, 1 );%,"ProminenceWindow",win_pro);
% [TFy, Py] = islocalmax(im2, 2 );%,"ProminenceWindow",win_pro);
grdmag = Px.^2 + Py.^2;

g_7 = gaussian_mn([7,7]);
grdmag = conv2(grdmag, g_7, "same");
 
figs = figure; 
grdmagmask = ( grdmag > grad_thrd);
show_image(grdmagmask, "", figs);
colormap("default");  
 

% area of interest
prm_aoiminsize = minmax(1);
prm_aoimax = minmax(2);

[accumlabel, accum_nRgn] = bwlabel( grdmagmask, 8 ); %Label connected components 8-connected
accumAOI = ones(0,4); 
for k = 1 : accum_nRgn,
    accumrgn_lin = find( accumlabel ==k );
    [accumrgn_IdxI, accumrgn_IdxJ] = ...
        ind2sub( size(accumlabel), accumrgn_lin );
    rgn_top = min( accumrgn_IdxI );
    rgn_bottom = max( accumrgn_IdxI );
    rgn_left = min( accumrgn_IdxJ );
    rgn_right = max( accumrgn_IdxJ );        
    % The AOIs selected must satisfy a minimum size
    if ( (rgn_right - rgn_left + 1) >= prm_aoiminsize && ...
            (rgn_bottom - rgn_top + 1) >= prm_aoiminsize &&...
        (rgn_right - rgn_left + 1) <= prm_aoimax && ...
            (rgn_bottom - rgn_top + 1) <= prm_aoimax )
       
        aoi = [rgn_top, rgn_bottom, rgn_left, rgn_right ];    % just for referencing convenience
        accumAOI = [ accumAOI;  aoi ]; 
    end
end

draw_aoi(accumAOI); 

if strlength(file_name)
%     exportgraphics(figs, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end


aoiN = size(accumAOI, 1);

end

