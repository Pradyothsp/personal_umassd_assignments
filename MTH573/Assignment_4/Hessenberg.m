function H = Hessenberg(A)
    [m, ~] = size(A);

    for k = 1:m - 2
        x = A(k + 1:m, k);
        e = zeros(size(x));
        e(1) = 1;

        if sign(x(1)) == 0
            v = norm(x) * e + x;
        else
            v = sign(x(1)) * norm(x) * e + x;
        end

        v = v / norm(v);

        A(k + 1:m, k:m) = A(k + 1:m, k:m) - 2 * v * (v.' * A(k + 1:m, k:m));

        A(1:m, k + 1:m) = A(1:m, k + 1:m) - 2 * (A(1:m, k + 1:m) * v) * v.';
    end

    H = A

end
