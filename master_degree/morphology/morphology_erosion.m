% Digital Image Processing
% Morphology
% Erosion
%
% Allann Jones

elementar = [1 1 1; 1 1 1; 1 1 1];

% Open image file

imgBw = imread('noisy-fingerprint.tif');
%imgBw = imread('tv-bw.tif');

whos imgBw

% Determine image size

[width, height, bpp] = size(imgBw);

fprintf('Size of image: width=%d, height=%d, bpp=%d, colors=%d\n', width, height, bpp, 2^bpp);

% Get image information

info = imfinfo('bw.tif');

bitDepth = 2^info.BitDepth;

histMatrix = zeros(bitDepth, 1);

% Image format

fprintf('Image format: %s\n', info.Format);

% Bit depth

fprintf('Bit depth: %d\n', info.BitDepth);

% Erosion

outputMatrix = imgErode(imgBw, width, height, elementar);

subplot(1, 2, 1);
imshow(imgBw);

% Transfer new pixel values to image

for row = 1:height
    for column = 1:width
        imgBw(column, row) = outputMatrix(column, row);
    end
end

imwrite(imgBw, 'output.tif');

subplot(1, 2, 2);
imshow(imgBw);

function outputMatrix = imgErode(imgBw, width, height, elementar)
    outputMatrix = zeros(width, height);

    for row = 1:height - 2
        for column = 1:width - 2
            if (elementar(1, 1) == 1 && imgBw(column, row) == 1 && ...
                elementar(1, 2) == 1 && imgBw(column + 1, row) == 1 && ...
                elementar(1, 3) == 1 && imgBw(column + 2, row) == 1 && ...
                elementar(2, 1) == 1 && imgBw(column, row + 1) == 1 && ...
                elementar(2, 2) == 1 && imgBw(column + 1, row + 1) == 1 && ...
                elementar(2, 3) == 1 && imgBw(column + 2, row + 1) == 1 && ...
                elementar(3, 1) == 1 && imgBw(column, row + 2) == 1 && ...
                elementar(3, 2) == 1 && imgBw(column + 1, row + 2) == 1 && ...
                elementar(3, 3) == 1 && imgBw(column + 2, row + 2) == 1)

                outputMatrix(column + 1, row + 1) = 1;
            end
        end
    end
end