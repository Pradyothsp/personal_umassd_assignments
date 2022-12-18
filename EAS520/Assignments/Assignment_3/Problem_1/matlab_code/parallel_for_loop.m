clear all; close all;

p = feature('numcores');

% Create a parallel pool if none exists
if isempty(gcp())
    parpool();
end


% Inputs
f = @(x) sin(3*pi*cos(2*pi*x).*sin(pi*x));
a = -3;
b = 5;
n = 4^9;

x0 = linspace(a,b,n);   % Vector containing initial starting points
q = zeros(size(x0));    % Preallocate a vector for storing roots.


% Parallel Processing
tic
parfor i=1:n
    q(i) = fzero(f,x0(i));
end
tp = toc;


% Processing Outputs
q = unique(q); % keep roots with unique values only.


% Calling function to find 'T1'
t1 = getT1(f, n, x0);


speedup = t1/tp;
efficiency = (speedup/p) * 100;

fprintf("\nfor n: %d, speedup is %f and efficiency is %f\n", n, speedup, efficiency)
