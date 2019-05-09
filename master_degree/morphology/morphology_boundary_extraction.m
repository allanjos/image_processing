% Digital Image Processing - Morphology - Boundary Extraction
%
% Allann Jones

filePath = 'bw2.tif';
outputFilePath = 'output_border_extraction.tif';
elementar = [1 1 1; 1 1 1; 1 1 1];

% Open image file

imgBw = imread(filePath);

whos imgBw

% Determine image size

[width, height, bpp] = size(imgBw);

fprintf('Size of image: width=%d, height=%d, bpp=%d, colors=%d\n', width, height, bpp, 2^bpp);

% Get image information

info = imfinfo(filePath);

bitDepth = 2^info.BitDepth;

% Image format

fprintf('Image format: %s\n', info.Format);

% Bit depth

fprintf('Bit depth: %d\n', info.BitDepth);

outputMatrix = imgErode(imgBw, width, height, elementar);

imgEroded = imgBw;

% Transfer new pixel values to image

for row = 1:height
    for column = 1:width
        imgEroded(column, row) = outputMatrix(column, row);
    end
end

imgComplement = complement(imgEroded, width, height);

subplot(2, 2, 1);
imshow(imgBw);

subplot(2, 2, 2);
imshow(imgEroded);

subplot(2, 2, 3);
imshow(imgComplement);

imgBorderExtract = imgSubtract(imgBw, imgEroded, width, height);
subplot(2, 2, 4);
imshow(imgBorderExtract);

imwrite(imgBorderExtract, outputFilePath);

% Functions declarations

function outputMatrix = imgDilute(imgBw, width, height, elementar)
    outputMatrix = zeros(width, height);

    for row = 1:height - 2
        for column = 1:width - 2
            if (elementar(2, 2) == 1 && imgBw(column + 1, row + 1) == 1)
                if (elementar(1, 1) == 1)
                    outputMatrix(column, row) = 1;
                else
                    outputMatrix(column, row) = 0;
                end

                if (elementar(1, 2) == 1)
                    outputMatrix(column + 1, row) = 1;
                else
                    outputMatrix(column + 1, row) = 0;
                end

                if (elementar(1, 3) == 1)
                    outputMatrix(column + 2, row) = 1;
                else
                    outputMatrix(column + 2, row) = 0;
                end

                if (elementar(2, 1) == 1)
                    outputMatrix(column, row + 1) = 1;
                else
                    outputMatrix(column, row + 1) = 0;
                end

                if (elementar(2, 2) == 1)
                    outputMatrix(column + 1, row + 1) = 1;
                else
                    outputMatrix(column + 1, row + 1) = 0;
                end

                if (elementar(2, 3) == 1)
                    outputMatrix(column + 2, row + 1) = 1;
                else
                    outputMatrix(column + 2, row + 1) = 0;
                end

                if (elementar(3, 1) == 1)
                    outputMatrix(column, row + 2) = 1;
                else
                    outputMatrix(column, row + 2) = 0;
                end

                if (elementar(3, 2) == 1)
                    outputMatrix(column + 1, row + 2) = 1;
                else
                    outputMatrix(column + 1, row + 2) = 0;
                end

                if (elementar(3, 3) == 1)
                    outputMatrix(column + 2, row + 2) = 1;
                else
                    outputMatrix(column + 2, row + 2) = 0;
                end
            end
        end
    end
end

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

function imgOutput = complement(imgBw, width, height)
    for row = 1:height
        for column = 1:width
            if (imgBw(column, row) == 1)
                imgBw(column, row) = 0;
            else
                imgBw(column, row) = 1;
            end
        end
    end

    imgOutput = imgBw;
end

function imgOutput = imgSubtract(img1, img2, width, height)
    for row = 1:height
        for column = 1:width
            if (img1(column, row) == img2(column, row))
                img1(column, row) = 0;
            elseif (img1(column, row) == 1 && img2(column, row) == 0)
                img1(column, row) = 1;
            elseif (img1(column, row) == 0 && img2(column, row) == 1)
                img1(column, row) = 1;
            end
        end
    end

    imgOutput = img1;
end