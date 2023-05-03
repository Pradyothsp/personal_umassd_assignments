function [eigvector,eigvalue] = myPCA(X, d)
% *X* is a D by n data matrix where *D* is the dimension of the original
% feature space, and n is the number of samples. 
% *d* is the intended number of eigenvectors and dimension of the new
% feature space
% *eigvector* and *eigvalue* are the results of eigen-decomposition of the 
% objective function of PCA

eigvector = [];
eigvalue = [];

%% Centralize X by substracting the mean vector from each sample

meanX = mean(X, 2);
        
%% Compute the covariance matrix of X after centralization

C = [];

%% Compute eigen-decomposition of covariance matrix and return the first *d* 
%% eigvectors and eigenvalues

[eigvector,eigvalue] = eig (C);

eigvector = fliplr(eigvector);
eigvector = eigvector(:, 1:d);

end