% Digital Image Processing
% Morphology
% Convex Hull
%
% Allann Jones

% General variables

filePath = 'convex_hull_bw.tif';
outputFilePath = 'output_border_extraction.tif';
subplot_rows = 6;
subplot_cols = 6;

% Structuring elements
elementar_1 = [ 1 -1 -1;  1  0 -1;  1 -1 -1];
elementar_2 = [ 1  1  1; -1  0 -1; -1 -1 -1];
elementar_3 = [-1 -1  1; -1  0  1; -1 -1  1];
elementar_4 = [-1 -1 -1; -1  0 -1;  1  1  1];

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

% Plot original image

subplot(subplot_rows, subplot_cols, 1);
imshow(imgBw);
title('Original');

% Mask 1

imgX = imgBw;

clear imgXprevious;
iteration = 0;
figureIndex = 2;

% While previous and current intersection is different
while 1
    iteration = iteration + 1;
    
    fprintf("Iteration %d ================\n", iteration);

    subplot(subplot_rows, subplot_cols, figureIndex);
    imshow(imgX);
    title('X');
    
    figureIndex = figureIndex + 1;

    % Dilute X and structuring element (SE)

    erodedMatrix = imgErode(imgX, width, height, elementar_1);

    imgEroded = imgBw;

    % Transfer new pixel values to image
    for row = 1:height
        for column = 1:width
            imgEroded(column, row) = erodedMatrix(column, row);
        end
    end

    subplot(subplot_rows, subplot_cols, figureIndex);
    imshow(imgEroded);
    title('Eroded');

    figureIndex = figureIndex + 1;

    % Intersection

    imgUnited = imgUnion(imgEroded, imgBw, width, height);

    subplot(subplot_rows, subplot_cols, figureIndex);
    imshow(imgUnited);
    title('Union');

    figureIndex = figureIndex + 1;
    
    if exist('imgXprevious', 'var') == 1
        if imgIsEqual(imgX, imgXprevious, width, height) == 1
            fprintf("Current and previous X are equal");

            break;
        end
    else
        fprintf("Previous X is not defined");
    end

    imgXprevious = imgX;
    
    imgX = imgIntersection;
end


% Function definitions

function outputMatrix = imgErode(imgBw, width, height, elementar)
    outputMatrix = zeros(width, height);

    for row = 1:height - 2
        for column = 1:width - 2
            if ((elementar(1, 1) == -1 || (elementar(1, 1) == 1 && imgBw(column, row) == 1)) && ...
                (elementar(1, 2) == -1 || (elementar(1, 2) == 1 && imgBw(column + 1, row) == 1)) && ...
                (elementar(1, 3) == -1 || (elementar(1, 3) == 1 && imgBw(column + 2, row) == 1)) && ...
                (elementar(2, 1) == -1 || (elementar(2, 1) == 1 && imgBw(column, row + 1) == 1)) && ...
                (elementar(2, 2) == -1 || (elementar(2, 2) == 1 && imgBw(column + 1, row + 1) == 1)) && ...
                (elementar(2, 3) == -1 || (elementar(2, 3) == 1 && imgBw(column + 2, row + 1) == 1)) && ...
                (elementar(3, 1) == -1 || (elementar(3, 1) == 1 && imgBw(column, row + 2) == 1)) && ...
                (elementar(3, 2) == -1 || (elementar(3, 2) == 1 && imgBw(column + 1, row + 2) == 1)) && ...
                (elementar(3, 3) == -1 || (elementar(3, 3) == 1 && imgBw(column + 2, row + 2) == 1)))

                outputMatrix(column + 1, row + 1) = 1;
            end
        end
    end
end

function imgOutput = imgUnion(img1, img2, width, height)
    imgOutput = img1;

    for row = 1:height
        for column = 1:width
            if (img1(column, row) == 1 || img2(column, row) == 1)
                imgOutput(column, row) = 1;
            end
        end
    end
end

function equal = imgIsEqual(img1, img2, width, height)
    for row = 1:height
        for column = 1:width
            if ~ (img1(column, row) == img2(column, row))
                equal = 0;

                return;
            end
        end
    end

    equal = 1;
end