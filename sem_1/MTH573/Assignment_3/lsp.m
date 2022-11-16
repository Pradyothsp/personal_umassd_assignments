function x = lsp(b, Q, R)
    % solving for x using least squares
    [temp] = Q' * b;
    x = zeros(size(temp, 1), 1);
    x = inv(R) * temp;
end
