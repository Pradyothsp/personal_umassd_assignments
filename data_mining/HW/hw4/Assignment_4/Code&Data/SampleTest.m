clc
clear
close

% each row is a sample
load('PIE.mat');

% number of training data per person
numTrain = 15;

trainInd = [];
testInd = [];

% generate train/test index by select first n samples from the dataset as
% training data
for i = 1: n_per
        trainInd = [trainInd, (i-1)*n_sub+1: (i-1)*n_sub+numTrain];
        testInd = [testInd, (i-1)*n_sub+numTrain+1: i*n_sub];
end

%generate training and testing data
trainFea = Data(trainInd,:);
trainLabel = Label(trainInd,:);
testFea = Data(testInd,:);
testLabel = Label(testInd,:);

%% Please uncomment this part if run PCA
%% pca using existing codes
tic;
options=[];
options.ReducedDim=100;
[eigvector,eigvalue] = PCA(trainFea,options);
pcaTime = toc;
pcaTestFea = testFea*eigvector;
pcaTrainFea = trainFea*eigvector;

%% call nearest neighbor classifier of matlab
Mdl = fitcknn(pcaTrainFea, trainLabel);
predictLabel = predict(Mdl,pcaTestFea);


acc = sum(predictLabel == testLabel)/length(testLabel);

fprintf('the reconition accuracy with pca is %f.\n', acc);
fprintf('the running time is %f.\n', pcaTime);

%% Please uncomment this part if run LDA
%% lda using exising codes
% tic;
% options = [];
% options.Fisherface = 1;
% [eigvector, eigvalue] = LDA(trainLabel, options, trainFea);
% ldaTrainFea = trainFea*eigvector;
% ldaTestFea = testFea*eigvector;
% ldaTime = toc;
%% call nearest neighbor classifier of matlab
% Mdl = fitcknn(ldaTrainFea, trainLabel);
% predictLabel = predict(Mdl,ldaTestFea);
% 
% acc = sum(predictLabel == testLabel)/length(testLabel);
% 
% fprintf('the reconition accuracy with lda is %f.\n', acc);
% fprintf('the running time is %f.\n', ldaTime);




