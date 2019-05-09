% Digital Image Processing
% Morphology
% Extraction of connected components.
%
% Allann Jones

filePath = 'hole_bw.tif';
outputFilePath = 'output_border_extraction.tif';
elementar = [1 1 1; 1 1 1; 1 1 1];
subplot_rows = 6;
subplot_cols = 6;

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

% Find 8-connected point

[column, row] = find8ConnectedPoint(imgBw, width, height);

fprintf("8-connected point: %d, %d\n", column, row);

% Mount image from 8-connected point

X = zeros(width, height);
X(column, row) = 1;

imgX = imgBw;

for row = 1:height
    for column = 1:width
        imgX(column, row) = X(column, row);
    end
end

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

    dilutedMatrix = imgDilute(imgX, width, height, elementar);

    imgDiluted = imgBw;

    % Transfer new pixel values to image
    for row = 1:height
        for column = 1:width
            imgDiluted(column, row) = dilutedMatrix(column, row);
        end
    end

    subplot(subplot_rows, subplot_cols, figureIndex);
    imshow(imgDiluted);
    title('Diluted');

    figureIndex = figureIndex + 1;

    % Intersection

    imgIntersection = imgIntersect(imgDiluted, imgBw, width, height);

    subplot(subplot_rows, subplot_cols, figureIndex);
    imshow(imgIntersection);
    title('Intersection');

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


% Functions declarations

function [col8Conn, row8Conn] = find8ConnectedPoint(imgBw, width, height)
    col8Conn = -1;
    row8Conn = -1;    

    for column = 2:(width - 2)
        for row = 2:(height - 2)
            % fprintf("%d", imgBw(column, row));

            if (imgBw(column, row) == 0 && ...
                imgBw(column - 1, row) == 1 && ...
                imgBw(column, row - 1) == 1)

                col8Conn = column;
                row8Conn = row;
                
                %fprintf("8-connected point: %d, %d\n", column, row);
                
                return;
            end
        end

        % fprintf("\n");
    end
end

function outputMatrix = imgDilute(imgBw, width, height, elementar)
    outputMatrix = zeros(width, height);

    for row = 1:height - 2
        for column = 1:width - 2
            if (elementar(2, 2) == 1 && imgBw(column + 1, row + 1) == 1)
                if (elementar(1, 1) == 1)
                    outputMatrix(column, row) = 1;
                %else
                %    outputMatrix(column, row) = 0;
                end

                if (elementar(1, 2) == 1)
                    outputMatrix(column + 1, row) = 1;
                %else
                %    outputMatrix(column + 1, row) = 0;
                end

                if (elementar(1, 3) == 1)
                    outputMatrix(column + 2, row) = 1;
                %else
                %    outputMatrix(column + 2, row) = 0;
                end

                if (elementar(2, 1) == 1)
                    outputMatrix(column, row + 1) = 1;
                %else
                %    outputMatrix(column, row + 1) = 0;
                end

                if (elementar(2, 2) == 1)
                    outputMatrix(column + 1, row + 1) = 1;
                %else
                %    outputMatrix(column + 1, row + 1) = 0;
                end

                if (elementar(2, 3) == 1)
                    outputMatrix(column + 2, row + 1) = 1;
                %else
                %    outputMatrix(column + 2, row + 1) = 0;
                end

                if (elementar(3, 1) == 1)
                    outputMatrix(column, row + 2) = 1;
                %else
                %    outputMatrix(column, row + 2) = 0;
                end

                if (elementar(3, 2) == 1)
                    outputMatrix(column + 1, row + 2) = 1;
                %else
                %    outputMatrix(column + 1, row + 2) = 0;
                end

                if (elementar(3, 3) == 1)
                    outputMatrix(column + 2, row + 2) = 1;
                %else
                %    outputMatrix(column + 2, row + 2) = 0;
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

function imgOutput = imgComplement(imgBw, width, height)
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

function imgOutput = imgIntersect(img1, img2, width, height)
    imgOutput = img1;

    for row = 1:height
        for column = 1:width
            if (img1(column, row) == 1 && img2(column, row) == 1)
                imgOutput(column, row) = 1;
            else
                imgOutput(column, row) = 0;
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