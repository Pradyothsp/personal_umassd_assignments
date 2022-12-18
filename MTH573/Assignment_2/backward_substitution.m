function X = backward_substitution(R,b)
n = size(R,1);

X = zeros(1,n);

X(n) = b(n)/R(n,n);


for i = n-1:-1:1
    sum_ = 0;

    for j=i+1:n
        sum_ = sum_ + R(i,j)*X(j);
    end

    X(i) = (b(i) - sum_)/R(i,i);

end
