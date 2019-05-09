% Digital Image Processing
% Spatial domain
% Image to binary
%
% Allann Jones

% Open image file

img = imread('bw2.tif');

whos img

imgBw = imbinarize(img);

imwrite(imgBw, 'x.tif');

% Determine image size

[width, height, bpp] = size(imgBw);

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
        colorLevel = imgBw(column, row);

        %fprintf("%d ", colorLevel);
    end

    %fprintf("\n");
end

subplot(1, 3, 1);
imshow(img);

subplot(1, 3, 2);
imshow(imgBw);

imwrite(imgBw, "x.tif");

for row = 1:height
    for column = 1:width
        if (imgBw(column, row) == 1)
            imgBw(column, row) = 0;
        else
            imgBw(column, row) = 1;
        end
    end
end

subplot(1, 3, 3);
imshow(imgBw);