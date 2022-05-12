%% 
% *Question 2.1* 

clear all; close all; clc; 

load("utils/constants.mat");
%%
pretrained_models = ["imagenet-vgg-f", "imagenet-vgg-m", "imagenet-vgg-s", ...
    "imagenet-vgg-verydeep-16", "imagenet-caffe-ref", "imagenet-caffe-alex"];
%% 
% I assume that you have installed all the dependencies needed, including:
% 
% <https://www.vlfeat.org/matconvnet/quick/ https://www.vlfeat.org/matconvnet/quick/> 
% and the pretrained models: ∗ imagenet-vgg-f∗ imagenet-vgg-m∗ imagenet-vgg-s∗ 
% imagenet-vgg-verydeep-16 ∗ imagenet-caffe-ref∗ imagenet-caffe-alex  
% 
% *If not, uncomment these lines to install*

% % Install and compile MatConvNet (needed once).
% untar('https://www.vlfeat.org/matconvnet/download/matconvnet-1.0-beta25.tar.gz') ;
% cd matconvnet-1.0-beta25
% run matlab/vl_compilenn ;
% vl_compilenn
% 
% % Download a pre-trained CNN from the web (needed once). Model downloading
% % takes long time.
% for i = pretrained_models
%     urlwrite("http://www.vlfeat.org/matconvnet/models/"+i+".mat", fullfile(models_dir, i+".mat"));
% end
%%
% Read all the labels in val set
catogories = fetchLabels(val_dir);
%%
% Obtain and preprocess val image. 
% And generate corresponding labels for each image.
ims_val = {};
labels = [];

for label_i=catogories
%     read image in folder
    ims = dir(fullfile(val_dir, label_i, '*.JPEG'));
    
    for i = 1 : length(ims) 
        im = imread(fullfile(ims(i).folder, ims(i).name)); 
        im = single(im);
        if size(im, 3) == 1
            im = cat(3, im, im, im);
        end
        ims_val{end+1} = im; % note: 255 range 
        labels = [labels, label_i];
    end
end
%%

tabledata=[];
bests = [];
for mdl = pretrained_models
    % Setup MatConvNet.
    run vl_setupnn;
    
    % Load a model and upgrade it to MatConvNet current version.
    net = load(fullfile(models_dir, mdl+".mat")) ;
    net = vl_simplenn_tidy(net) ;

    ims_val_re=[];
    label_ind=[];
    for i = 1 : length(ims_val) 
        im = ims_val{i}; 
        ims_val_re = cat(4, ims_val_re, ...
            imresize(im, net.meta.normalization.imageSize(1:2), ...
            net.meta.normalization.interpolation));
        label_ind = [label_ind, find(strcmp(net.meta.classes.name , labels(i)))];
    end

    ims_val_i = ims_val_re - net.meta.normalization.averageImage;

    % Run the CNN.
    res = vl_simplenn(net, ims_val_i);
    % Show the classification result.
    scores = squeeze(gather(res(end).x));
    % The prediction of network 
    [bestScore, best] = max(scores);
    bests = [bests; best];
    % The score for correct category
    score =  diag(scores(label_ind, :));
    
    % averaged loss
    loss_i = cross_entropy_loss(label_ind, best, score);
    % count of correctly classified items / count of all items
    accu_i = sum(best == label_ind) / size(label_ind, 2);
    % for display purpose
    tabledata = [tabledata; mdl, loss_i, accu_i];
end

%%
% sorted loss
loss = sortrows(tabledata, 2);
% worst_category
t= bests == label_ind;
correct_sum=size(t,2);
worst_category = "";
for i = labels
    label_i = find(strcmp(net.meta.classes.name , i));
    s= sum(t(:, find(label_ind==label_i)), "all");
    if correct_sum > s
        correct_sum = s;
        worst_category = i;
    end
end

save(fullfile(data_dir, 'output_2-1.mat'),'loss','worst_category')
%%
% displays
VarNames = {'models', 'losses', 'accuracies'};
T = table(loss(:,1),loss(:,2),loss(:,3), 'VariableNames',VarNames)

worst_category
%% 
% 
% 
%