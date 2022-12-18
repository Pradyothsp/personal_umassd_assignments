function [t, x] = do_vanderpol(tspan, x0, ep)

ode = @(t,x) vanderpoldemo(t, x, ep);
[t,x] = ode45(ode, tspan, x0);

end