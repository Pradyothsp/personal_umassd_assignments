% Generating Matrix A and vector b
n=100;
v = (ones(n,1))*5;
A = diag(v);

A = A + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);

b = zeros(100,1);
b(50,1) = 1;

A = [A, b];

% Calling function
X=myGE(A);

% Plot
plot(X,'.')
xlabel('j')
ylabel('Xn')