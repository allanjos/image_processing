% Open image file

img = imread('cktboard_200dpi_gl.jpg');

whos img

% Determine image size

[width, height, bpp] = size(img);

fprintf('Size of image: width=%d, height=%d, bpp=%d\n', width, height, bpp);

% Get image information

info = imfinfo('cktboard_200dpi_gl.jpg');

% Image format

fprintf('Image format: %s\n', info.Format);

% Bit depth

fprintf('Bit depth: %d\n', info.BitDepth);

% Mean gray color level using Matlab function

fprintf('Mean gray level: %d\n', round(mean(img(:))));

% Mean gray color level

graySum = int64(0);

for column = 1:width
    for row = 1:height
        grayLevel = img(row, column);
        
        graySum = int64(graySum) + int64(grayLevel);
    end
end

% fprintf("Gray sum: %d\n", graySum);

grayMean = round(graySum / (width * height));

fprintf("Gray mean: %d\n", grayMean);

% File size

fprintf('File size: %d\n', info.FileSize);

% Size of image

size_img = width * height * bpp * info.BitDepth;

fprintf('Image size: %d\n', size_img);

% Bytes count

bytes_count = info.Width * info.Height * info.BitDepth / 8;

fprintf('Bytes count: %d\n', bytes_count);

% Compression rate

compression_rate = bytes_count / info.FileSize;

fprintf('Compression rate: %f\n', compression_rate);

% Display image

imshow(img);

% Save image

imwrite(img, "cktboard_200dpi_gl.tif");

img_tif = imread("cktboard_200dpi_gl.tif");

info_tif = imfinfo("cktboard_200dpi_gl.tif");

% Image format

fprintf("Image format: %s\n", info_tif.Format);

% Display image

subplot(1, 2, 1);
imshow(img);

subplot(1, 2, 2);
imshow(img_tif);