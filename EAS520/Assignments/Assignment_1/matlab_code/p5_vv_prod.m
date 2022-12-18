clear all;

n = 10000; % Length of the vectors
a = rand(n,1); % Create a random column vector a
b = rand(n,1); % Create a random column vector b

c = 0;

% Dot product with for-loop
tic
for i = 1:n
    c = c + a(i)*b(i);
end
timeloop = toc;
c;

% Dot product with vectorization
tic
    cc = a.'*b;
timevec = toc;
cc;

% Compare the results
fprintf("norm: %f",norm(c-cc))

% Measure the speed-up
Speedup = timeloop/timevec;

fprintf("\nSpeedup: %f\n", Speedup);