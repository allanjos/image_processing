% Open image file

img = imread('tv.png');

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

imwrite(img, 'tv.tif');

img_tif = imread('tv.tif');

info_tif = imfinfo('tv.tif');

% Image format

fprintf('Image format: %s\n', info_tif.Format);

% Display image

subplot(1, 2, 1);
imshow(img);

subplot(1, 2, 2);
imshow(img_tif);
