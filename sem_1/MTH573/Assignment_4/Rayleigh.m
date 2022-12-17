function lambda = Rayleigh(A,v0,tol,N)
v=zeros(size(v0,1),(N+1));

v(:,1) = v0;
lambda(1) = v(:,1).'*A*v(:,1);

I = eye(size(A,1));

for k=1:N
        temp = A - (lambda(k) * I);
        w = temp\v(:,k);
        v(:,k+1) = w/norm(w);
        lambda(k+1) = v(:,k+1).'*A*v(:,k+1);
        
        if abs(lambda(k+1) - lambda(k)) < tol
            break;
        end

end

lambda
