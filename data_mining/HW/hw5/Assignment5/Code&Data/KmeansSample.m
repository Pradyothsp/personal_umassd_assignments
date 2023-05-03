clc
clear
close all
 
% load dataset
load('USPS_sub.mat');
% normalize row feature
data = NormalizeFea(data, 1);
 
% the ground truth number of clusters is 10
numberOfCluster = 10;
 
% run Kmeans clustering
% MaxIter is the number iterations of Kmeans, and Replicates is the number
% of repeat times of Kmeans with different initialization

tic;
[predictLabel, center] = litekmeans(data, numberOfCluster, 'MaxIter', 100, 'Replicates', 2);
kmeansRunTime = toc;
 
% compute the clustering accuracy
clusteringAcc = accuracy(label, predictLabel);
% compute the clustering NMI
clusteringNMI = nmi(label, predictLabel);
 
fprintf('the clustering accuracy of Kmeans is %f.\n', clusteringAcc/100);
fprintf('the NMI of Kmeans is %f.\n', clusteringNMI);
fprintf('the running time of Kmeans is %f seconds.\n', kmeansRunTime);

