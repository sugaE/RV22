function draw_ori(pxy, aois_bm,c)

arguments
    pxy (:,4)
    aois_bm (:,4) = zeros(0,4)
    c = 'g'
end
 
if size(aois_bm, 1) > 0
    draw_aoi(aois_bm);
end

hold on
for i=1:size(pxy, 1)
    pi = pxy(i, :);
    quiver(pi(1),pi(2), pi(3),pi(4),30,"Color",c,'ShowArrowHead','on','MaxHeadSize',20, LineWidth=1.5)
end
hold off
end