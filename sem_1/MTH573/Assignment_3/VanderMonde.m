% function to build a vandermonde matrix for function x to n columns
function A = VanderMonde(x, n)
    x = x(:);
    A = ones(length(x), n);

    for i = 2:n
        A(:, i) = x .* A(:, i - 1);
    end

end
