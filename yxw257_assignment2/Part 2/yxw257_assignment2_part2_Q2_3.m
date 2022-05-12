%% 
% *Question 2.3*

clear all; close all; clc; 

load("utils/constants.mat");
%% 
% I assume that you have installed all the dependencies needed, including:
% 
% <https://www.vlfeat.org/matconvnet/quick/ https://www.vlfeat.org/matconvnet/quick/> 
% and the pretrained models: ∗ imagenet-vgg-f∗ imagenet-vgg-m∗ imagenet-vgg-s∗ 
% imagenet-vgg-verydeep-16 ∗ imagenet-caffe-ref∗ imagenet-caffe-alex  
% 
% *If not, uncomment these lines to install*

% Setup MatConvNet.
run vl_setupnn;

% Load a model and upgrade it to MatConvNet current version.
net = load(fullfile(data_dir, "output_2-2.mat")) ;
net = vl_simplenn_tidy(net) ;
net.layers{22}.type = 'softmax'
net.layers = {net.layers{1:19}, net.layers{21:end}}

% load data
imdb = load(fullfile(data_dir,"imagenet-q2-2/", "imdb.mat")) ;

%%
% % log
% for i=1:21
%     i
%     net.layers{i}
% end
%%

val_ind = find(imdb.images.set==2);
label_val = imdb.images.labels(val_ind);
% Run the CNN.
res = vl_simplenn(net, imdb.images.data(:,:,:,val_ind));
% Show the classification result.
scores = squeeze(gather(res(end).x));
% The prediction of network 
[bestScore, best] = max(scores);
% The score for correct category
score =  diag(scores(label_val, :)); 

% averaged loss
loss = cross_entropy_loss(label_val, best, score)
% count of correctly classified items / count of all items
accuracy = sum(best == label_val) / size(label_val, 2)


save(fullfile(data_dir, 'output_2-3.mat'),'loss','accuracy')