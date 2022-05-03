clear all; close all; clc; 			
%% 
% Question 1.1 Create an appropriate data store from the “cifar10Train” folder 
% containing the four categories bird, horse, ship and truck. These will be your 
% categories used to label the data during training. Each image should be categorized 
% and labelled by the name of the folder it is saved in e.g. all images in folder 
% “horse” should be categorized and labelled as horse. The resulting data store 
% will be your training data set. 

% 
%% 
% Question 1.2 Create an appropriate data store from the “cifar10Test” folder 
% containing the four datasets bird, horse, ship and truck similarly to Question 
% 1. The resulting data store will be your test dataset 

% 
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
% 7. 2D average pooling layer 8. 2D convolution layer
% 
% 9. ReLU layer  
% 
% 10. 2D average pooling layer 11. 2D convolution layer
% 
% 12. ReLU layer
% 
% 13. Fully connected layer 14. Softmax layer  
% 
% 15. classification layer  
% 
% For the 2D convolution layers 32 filters of size 3 should be applied with 
% padding of 4 and bias learning rate factor of 2, also use this factor for the 
% fully connected layer. For the pooling layers use a pool size of 3 and a stride 
% of 2  

% 
%% 
% Question 1.4 Define training options for the CNN. There is a large variety 
% of changes you can make to the way the network is trained, to start set the 
% following parameters.  
% 
% 1. Use a stochastic gradient descent with momentum optimizer 2. Set the the 
% maximum number of Epochs to 10
% 
% 3. Set the mini batch size to 100
% 
% 4. Set the initial learning rate to 0.001  
% 
% 5. set the learning rate schedule to piecewise 6. Set the L2 Regularization 
% to 0.004
% 
% 7. Set the learning rate drop period to 8
% 
% 8. Set the learning rate drop factor to 0.1  

% 
%% 
% Question 1.5 Now that you created the train and test dataset (Q1.1 and Q1.2), 
% defined the CNN architecture (Q1.3) and set the training options (Q1.4) use 
% the trainNetwork MATLAB func- tion3 to train your model using the train dataset. 
% Then run the trained network on the test dataset, which was not used to train 
% the network, to check the accuracy of your model.  

% 
%% 
% Question 1.6 Once you have completed the previous tasks try changing the training 
% options to see how they influence the accuracy of your model. Read more about 
% the available training options here4 Based on your observations, how could the 
% accuracy be improved using different training options? 

%