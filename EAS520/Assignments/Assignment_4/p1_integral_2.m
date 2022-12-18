% Create a parallel pool if none exists
if isempty(gcp())
    parpool();
end

nworkers = gcp().NumWorkers;


% Define the function
f = @(x,y) cos(x).^2.*y.^2;


% Discretize the interval on the client
x = linspace(1,2,nworkers+1);
y = linspace(-1,1,nworkers+1);


% On the workers
spmd
    ainit = x(spmdIndex());
    bfin =  x(spmdIndex()+1);
    cinit = y(spmdIndex());
    dfin = y(spmdIndex()+1);

    locint = integral2(f,ainit,bfin,cinit,dfin);
    totalint = spmdPlus(locint);
end

totalvalue = totalint{1};
sprintf("totalvalue: %f", totalvalue)
