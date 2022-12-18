function Q = formQ(V)
    [m, n] = size(V);

    for k = n:-1:1
        I(k:m, k:m);
        I(k:m, k:m) = I(k:m, k:m) - 2 * V(k:m, k) * (V(k:m, k)' * I(k:m, k:m));
    end

    Q = I;
    Q;

end
