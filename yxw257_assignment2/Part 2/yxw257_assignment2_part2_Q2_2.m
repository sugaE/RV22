%% 
% *Question 2.2*

clear all; close all; clc; 

load("utils/constants.mat");
%%
mdl = "imagenet-vgg-f";
%%
% Setup MatConvNet.
run vl_setupnn;

% Load a model and upgrade it to MatConvNet current version.
net = load(fullfile(models_dir, mdl+".mat"));
net = vl_simplenn_tidy(net) ;

% modify net 

net.layers{20} = struct('type', 'dropout', ...
                         'name', 'dropout7', ...
                         'rate', 0.5);

f=1/100 ;
net.layers{21} = struct('type', 'conv',...
                        'name', 'fc8',...
                        'weights', {{f*randn(1,1,4096,10, 'single'), zeros(1,10,'single')}}, ...
                        'stride', 1, ...
                        'pad', 0);

net.layers{22} = struct('type', 'softmaxloss');

 
opts.backPropDepth = 6; % net.layders{16}
net.meta.trainOpts.numEpochs = 10;
%%
% debug log
% for i=1:22
%     i
%     net.layers{i}
% end
%%
opts.expDir = fullfile(data_dir, "imagenet-q2-2");
imdbPath = fullfile(opts.expDir, 'imdb.mat');

if exist(imdbPath, 'file')
  imdb = load(imdbPath);
else
  % defined in utils
  imdb = getImagenetImdb(net);
  mkdir(opts.expDir) ;
  save(imdbPath, '-struct', 'imdb') ;
end
%%
% Run the CNN.
[net, info] = cnn_train(net, ...
    imdb, ...
    @getBatch, ...
    net.meta.trainOpts, ...
    opts,...
    'val', find(imdb.images.set == 2)) ;
%%

save(fullfile(data_dir, "output_2-2.mat"),  "-struct", "net");
%%
fig = figure(3) ;
vl_tshow(net.layers{1}.weights{1}) ; 
title('Conv1 filters') ;
% export image as png file
exportgraphics(fig, fullfile(data_dir, "output_2-2-2.png"), BackgroundColor="none", Resolution=600);