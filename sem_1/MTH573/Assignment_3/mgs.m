function [Q, R] = mgs(A)

    [m, n] = size(A);

    Q = zeros(m, n);
    R = zeros(n, n);

    v = A;

    for i = 1:n
        R(i, i) = norm(v(:, i));
        Q(:, i) = v(:, i) / R(i, i);

        for j = i + 1:n
            R(i, j) = conj(Q(:, i))' * v(:, j);
            v(:, j) = v(:, j) - R(i, j) * Q(:, i);
        end

    end
end
