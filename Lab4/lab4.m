clear all;
close all;
%% 
% *Q1*

fig = figure; % creates a new Figure window; return handler

vis = imread("FishImageFiles/fish-vis.tif");
imshow(vis);
cfp0 = imread("FishImageFiles/fish-cfp-1.tif");
cfp1 = rgb2gray(cfp0);
imshow(cfp1);
%%
num_of_cp = 6
% control points
[mp,fp] = cpselect(cfp1,vis,'Wait',true);
% save points
save("mp_fp_"+num_of_cp+".mat","mp","fp");
% load("mp_fp_"+num_of_cp+".mat", "fp","mp");
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
registered_cfp = imwarp(cfp1,t,'OutputView',Rfixed);


subplot(1,3,3);
imshowpair(vis,registered_cfp,'blend');
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
% exportgraphics(fig, fullfile("images/"+"cfp"+num_of_cp+".png"), BackgroundColor="none", Resolution=600);
%% 
% *Q2*

% function mutual_info
%% 
% *Q3*


% m="lwm", t = fitgeotrans(mp,fp,m,size(mp,1));
% m="polynomial", t = fitgeotrans(mp,fp,m,2);

ms=["0","none", "affine","nonreflectivesimilarity","projective","pwl","similarity"]

for m = ms 
    if m == "none"
        registered_cfp = cfp1;
    elseif m == "0"
        registered_cfp = vis;
    else
        t = fitgeotrans(mp,fp,m);
        Rfixed = imref2d(size(vis));
        registered_cfp = imwarp(cfp1, t, 'OutputView',Rfixed);
    end

    mi_registered_cfp = mutual_info(vis, registered_cfp)
    
    fig=figure;
    imshowpair(vis,registered_cfp,'blend'); 
    
    hold on;
    for i=1:length(fp)
        plot(fp(i,1), fp(i,2), 'x', Color='red');
    end

    hold off;

% export image as png file
% exportgraphics(fig, fullfile("figures/"+"cfp"+num_of_cp+m+".png"), BackgroundColor="none", Resolution=600);
end