function [accumAOI, aoiN, pyramidi, grdmag, Px, Py] = scale_feature(pyramid, grad_thrd, win_size, minmax)

arguments
    pyramid (:,:,:)
    grad_thrd  = 1
    win_size = 1
    minmax (1,2) = [9 , 1000]
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

[Px, Py] = gradient(im2, win_size);
% grdmag = sqrt(Px.^2 + Py.^2-grdx.*Py); 

% [TFx, Px] = islocalmax(im2, 1 );%,"ProminenceWindow",win_pro);
% [TFy, Py] = islocalmax(im2, 2 );%,"ProminenceWindow",win_pro);
grdmag = Px.^2 + Py.^2;

g_7 = gaussian_mn([7,7]);
grdmag = conv2(grdmag, g_7, "same");
 
figure; 
grdmagmask = ( grdmag > grad_thrd);
show_image(grdmagmask);
colormap("default"); 
% 
% data2 = grdmagmask';
% [pks1, locs1, w1, p1] = findpeaks(double(grdmagmask(:)); % peaks along x
% [pks2, locs2, w2, p2] = findpeaks(double(data2(:)); % peaks along y
% 
% data_size = size(data); % Gets matrix dimensions
% [col2, row2] = ind2sub(data_size, locs2); % Converts back to 2D indices
% locs2 = sub2ind(data_size, row2, col2); % Swaps rows and columns and translates back to 1D indices
%  
 

prm_aoiminsize = minmax(1);
prm_aoimax = minmax(2);

[accumlabel, accum_nRgn] = bwlabel( grdmagmask, 8 ); %Label connected components 8-connected
accumAOI = ones(0,4);
% accumAOIsss = accumAOI;
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
%         hold on;
%         rectangle('Position',[aoi(3), aoi(1), aoi(4)- aoi(3) , aoi(2)- aoi(1) ], EdgeColor="green", LineWidth=1);
%         hold off
    end
end

draw_aoi(accumAOI);

aoiN = size(accumAOI, 1);

end
