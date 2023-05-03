clc
clear
close 

% add libsvm to the path
addpath('libsvm-3.11\matlab\');

% instance matrix is n by d where d is number of features
[label_vector, instance_matrix] = libsvmread('Abalone.txt');

% Nomralize features. Make sure the length of each of feature vector is 1
instance_matrix = NormalizeFea(instance_matrix, 1);

num_sample = length(label_vector);

% make training/test split (70/30)
train_data = instance_matrix (1: floor(num_sample*0.7), :);
train_label = label_vector (1: floor(num_sample*0.7));
test_data = instance_matrix (floor(num_sample*0.7)+1:num_sample,:);
test_label = label_vector (floor(num_sample*0.7)+1: num_sample);

% We show how to use logistic regression here: b = ridge(y,D,k);
% y- label
% D- data matrix
% k- lambda value
% k could be a vector including a set of different values
k = [0.001, 0.01, 0.1, 1, 10, 100, 1000];

% each column of B is a weight vector corresponding to a lambda value from
% [0.001, 0.01, 0.1, 1, 10]
B = ridge(train_label,train_data,k);

% Will display 7 different weights side by side. The norm of weight becomes
% small when lambda is larger. This can be identified from the range of
% column vector b in B
bar(B')

% Compute the square difference error
% compute the prediction results
regression_result = test_data * B;

% compute the difference with ground truth
sqr_diff = (regression_result - repmat(test_label, [1, length(k)])).^2;
% take the average
sqr_diff = sum(sqr_diff,1)/length(test_label);



