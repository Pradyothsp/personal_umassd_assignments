A = [1 0; 0 1; 1 2];

b = [1 1 1]';

[Q, R] = mgs(A);

RHS = Q.' * b;
x = backward_substitution(R, RHS);

x
