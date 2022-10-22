% Create a parallel pool if none exists
if isempty(gcp())
    parpool();
end

n_workers = gcp().NumWorkers;

% Define the function
f = @(x,y,z) x.^3.*y.^3.*z.^3;


% Discretize the interval on the client
x = linspace(1,2,nworkers+1);
y = linspace(-1,1,nworkers+1);
z = linspace(2,3,nworkers+1);


% On the workers
spmd
    ainit = x(spmdIndex()); 
    bfin = x(spmdIndex()+1);
    cinit = y(spmdIndex());
    dfin = y(spmdIndex()+1);
    einit = z(spmdIndex());
    ffin = z(spmdIndex()+1);

    locint = integral3(f,ainit,bfin,cinit,dfin,einit,ffin); 
    totalint = spmdPlus(locint); 
end


totalvalue = totalint{1};
sprintf("totalvalue: %f", totalvalue)
