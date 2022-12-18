A = [4 1 1 1;1 3 -1 1;1 -1 2 0;1 1 0 2];
b = [0.65;0.05;0;0.5];

R = cholesky_factorization(A);

Y = forward_substitution(R.',b);
X = backward_substitution(R,Y);

disp(X)
