%
% yxw257@student.bham.ac.uk
%
function [pxy,aois_bm] = rotate_feature(pyramid, grad_thrd, file_name, win_size, minmax)

% Output:  
% pxy       (:, 4)  detected rotation for features, including 
%                   [centre_x, centre_y, angle_vector_x, angle_vector_y]
% aois_bm   (:, 4)  detected scale invariant features bounding box 
%                   [top, bottom, left, right]
% Example input:  [rxy_bm, aois_bm] = rotate_feature(Ipyramids, 150);

arguments % same as scale_feature
    pyramid (:,:,:) % gray scale image arrays; output of function dogwithscale.m
    grad_thrd  = 1  % difference threshold for searching the DoG paramids. 
                    % When 2 adjacent DoG has difference less than `grad_thrd`, 
                    % use this layer of pyramid to do feature search.
    file_name string = ""       % debug purpose, generating image file 
    win_size = 1    % window size for gradient computation 
    minmax (1,2) = [9 , 1000]   % min and max size of features during detection
end

[aois_bm, aoin_bm, ~, grdmag_bm, Px_bm, Py_bm, figs] = scale_feature(pyramid, grad_thrd, "", win_size, minmax);

pxy = []; 

for i=1:aoin_bm
    aoi = aois_bm(i,:);  

    pyy = sum(sum(Py_bm(  aoi(1):aoi(2) ,aoi(3): aoi(4) ))) ;%/ (aoi(3)- aoi(4))/( aoi(1)-aoi(2));
    pxx = sum(sum(Px_bm(  aoi(1):aoi(2) ,aoi(3): aoi(4) )));%/ (aoi(3)- aoi(4))/( aoi(1)-aoi(2));
    pl = sqrt(pxx^2+pyy^2);
    pyy = pyy / pl;
    pxx = pxx / pl;
    pxy=cat(1, pxy, [(aoi(3)+aoi(4))/2, (aoi(1)+aoi(2))/2, pxx, pyy]); 
end

draw_ori(pxy);
if strlength(file_name)
    exportgraphics(figs, fullfile("images/"+file_name+".png"), BackgroundColor="none", Resolution=600);
end

end

