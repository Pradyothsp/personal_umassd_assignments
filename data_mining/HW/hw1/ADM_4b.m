% Read the flower.bmp image and convert it to grayscale and double format
Image = imread('/Users/bharath/Documents/MATLAB/flower.bmp');
Image = double(im2gray(Image));

% Perform SVD on the image
[U, S, V] = svd(Image);

% Reconstruct and display the original image using SVD matrices
Image_reconstructed = U * S * V';
figure;
imshow(uint8(Image_reconstructed));
title('Reconstructed Image using SVD');

% Compress the image using top k singular values and corresponding left/right singular vectors
k_values = 200;
for i = 1:length(k_values)
    k = k_values(i);
    Image_compressed = S;
    Image_compressed(k+1:end,k+1:end) = 0;
    Image2_compressed = U * Image_compressed * V';
    figure;
    imshow(uint8(Image2_compressed));
    title(sprintf('Compressed Image using Top %d Singular Values', k));
end
