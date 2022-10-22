clear all;

% Create a parallel pool if none exists
if isempty(gcp())
    parpool();
end

% Parallel computations
n = 8;
p = feature('numcores');

tic
parfor i=1:n
    timeconsumingfun(5)
end
tp = toc;

t1 = getT1();

speedup = getSpeedup(t1, tp);
efficiency = getEfficiency(speedup, p);

fprintf("\nt1: %.2d and tp: %.2d", t1, tp)
fprintf("\nfor n: %d, speedup is %f and efficiency is %f\n", n, speedup, efficiency)
