% Create a parallel pool if none exists
if isempty(gcp())
    parpool();
end

nworkers = gcp().NumWorkers;
% Define the function
f = @(x) x.^2;

% Discretize the interval on the client
x = linspace(-1,1,nworkers+1);

% On the workers
spmd
    ainit = x(spmdIndex()); %left point of subinterval
    bfin =  x(spmdIndex()+1); %right point of subinterval
    locint = integral(f,ainit,bfin); % subinterval integration
    totalint = spmdPlus(locint); % Add all values.
end
% Send the value back the client
totalvalue = totalint{1};
sprintf("totalvalue: %f", totalvalue)