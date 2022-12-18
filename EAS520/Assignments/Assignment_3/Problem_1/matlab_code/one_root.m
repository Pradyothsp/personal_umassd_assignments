clear all; close all; % Start fresh

f = @(x) sin(3*pi*cos(2*pi*x).*sin(pi*x));
a = -3; b = 5;
x0 = 0.5;

tic
    q = fzero(f,x0);
toc


%Plot the function and roots if possible
xx = linspace(a,b,1001);
fig = figure('Position',[100 100 1200 300]);
plot(xx,f(xx),'-k','linewidth',2);
hold on
plot(q,f(q),'o','markerfacecolor','r')
xlim([a,b]); ylim([-1,1]);
yticks([-1 0 1])
xlabel('x'); 
ylabel('f(x)');
pbaspect([4 1 1])
