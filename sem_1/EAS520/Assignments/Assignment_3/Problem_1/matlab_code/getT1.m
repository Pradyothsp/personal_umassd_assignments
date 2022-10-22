function t1 = getT1(f, n, x0)

q = zeros(size(x0)); % Preallocate a vector for storing roots.

tic
for i=1:n
    q(i) = fzero(f,x0(i));
end
t1 = toc;

%Processing Outputs%
q = unique(q); % keep roots with unique values only.


end