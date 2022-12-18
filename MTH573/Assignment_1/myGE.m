% Gaussian Elimination without pivoting

function X=myGE(A)
n=size(A,1);

% Elimination
for k = 1:(n-1)
    for i = (k+1):n
        m = A(i,k)/A(k,k);
        A(i,:) = A(i,:) - m*A(k,:);
    end
end

% Backward Substitution
X = zeros(1,n);

X(n) = A(n,n+1)/A(n,n);

for i = n-1:-1:1
    sum_ = 0;
    for j=i+1:n
        sum_ = sum_ + A(i,j)*X(j);
    end
    X(i) = (A(i,n+1) - sum_)/A(i,i);
end
