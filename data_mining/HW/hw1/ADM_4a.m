% Reading the flower.bmp image and converting it into double format and grayscale.
Image = imread('/Users/bharath/Documents/MATLAB/flower.bmp');
Image = double(im2gray(Image));

% Perform SVD on the flower.bmp image
[U, S, V] = svd(Image);

% Extract the top 10 singular values from the flower.bmp image
top_10_singular_values = diag(S(1:10,1:10));

% Plot each unique singular value against its rating.
figure;
plot(1:length(diag(S)), diag(S));
xlabel('Rank');
ylabel('Unique Singular Value');
title('Singular Values Versus Rankings');

% Print the top 10 singular values
fprintf('Top 10 singular values: \n');
disp(top_10_singular_values);