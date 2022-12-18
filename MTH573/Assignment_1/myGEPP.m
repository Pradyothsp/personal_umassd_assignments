% Gaussian Elimination with partial pivoting

function X=myGEPP(A)
n = size(A,1);

% Elimination
for k = 1:(n-1)
    
    % Partial Pivoting
    for p = (k+1):n
        if (abs(A(k,k)) < abs(A(p,k)))
            A([k p],:) = A([p k],:);
        end
    end
    
    for i = (k+1):n
        mi = A(i,k)/A(k,k);
        A(i,:) = A(i,:) - mi*A(k,:);
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
