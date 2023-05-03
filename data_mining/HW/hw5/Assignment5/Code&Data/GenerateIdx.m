function [testIdx, trainIdx] = GenerateIdx(num_per, num_per_class, num_train)
% This function generates random index for training/test splits
% num_per - total number of persons in dataset
% num_per_class - number of samples per class
% num_train - number of training samples per class

n_test = num_per_class - num_train;

idx = randi(num_per_class, num_train, 1);

while(length(unique(idx)) < num_train)
    idx = randi(num_per_class, num_train, 1);
end

for i = 1: num_per
    trainIdx((i-1)* num_train + [1:num_train]) = (i-1)* num_per_class + idx;
end

partIdx = 1: num_per_class;
for i = 1: num_train
    temp_idx = idx(i);
    partIdx(partIdx==temp_idx)=[];
end

for i = 1: num_per
    testIdx((i-1)* n_test + [1:n_test]) = (i-1)* num_per_class + partIdx;
end
end