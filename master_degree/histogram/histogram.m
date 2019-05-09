% Digital Image Processing
% Spatial domain
% Histogram of an image
%
% Allann Jones

% Open image file

img = imread('cktboard_200dpi_gl.jpg');

whos img

% Determine image size

[width, height, bpp] = size(img);

fprintf('Size of image: width=%d, height=%d, bpp=%d, colors=%d\n', width, height, bpp, 2^bpp);

% Get image information

info = imfinfo('cktboard_200dpi_gl.jpg');

bitDepth = 2^info.BitDepth;

histMatrix = zeros(bitDepth, 1);

% Image format

fprintf('Image format: %s\n', info.Format);

% Bit depth

fprintf('Bit depth: %d\n', info.BitDepth);

for row = 1:height
    for column = 1:width
        colorLevel = int32(img(row, column));

        histMatrix(colorLevel + 1, 1) = histMatrix(colorLevel + 1, 1) + 1;
    end
end

fprintf("Histogram:\n");

for row = 1:bitDepth
    fprintf("h[%d]=%d\n", row - 1, histMatrix(row, 1));
end

subplot(2, 3, 1);
imshow(img);
title('Original');

subplot(2, 3, 2);
plot(0:(bitDepth - 1), histMatrix(1:bitDepth, 1));
xlim([0 (bitDepth - 1)]);
title('Histogram');

subplot(2, 3, 3);
imhist(img);
title('imhist');

subplot(2, 3, 4);
[imgEqualized, transfEqualization] = histeq(img);
imshow(imgEqualized);
title('histeq');

subplot(2, 3, 5);
imhist(imgEqualized);
title('Equalized histogram');