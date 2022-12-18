function [V, R] = house(A)

    [m, n] = size(A);
    V = zeros(m, n);

    for k = 1:n
        x = A(k:m, k);
        e = [1; zeros(length(x) - 1, 1)];

        if x(1) ~= 0
            S = sign(x(1));
        else
            S = 1;
        end

        v = S * norm(x) * e + x;
        v = v / norm(v);
        A(k:m, k:n) = A(k:m, k:n) - 2 * v * (v' * A(k:m, k:n));
        V(k:m, k) = v;

    end

    R = A;
end
