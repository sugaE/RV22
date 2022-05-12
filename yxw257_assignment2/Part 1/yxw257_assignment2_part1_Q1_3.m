%% 
% *Question 1.3*

clear all; close all; clc; 
%% 
% Use SURF features to align B.jpg and C.jpg images to A.jpg. Find matching 
% features and estimate the transformation between the images. Apply the calculated 
% transformation on the images to generate the recovered images (expected results 
% are shown below). Save and submit the recovered images

IA = rgb2gray(imread("Q_1_3/A.jpg"));
points_a = detectSURFFeatures(IA);
[feat_a, vp_a] = extractFeatures(IA, points_a);

pairs = ["B", "C"];

for i=pairs
    IB = rgb2gray(imread("Q_1_3/"+i+".jpg"));
    points_b = detectSURFFeatures(IB);
    [feat_b, vp_b] = extractFeatures(IB, points_b);
    
    index_pairs = matchFeatures(feat_a, feat_b,"MatchThreshold",15,'MaxRatio',1,'Unique',true);
    matched_a = vp_a(index_pairs(:,1));
    matched_b = vp_b(index_pairs(:,2));
    
    tform = estimateGeometricTransform2D(matched_b,matched_a,"similarity");
    
    outputView = imref2d(size(IA));
    Ir = imwarp(IB,tform,'OutputView',outputView);

    I = montage([IA, Ir]);
    fig = figure ;
    imshow(I.CData);
    title("A<-"+i);

    % export image as png file
    exportgraphics(fig, "yxw257_assignment2_part1_A"+i+".png", ...
        BackgroundColor="none", Resolution=600);
end