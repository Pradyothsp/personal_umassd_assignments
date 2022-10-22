if isempty(gcp())
    parpool();
end

tspan = [0 10];
x0 = [0.5; 0];

p = feature('numcores');


% Running code serially
tic
for i = 1:5000
    ep = getEP(i);

    [t,x] = do_vanderpol(tspan, x0, ep);

    if ismember(i, [1, 100, 1500, 2500, 5000])
        % Plotting
        plot_diagram(i, t, x, ep)
    end
end
t1 = toc;

% Embarrasingly Parallel Computation
tic
parfor i = 1:5000
    ep = getEP(i);

    [t,x] = do_vanderpol(tspan, x0, ep);

    if ismember(i, [1, 100, 1500, 2500, 5000])
        % Plotting
        plot_diagram(i, t, x, ep)
    end
end
tp = toc;

speedup = t1/tp;
efficiency = (speedup/p) * 100;

fprintf("t1: %f\n", t1);
fprintf("tp: %f\n", tp);

fprintf("SpeedUp: %f\n", speedup);
fprintf("Efficiency: %f\n", efficiency);
