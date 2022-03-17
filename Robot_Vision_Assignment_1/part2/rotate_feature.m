function [pxy,aois_bm] = rotate_feature(pyramid, grad_thrd, win_size, minmax)

arguments
    pyramid (:,:,:)
    grad_thrd  = 1
    win_size = 1
    minmax (1,2) = [9 , 1000]
end

[aois_bm, aoin_bm, ~, grdmag_bm, Px_bm, Py_bm] = scale_feature(pyramid, grad_thrd);
% ttt = atan2(Py_bm, Px_bm);

pxy = []; 

for i=1:aoin_bm
    aoi = aois_bm(i,:);  

    pyy = sum(sum(Py_bm(  aoi(1):aoi(2) ,aoi(3): aoi(4) ))) ;%/ (aoi(3)- aoi(4))/( aoi(1)-aoi(2));
    pxx = sum(sum(Px_bm(  aoi(1):aoi(2) ,aoi(3): aoi(4) )));%/ (aoi(3)- aoi(4))/( aoi(1)-aoi(2));
    pl = sqrt(pxx^2+pyy^2);
    pyy = pyy / pl;
    pxx = pxx / pl;
    pxy=cat(1, pxy, [(aoi(3)+aoi(4))/2, (aoi(1)+aoi(2))/2, pxx, pyy]);

%     quiver((aoi(3)+aoi(4))/2,(aoi(1)+aoi(2))/2, pyy,pxx,30,"Color",'g','ShowArrowHead','on','MaxHeadSize',10)
end

draw_ori(pxy);

end

