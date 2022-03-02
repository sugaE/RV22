clear all;
close all;
%%

fig = figure; % creates a new Figure window; return handler

vis = imread("FishImageFiles/fish-vis.tif");
imshow(vis);
cfp0 = imread("FishImageFiles/fish-cfp-1.tif");
cfp1 = rgb2gray(cfp0);
imshow(cfp1);
%%
histogram(vis);
histogram(cfp1);
his_2 = histogram2(vis,cfp1, Normalization="probability",DisplayStyle="tile");
%%
num_of_cp = 6
% [mp,fp] = cpselect(cfp1,vis,'Wait',true);
% save points
% save("mp_fp_"+num_of_cp+".mat","mp","fp"); 
load("mp_fp_"+num_of_cp+".mat", "fp","mp");
%%

subplot(1,3,1);
imshow(vis);

axis image;  % use ratio same as original img
axis off;  % for export
axis tight;

hold on;
for i=1:length(fp) 
    plot(fp(i,1), fp(i,2), 'x', Color='red'); 
end
hold off;

subplot(1,3,2);
imshow(cfp1);
hold on;
for i=1:length(mp) 
    plot(mp(i,1), mp(i,2), "o", Color='yellow');
end
hold off;


%%
tic;
t = fitgeotrans(mp,fp,'affine');
Rfixed = imref2d(size(vis));
registered_cfp1 = imwarp(cfp0,t,'OutputView',Rfixed);


subplot(1,3,3);
imshowpair(vis,registered_cfp1,'blend');
ttt=toc;

save("mp_fp_"+num_of_cp+".mat","ttt",'-append'); 

hold on;
for i=1:length(fp) 
    plot(fp(i,1), fp(i,2), 'x', Color='red'); 
end 

trans_mp = t.transformPointsForward(mp);
for i=1:length(trans_mp) 
    plot(trans_mp(i,1), trans_mp(i,2), "o", Color='yellow');
end
hold off;

% export image as png file
exportgraphics(fig, fullfile("images/"+"cfp"+num_of_cp+".png"), BackgroundColor="none", Resolution=600);

%%

% histogram(vis);
% histogram(registered_cfp1);
figure;
his_2 = histogram2(vis,registered_cfp1, Normalization="probability");
%%
tic; 
% m="lwm", t = fitgeotrans(mp,fp,m,size(mp,1));
m="polynomial", t = fitgeotrans(mp,fp,m,2);
ms=["affine","nonreflectivesimilarity","projective","pwl","similarity"]

% for m = ms
%     t = fitgeotrans(mp,fp,m);
    
    Rfixed = imref2d(size(vis));
    registered_cfp1 = imwarp(cfp0,t,'OutputView',Rfixed);
    
    fig=figure;
    % subplot(1,3,1);
    imshowpair(vis,registered_cfp1,'blend');
    ttt=toc;
    
    % save("mp_fp_"+num_of_cp+".mat","ttt",'-append'); 
    
    hold on;
    for i=1:length(fp) 
        plot(fp(i,1), fp(i,2), 'x', Color='red'); 
    end 
    
    % trans_mp = t.transformPointsForward(mp);
    % for i=1:length(trans_mp) 
    %     plot(trans_mp(i,1), trans_mp(i,2), "o", Color='yellow');
    % end
    hold off;
    
    % export image as png file
    exportgraphics(fig, fullfile("images/"+"cfp"+num_of_cp+m+".png"), BackgroundColor="none", Resolution=600);
% end