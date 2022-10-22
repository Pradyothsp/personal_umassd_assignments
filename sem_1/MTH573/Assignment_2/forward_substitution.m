function Y = forward_substitution(R,b)
n=size(R,1);

Y(1) = b(1)/R(1,1);

for i=2:n
    sum = 0;
    for j=1:i-1
        sum = sum + R(i,j)*Y(j);
    end
    Y(i) = (b(i)-sum)/R(i,i);
end
