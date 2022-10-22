clear all;

% Create a parallel pool if none exists
if isempty(gcp())
    parpool();
end

% Parallel computations
n1 = 8;
n2 = 54;
n3 = 400;

p = feature('numcores');


tic
parfor i=1:n1
    timeconsumingfun(5)
end
tp1 = toc;


tic
parfor i=1:n2
    timeconsumingfun(5)
end
tp2 = toc;


tic
parfor i=1:n3
    timeconsumingfun(5)
end
tp3 = toc;


speedup_1 = getSpeedup(n1*5, tp1);
speedup_2 = getSpeedup(n2*5, tp2);
speedup_3 = getSpeedup(n3*5, tp3);

efficiency_1 = getEfficiency(speedup_1, p);
efficiency_2 = getEfficiency(speedup_2, p);
efficiency_3 = getEfficiency(speedup_3, p);

fprintf("\nfor n: %d, speedup is %f and efficiency is %f", n1, speedup_1, efficiency_1)
fprintf("\nfor n: %d, speedup is %f and efficiency is %f", n2, speedup_2, efficiency_2)
fprintf("\nfor n: %d, speedup is %f and efficiency is %f\n", n3, speedup_3, efficiency_3)
