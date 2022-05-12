%% 
% *Question 2.4*

clear all; close all; clc; 

load("utils/constants.mat");
%% 
% *Question 2.4.1*

oldpath = addpath(data_dir);

filenameImagesTrain = "train-images-idx3-ubyte.gz";
filenameLabelsTrain = "train-labels-idx1-ubyte.gz";
filenameImagesTest = "t10k-images-idx3-ubyte.gz";
filenameLabelsTest = "t10k-labels-idx1-ubyte.gz";
%% 
% If data/ folder is empty, uncomment this.

% % Downloading data
% for i = [filenameImagesTrain, filenameLabelsTrain, filenameImagesTest, filenameLabelsTest]
% urlwrite("http://yann.lecun.com/exdb/mnist/" + i, fullfile(data_dir, i));
% end

XTrain = processImagesMNIST(filenameImagesTrain);
YTrain = processLabelsMNIST(filenameLabelsTrain);
XTest = processImagesMNIST(filenameImagesTest);
YTest = processLabelsMNIST(filenameLabelsTest);
%%
% define
totaln = 30;
test_percetage = 0.2;
% generate random indexes
ind_train = randi([1, size(YTrain,1)], 1, totaln * (1-test_percetage));
ind_test = randi([1, size(YTest,1)], 1, totaln * test_percetage);
%%
% retrieve data of indexes
y_train = YTrain(ind_train);
x_train = XTrain(:,:,:,ind_train); 
y_test = YTest(ind_test);
x_test = XTest(:,:,:,ind_test);
%%
% display images
fig = figure;
w = 5;
h = 6; 
sz_train = size(x_train, 4);
for i=1:sz_train
    subplot(w,h,i);
    im = x_train(:,:,:,i);
    imshow(im);
end
for i=1:size(x_test, 4)
    subplot(w,h,i+sz_train);
    im = x_test(:,:,:,i);
    imshow(im);
end
%%
save_image(fig, "output_2-4-1.png", data_dir);
%%

% count categories. The labels values are 0 to 9.
ct_category = [];
label_all = cat(1, y_train, y_test);
for i=0:9  
    ct_category(i+1) = size(find(label_all == categorical(i)), 1);
end
ct_category
%% 
% *Question 2.4.2*

% seperate validation data
ind_val = randperm(size(XTrain,4), size(XTrain,4) * test_percetage);
XVal = XTrain(:,:,:,ind_val);
XTrain(:,:,:,ind_val) = [];
YVal = YTrain(ind_val);
YTrain(ind_val) = [];
%%

% Augment the training data
aug = imageDataAugmenter("RandRotation", [-30, 20],...
    "RandYReflection", 1, ...
    "RandXReflection", 1, ...
    "RandXTranslation", [-2, 4], ...
    "RandYTranslation", [-3, 2]);

imsz = size(x_train, 1:2);
auimds = augmentedImageDatastore(imsz,XTrain,YTrain,'DataAugmentation',aug);
minibatch = preview(auimds);
fig = figure;
imshow(imtile(minibatch.input));
save_image(fig, "output_2-4-2.png", data_dir);
%% 
% *Question 2.4.3*
% 
% Implement the network architecture shown in Figure 6. The input image size 
% is 28*28, pool size and stride are 2. Use Adam optimizer, lr = 0.02, validation 
% frequency 50, validation patience 20, and shuffle the training data before each 
% training epoch (train the network for 35 epochs). Plot the training progress 
% and include it into your written report. Save the model and submit it with your 
% report. What is the validation accuracy of your model? 	

% define network
conv2 = convolution2dLayer(3, 28, "Padding", 1);
pool2 = maxPooling2dLayer(2, "Stride", 2);
layers = [
%     input
    imageInputLayer(imsz);
%     1
    conv2;
    batchNormalizationLayer();
    reluLayer();
    pool2;
%     2
    conv2;
    batchNormalizationLayer();
    reluLayer();
    pool2;
%     3
    conv2;
    batchNormalizationLayer();
    reluLayer();
    pool2;
%     4
    conv2;
    batchNormalizationLayer();
    reluLayer();
%     output
    fullyConnectedLayer(10); % 10 categories
    softmaxLayer();
    classificationLayer();
    ]


% trainingOptions
opts = trainingOptions("adam",...
    InitialLearnRate=0.02,...
    ValidationFrequency=50,...
    ValidationPatience=20,...
    ValidationData={XVal, YVal},...
    Shuffle="every-epoch", ...
    MaxEpochs=10, ... % todo 35
    Verbose=true, ...
    Plots="training-progress")
%%
% training
[net, info] = trainNetwork(auimds, layers, opts);
val_accu = info.FinalValidationAccuracy
save(fullfile(data_dir, "output_2-4-3.mat"), "net");
%%
% testing on test data
labels = classify(net, XTest);
conf_mat = confusionmat(YTest, labels);
conf_mat = conf_mat ./ sum(conf_mat, 2);
test_accu_1 = mean(diag(conf_mat))
%% 
% *Question 2.4.4*

% read handwriting data
hw_dir="handwritings";
paths_hw = dir(fullfile(data_dir, hw_dir, "*.png"));
x_hw = [];
y_hw = [];
fig = figure;
for i=1:length(paths_hw)
    pth = paths_hw(i).name;
    lbl = regexp(pth, "\d", "match");
    subplot(5,6,i);
    im = imread(fullfile(paths_hw(i).folder, pth)); 
    im = rescale(rgb2gray(im));
    imshow(im);
    x_hw = cat(4, x_hw, [im]);
    y_hw = [y_hw, categorical(lbl(2))];
end
save_image(fig, "output_2-4-4-hw.png", data_dir);
%%
% testing on handwriting data
labels = classify(net, x_hw)
conf_mat = confusionmat(y_hw, labels);
test_accu_hw = diag(conf_mat) / 3;
%%
% anaylse network
analyzeNetwork(net)
%% 
% [reference]
% 
% <http://yann.lecun.com/exdb/mnist/ http://yann.lecun.com/exdb/mnist/> section: 
% FILE FORMATS FOR THE MNIST DATABASE