% Load original image

[imgOriginal] = imread('drip-bottle-256.tif');

% Determine the mean value of pixels

meanIntensity = mean(imgOriginal(:));

imgBinary = imgOriginal > meanIntensity;

imwrite(imgBinary, 'drip-bottle-256_blackwhite.tif');

% Display binary image

subplot(1, 2, 1);
imshow(imgBinary);

% Display original image

subplot(1, 2, 2);
imshow(imgOriginal);