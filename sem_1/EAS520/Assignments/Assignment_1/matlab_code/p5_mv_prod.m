clear all;

n = 100; 

A = rand(n,n); % Matrix
x = rand(n,1); % vector

b = zeros(n,1); 
bb = zeros(n,1);

% For-loop
tic
for i = 1:n
    for j=1:n
    b(i) = b(i) + A(i,j)*x(j);
    end
end
timeloop = toc;

% Loop Vectorization
tic
for i = 1:n
    bb(i) = A(i,:)*x;
end
timeloopvec = toc;

% vectorization
tic
    bbb = A*x;
timevec = toc;

fprintf("norm 1: %f", norm(b-bb))
fprintf("\nnorm 2: %f\n", norm(b-bbb))

Speedup = timeloop/timeloopvec;
Speedup2 = timeloop/timevec;
Speedup3 = timeloopvec/timevec;

fprintf("\nSpeedup: %f\n", Speedup);
fprintf("\nSpeedup 2: %f\n", Speedup2);
fprintf("\nSpeedup 3: %f\n", Speedup3);
