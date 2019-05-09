% Digital Image Processing
% Spatial filters
% Lowpass filter implementation
%
% Allann Jones

% Filter mask

filterMask = [1 2 1 ; 2 4 2; 1 2 1];

% Open image file

img = imread('cktboard_200dpi_gl.jpg');

subplot(1, 2, 1);
imshow(img);

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

fprintf('mask(0, 0): %d\n', filterMask(1, 1));

for row = 1:height - 2
    for column = 1:width - 2
        % fprintf("[r=%d,c=%d] ", row, column);

        % fprintf("[gray=%d] ", img(row + 1, column + 1));

        % fprintf("[%d, %d, %d, %d, %d, %d, %d, %d, %d]", ...
        %            img(row, column) * mask(1, 1), ...
        %            2 * img(row, column + 1) * mask(1, 2), ...
        %            img(row, column + 2) * mask(1, 3), ...
        %            2 * img(row + 1, column) * mask(2, 1), ...
        %            4 * img(row + 1, column + 1) * mask(2, 2), ...
        %            2 * img(row + 1, column + 2) * mask(2, 3), ...
        %            img(row + 2, column) * mask(3, 1), ...
        %            2 *img(row + 2, column + 1) * mask(3, 2), ...
        %            img(row + 2, column + 2) * mask(3, 3));

        newValue = int32(img(row, column)) * int32(mask(1, 1)) + ...
                   2 * int32(img(row, column + 1)) * int32(mask(1, 2)) + ...
                   int32(img(row, column + 2)) * int32(mask(1, 3)) + ...
                   2 * int32(img(row + 1, column)) * int32(mask(2, 1)) + ...
                   4 * int32(img(row + 1, column + 1)) * int32(mask(2, 2)) + ...
                   2 * int32(img(row + 1, column + 2)) * int32(mask(2, 3)) + ...
                   int32(img(row + 2, column)) * int32(mask(3, 1)) + ...
                   2 * int32(img(row + 2, column + 1)) * int32(mask(3, 2)) + ...
                   int32(img(row + 2, column + 2)) * int32(mask(3, 3));

       % fprintf("[total=%d,mean=%d]\n", newValue, newValue/15);

       img(row + 1, column + 1) = round(newValue / 15);

       % fprintf("[new=%d]\n", img(row + 1, column + 1));
    end
end

imwrite(img, 'x.png');

subplot(1, 2, 2);
imshow(img);