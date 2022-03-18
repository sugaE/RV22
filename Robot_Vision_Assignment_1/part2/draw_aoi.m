function draw_aoi(aois_bm)

hold on
for k = 1 : size(aois_bm, 1),
    aoi = aois_bm(k,:);    % just for referencing convenience
    rectangle('Position',[aoi(3), aoi(1), aoi(4)- aoi(3) , aoi(2)- aoi(1) ], EdgeColor="red", LineWidth=1.5);
end
hold off

end

