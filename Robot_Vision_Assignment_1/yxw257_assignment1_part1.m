%
% yxw257@student.bham.ac.uk
%

clear all;close all;clc; 

k = [-1,-1,-1; -1,8,-1; -1,-1,-1]
im = [
    121,109,125,115,103; 
    155,78,118,112,178; 
    11,6,18,13,16; 
    7,7,22,16,26; 
    3,7,17,18,17]

re = conv2(im, k, "valid")