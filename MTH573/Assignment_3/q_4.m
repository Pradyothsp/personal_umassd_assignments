format long

t = linspace(0, 1, 50);

% build the vandermonde A matrix with 10 columns
A = VanderMonde(cos(4*t), 10);

b = zeros(50, 1);
x = zeros(10, 1);

% build the vector b
for i = 1:50
    b(i) = cos(4 * t(i));
end

% (a) Formation and solution of the normal equations, using MATLAB s \
Ac = A' * A;
bc = A' * b;
L = chol(Ac, "lower");
y = L \ bc;
xa = L' \ y;

xa

% (b) QR factorization computed by mgs
[Q, R] = mgs(A);
xb = (lsp(b, Q, R))';

xb

% (c) QR factorization computed by house
[V, R] = house(A);
Q = formQ(V);
bh = Q' * b;
xc = R \ bh;

xc

% (d) x = A\b in MATLAB
xd = R \ (Q' * b);

xd
