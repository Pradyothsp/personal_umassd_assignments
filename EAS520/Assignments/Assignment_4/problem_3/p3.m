clear; close all;

if isempty(gcp())
    parpool(4);
end

n_workers = gcp().NumWorkers;

grid_size = 2000;
max_iterations = 2000; 

x_lim = [-0.748766713922161, -0.748766707771757];
y_lim = [ 0.123640844894862, 0.123640851045266];
x_lim = linspace(x_lim(1),x_lim(end),(n_workers/2)+1);
y_lim = linspace(y_lim(1),y_lim(end),(n_workers/2)+1);

% Setup on the workers
tic();
spmd
    [m,n] = getMN(spmdIndex());
    
    x = linspace(x_lim(m),x_lim(m+1),grid_size/spmdSize()*2);
    y = linspace(y_lim(n),y_lim(n+1),grid_size/spmdSize()*2);
    
    [x_grid,y_grid] = meshgrid(x,y);
    a1 = x_grid + 1i*y_grid; count = ones(size(a1));
    
    % Calculate the iterations
    a = a1;
    for n = 0:max_iterations
        a = a.*a + a1;
        In = abs(a)<=2; count = count + In;
    end
    
    count = log(count);
end


% Display on the client
cpu_time = toc();
set( gcf,'Position',[200 200 600 600] );
imagesc(cat(1,cat(2,count{1},count{3}),cat(2,count{2},count{4})));
axis image;axis off; colormap([jet();flipud(jet());0 0 0]); drawnow;
title( sprintf('%1.2fsecs (with spmd)',cpu_time));