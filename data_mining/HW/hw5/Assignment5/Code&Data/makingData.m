clc
clear
close all

load('USPS.mat');

data = [];

for i = 1: 10
    ind = find(gnd==i);
    data = [data; fea(ind(1:100),:)];
end

label = 1: 10;
label = repmat(label, [100, 1]);
label = label(:);