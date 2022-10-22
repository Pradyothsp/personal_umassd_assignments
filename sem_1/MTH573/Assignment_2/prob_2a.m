e = 10^-10;

A = [1 1; -1 1];
b = [1; 1];

cond_A = cond(A);
inv_A = inv(A);

b_err = [1+e; 1-e];

x = A\b;

x_err = A\b_err;

x_diff = x - x_err;

fprintf("\ncond A: %d", cond_A)
fprintf("\ninv A %d", inv_A)
fprintf("\nX difference: %d\n", x_diff);
