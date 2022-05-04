%% 
% Code is at <https://github.com/sugaE/RV22/blob/main/rv_lab2_2022/yxw258_rv_lab2.m 
% https://github.com/sugaE/RV22/blob/main/rv_lab2_2022/yxw258_rv_lab2.m>

clear all; close all; clc; 
%%
% following instructions from [1] 
DownloadCIFAR10;
%% 
% Question 1.1 Create an appropriate data store from the “cifar10Train” folder 
% containing the four categories bird, horse, ship and truck. These will be your 
% categories used to label the data during training. Each image should be categorized 
% and labelled by the name of the folder it is saved in e.g. all images in folder 
% “horse” should be categorized and labelled as horse. The resulting data store 
% will be your training data set. 

categories = {'bird','horse','ship','truck'};

trainFolder = 'cifar10Train';
imds_train = imageDatastore(fullfile(trainFolder, categories), 'LabelSource','foldernames');
%% 
% Question 1.2 Create an appropriate data store from the “cifar10Test” folder 
% containing the four datasets bird, horse, ship and truck similarly to Question 
% 1. The resulting data store will be your test dataset 

testFolder = 'cifar10Test'
imds_test = imageDatastore(fullfile(testFolder, categories), "LabelSource","foldernames");
%% 
% Question 1.3 Define the layers which will form your CNN. This network will 
% consist of 15 layers2. These layers should be:  		
% 
% 1. Input layer
% 
% 2. 2D convolution layer
% 
% 3. 2D max pooling layer
% 
% 4. ReLU layer
% 
% 5. 2D convolution layer
% 
% 6. ReLU layer
% 
% 7. 2D average pooling layer 
% 
% 8. 2D convolution layer
% 
% 9. ReLU layer  
% 
% 10. 2D average pooling layer 
% 
% 11. 2D convolution layer
% 
% 12. ReLU layer
% 
% 13. Fully connected layer 
% 
% 14. Softmax layer  
% 
% 15. classification layer  
% 
% For the 2D convolution layers 32 filters of size 3 should be applied with 
% padding of 4 and bias learning rate factor of 2, also use this factor for the 
% fully connected layer. For the pooling layers use a pool size of 3 and a stride 
% of 2  

% I don't have gpu access on my labtop; So I didn't use.
% Use of GPU:
% conv1 = convolution2dLayer(5,varSize,'Padding',2,'BiasLearnRateFactor',2);
% conv1.Weights = gpuArray(single(randn([5 5 3 varSize])*0.0001));

layers = [
    imageInputLayer([32, 32, 3]);%1
    convolution2dLayer(3, 32, Padding=4, BiasLearnRateFactor=2);
    maxPooling2dLayer(3,"Stride",2);
    reluLayer();
    convolution2dLayer(3, 32, Padding=4, BiasLearnRateFactor=2);
    reluLayer();%6
    averagePooling2dLayer(3,"Stride",2);
    convolution2dLayer(3, 32, Padding=4, BiasLearnRateFactor=2);
    reluLayer();
    averagePooling2dLayer(3,"Stride",2);
    convolution2dLayer(3, 32, Padding=4, BiasLearnRateFactor=2);%11
    reluLayer();
    fullyConnectedLayer(4,"BiasLearnRateFactor",2);
    softmaxLayer();
    classificationLayer();
]
%% 
% Question 1.4 Define training options for the CNN. There is a large variety 
% of changes you can make to the way the network is trained, to start set the 
% following parameters.  
% 
% 1. Use a stochastic gradient descent with momentum optimizer 
% 
% 2. Set the the maximum number of Epochs to 10
% 
% 3. Set the mini batch size to 100
% 
% 4. Set the initial learning rate to 0.001  
% 
% 5. set the learning rate schedule to piecewise 
% 
% 6. Set the L2 Regularization to 0.004
% 
% 7. Set the learning rate drop period to 8
% 
% 8. Set the learning rate drop factor to 0.1  

opts = trainingOptions('sgdm', ...
    MaxEpochs=10,...
    MiniBatchSize=100,...
    InitialLearnRate=0.001,...
    LearnRateSchedule='piecewise',...
    L2Regularization=0.004,...
    LearnRateDropPeriod=8,...
    LearnRateDropFactor=0.1,...
    Verbose=true, ...           % display training info
    Plots='training-progress')  % display training info
%% 
% Question 1.5 Now that you created the train and test dataset (Q1.1 and Q1.2), 
% defined the CNN architecture (Q1.3) and set the training options (Q1.4) use 
% the trainNetwork MATLAB func- tion3 to train your model using the train dataset. 
% Then run the trained network on the test dataset, which was not used to train 
% the network, to check the accuracy of your model.  

% training
[net, info] = trainNetwork(imds_train, layers, opts);
%%
% testing
labels = classify(net, imds_test);
conf_mat = confusionmat(imds_test.Labels, labels);
conf_mat = conf_mat ./ sum(conf_mat, 2);
mean(diag(conf_mat))
%% 
% Question 1.6 Once you have completed the previous tasks try changing the training 
% options to see how they influence the accuracy of your model. Read more about 
% the available training options here4 Based on your observations, how could the 
% accuracy be improved using different training options? 
% 
% ------
%% 
% # Solver: as discussed here[2], different gradient decent methods perform 
% differently. Even with default settings, *Adam* performs slightly better than 
% SGDM. Because SGDM uses single learning rate, RMSP uses adaptive lr for different 
% parameters, and Adam has added momentum on top of RMSP. On the other hand, RMSP 
% and Adam require more calculation, which results in longer training time, and 
% hyper-parameter tuning than SGDM. 
% # MaxEpochs: number of epochs depend on the size of dataset and accuracy we 
% want to achieve. The accuracy will be improving rapidly during first few epoches 
% then increasing relatively slow and reach plateau. 
% # InitialLearningRate: If the learning rate is too low, then training can 
% take a long time. If the learning rate is too high, then training might reach 
% a suboptimal result or diverge. 
% # LearningRate ( LearnRateSchedule, LearnRateDropPeriod, LearnRateDropFactor 
% ): To actively update lr during training to adapt the issue metioned in 3. We 
% want the lr to be larger at the beginning for faster training and be smaller 
% later to reach minimal point and not overshooting.
% # Hyper parameters tuning can be a difficult and long process during model 
% training.
% # Optimising the network, i.e. choosing a suitable network for the task can 
% also boost the accuracy.
% # Having high quality trainining data can be a huge advantage when training 
% network. If not enough data are collected, doing data augmentation can alleviate 
% the problem. 

% using adam
opts = trainingOptions('adam', ...
    MaxEpochs=10,...
    MiniBatchSize=100,...
    InitialLearnRate=0.001,...
    LearnRateSchedule='piecewise',...
    L2Regularization=0.004,...
    LearnRateDropPeriod=8,...
    LearnRateDropFactor=0.1,...
    Verbose=true, ...           % display training info
    Plots='training-progress')  % display training info

% training
[net, info] = trainNetwork(imds_train, layers, opts);
% testing
labels = classify(net, imds_test);
conf_mat = confusionmat(imds_test.Labels, labels);
conf_mat = conf_mat ./ sum(conf_mat, 2);
mean(diag(conf_mat))
%% 
% 
% 
% REFERENCE:
% 
% [1] <https://uk.mathworks.com/matlabcentral/fileexchange/62990-deep-learning-tutorial-series 
% https://uk.mathworks.com/matlabcentral/fileexchange/62990-deep-learning-tutorial-series>
% 
% [2] <https://uk.mathworks.com/help/deeplearning/ref/trainingoptions.html#bu80qkw-3_head 
% https://uk.mathworks.com/help/deeplearning/ref/trainingoptions.html#bu80qkw-3_head>
% 
% 
% 
%