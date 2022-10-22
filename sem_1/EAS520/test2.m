if isempty(gcp())
    parpool();
end
tspan = [0 10];
x0 = [0.5;0];

tic
for i = 1:5000
    if i<400
        Ep  = i/100;
    elseif i<4000
        Ep = i/1000;
    else
        Ep = i/1250;
    end
    
    ode = @(t,x) vanderpoldemo(t,x,Ep);
    [t,x] = ode45(ode, tspan, x0);
    
    if ismember(i, [1,10,500,2000,5000])
        figure(i);
        plot(t,x(:,1));
        xlabel('t');
        ylabel('solution x');
        title('Van der pol oscillator, \epsilon = ', Ep);
    end
end
t1 = toc;

a = sprintf("Execution time for Normal Computation: %f",t1);
disp(a);

tic
parfor i=1:5000
    if i<400
        E  = i/100;
    elseif i<4000
        E = i/1000;
    else
        E = i/1250;
    end
    
    ode = @(t,x) vanderpoldemo(t,x,E);
    [t,x] = ode45(ode, t_span, x_zero);
    
    if ismember(i, [5,25,750,2500,5000])
        figure(i);
        plot(t,x(:,1));
        xlabel('t');
        ylabel('solution x');
        title('Van der pol oscillator, \epsilon =',E);
    end
end
tp = toc;

b = sprintf("Execution time for Embarrasingly Parallel Computation: %f",t2);
disp(b);

Sp = t1/tp;
c = sprintf("SpeedUp: %f",Sp);

d = sprintf("Average Efficiency: %f = %d%%", Sp/8, int8((Sp/8)*100));
disp(d);
