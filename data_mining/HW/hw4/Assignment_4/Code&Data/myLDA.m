function [eigvector,eigvalue] = myLDA(X, L, d1, d2)
% *X* is a D by n data matrix where *D* is the dimension of the original
% feature space, and n is the number of samples.
% *L* is a n by 1 label vector
% *d1* is the dimensionality of data after PCA
% *d2* is the intended number of eigenvectors to return  
% *eigvector* and *eigvalue* are the results of eigen-decomposition of the 
% objective function of LDA

eigvector = [];
eigvalue = [];
Sw = [];
Sb = [];

%% First use PCA to reduce the dimensionlity of the feature to d1-space


%% Compute within-class scatter matrix Sw

        
%% Compute within-class scatter matrix Sb


%% Compute the eigen-decomposition of following problem and return *d2* 
%% eigvectors and eigenvalues

[eigvector,eigvalue] = eig (Sw^(-1) * Sb);

end