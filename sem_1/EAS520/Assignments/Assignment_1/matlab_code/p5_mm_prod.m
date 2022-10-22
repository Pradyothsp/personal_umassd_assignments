clear all;
n = 1000; 
A = rand(n,n); % Matrix A
B = rand(n,n); % Matrix B

C = zeros(n,n); 
CC = zeros(n,n);


% For-loop
tic
for i = 1:n
    for j=1:n
         for k=1:n
            C(i,j) = C(i,j) + A(i,k)*B(k,j);
         end
    end
end
timeloop = toc;


% Loop Vectorization
tic
for j = 1:n
    CC(:,j) = A*B(:,j);
end
timeloopvec = toc;


% vectorization
tic
    CCC = A*B;
timevec = toc;


fprintf("norm 1: %f", norm(C-CC))
fprintf("\nnorm 2: %f\n", norm(C-CCC))


Speedup = timeloop/timeloopvec;
Speedup2 = timeloop/timevec;
Speedup3 = timeloopvec/timevec;


fprintf("\nSpeedup: %f\n", Speedup);
fprintf("\nSpeedup 2: %f\n", Speedup2);
fprintf("\nSpeedup 3: %f\n", Speedup3);