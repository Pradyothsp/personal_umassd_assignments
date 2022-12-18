function plot_ = plot_diagram(i, t, x, ep)
    figure(i);
    plot(t, x(:,1));
    xlabel('t');
    ylabel('solution x');
    title('Van der pol oscillator, epsilon = ', ep);
end
