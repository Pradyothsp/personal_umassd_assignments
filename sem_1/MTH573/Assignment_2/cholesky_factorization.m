function R = cholesky_factorization(A)
n = size(A,1);

R = triu(A);

for k = 1:n
    for i = (k+1):n
        m = R(k,i)/R(k,k);
        R(i,i:n) = R(i,i:n) - m * R(k,i:n);
    end

    R(k,k:n) = R(k,k:n)/sqrt(R(k,k));
end

end
