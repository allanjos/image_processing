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
elementars        = [ 1 -1 -1;  1  -2 -1;  1 -1 -1];
elementars(:,:,2) = [ 1  1  1; -1  -2 -1; -1 -1 -1];
elementars(:,:,3) = [-1 -1  1; -1  -2  1; -1 -1  1];
elementars(:,:,4) = [-1 -1 -1; -1  -2 -1;  1  1  1];

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

clear imgXprevious;
iteration = 0;
figureIndex = 2;

imgX = imgBw;

% Convex Hull image

imgConvexHull = imgX;

% ES

for es = 1:4
    fprintf("ES %d\n", es);

    elementars(:, :, es)

    for row = 1:3
        for column = 1:3
            fprintf("elementar(%d,%d)=%d\n", row, column, elementars(row, column, es));
        end
    end

    % While previous and current intersection is different
    while 1
        iteration = iteration + 1;

        fprintf("Iteration %d ================\n", iteration);

        subplot(subplot_rows, subplot_cols, figureIndex);
        imshow(imgX);
        title(sprintf("%d. X", es));

        figureIndex = figureIndex + 1;

        % Erode X and structuring element (SE)

        erodedMatrix = imgErode(imgX, width, height, elementars(:, :, es));

        imgEroded = imgX;

        % Transfer new pixel values to image
        for row = 1:height
            for column = 1:width
                imgEroded(column, row) = erodedMatrix(column, row);
            end
        end

        subplot(subplot_rows, subplot_cols, figureIndex);
        imshow(imgEroded);
        title(sprintf("%d. Eroded", es));

        figureIndex = figureIndex + 1;

        if exist('imgXprevious', 'var') == 1
            % Intersection

            imgUnited = imgUnion(imgEroded, imgXprevious, width, height);

            subplot(subplot_rows, subplot_cols, figureIndex);
            imshow(imgUnited);
            title(sprintf("%d. Union", es));

            figureIndex = figureIndex + 1;

            % If equal to previous one, stop

            if imgIsEqual(imgX, imgXprevious, width, height) == 1
                fprintf("Current and previous X are equal\n");

                imgConvexHull = imgUnion(imgUnited, imgConvexHull, width, height);

                break;
            end

            imgXprevious = imgX;

            imgX = imgUnited;
        else
            fprintf("Previous X is not defined. Defining it.\n");

            imgXprevious = imgX;
            
            imgUnited = imgUnion(imgEroded, imgX, width, height);
            
            imgX = imgUnited;

            subplot(subplot_rows, subplot_cols, figureIndex);
            imshow(imgUnited);
            title(sprintf("%d. Union", es));

            figureIndex = figureIndex + 1;
        end
    end

end

subplot(subplot_rows, subplot_cols, figureIndex);
imshow(imgConvexHull);
title('Convex Hull');

% Function definitions

function outputMatrix = imgErode(imgBw, width, height, elementar)
    outputMatrix = zeros(width, height);

    for row = 1:height - 1
        for column = 1:width - 1
            % Last column is not empty, so stop at the width-2 column
            if (column >= (width - 2) && ~(elementar(1, 3) == -1) || ~(elementar(2, 3) == -1) || ~(elementar(3, 3) == -1))
                fprintf("Last ES column is not null\n");
                break;
            end

            % Last row is not empty, so stop at the width-2 column
            if (row >= (height - 2) && ~(elementar(3, 1) == -1) || ~(elementar(3, 2) == -1) || ~(elementar(3, 3) == -1))
                fprintf("Last ES row is not null\n");
                break;
            end

            count = 0;
            clearValue = 0;

            fprintf("row=%d, column=%d\n", row, column);

            if elementar(1, 1) == 1 && imgBw(column, row) == 1
                fprintf("row=%d, column=%d == 1\n", row, column);
                count = count + 1;
            elseif ((elementar(1, 1) == 1 && imgBw(column, row) == 0) || ...
                    (elementar(1, 1) == 0 && imgBw(column, row) == 1))
                clearValue = 1;
            end

            if elementar(1, 2) == 1 && imgBw(column + 1, row) == 1
                fprintf("row=%d, column=%d == 1\n", row, column + 1);
                count = count + 1;
            elseif ((elementar(1, 2) == 1 && imgBw(column + 1, row) == 0) || ...
                    (elementar(1, 2) == 0 && imgBw(column + 1, row) == 1))
               clearValue = 1;
            end

            if elementar(1, 3) == 1 && imgBw(column + 2, row) == 1
                fprintf("row=%d, column=%d == 1\n", row, column + 2);
                count = count + 1;
            elseif ((elementar(1, 3) == 1 && imgBw(column + 2, row) == 0) || ...
                    (elementar(1, 3) == 0 && imgBw(column + 2, row) == 1))
                clearValue = 1;
            end

            if elementar(2, 1) == 1 && imgBw(column, row + 1) == 1
                fprintf("row=%d, column=%d == 1\n", row + 1, column);
                count = count + 1;
            elseif ((elementar(2, 1) == 1 && imgBw(column, row + 1) == 0) || ...
                    (elementar(2, 1) == 0 && imgBw(column, row + 1) == 1))
                clearValue = 1;
            end

            if elementar(2, 3) == 1 && imgBw(column + 2, row + 1) == 1
                fprintf("row=%d, column=%d == 1\n", row + 1, column + 2);
                count = count + 1;
            elseif ((elementar(2, 3) == 1 && imgBw(column + 2, row + 1) == 0) || ...
                    (elementar(2, 3) == 0 && imgBw(column + 2, row + 1) == 1))
                clearValue = 1;
            end

            if elementar(3, 1) == 1 && imgBw(column, row + 2) == 1
                fprintf("row=%d, column=%d == 1\n", row + 2, column);
                count = count + 1;
            elseif ((elementar(3, 1) == 1 && imgBw(column, row + 2) == 0) || ...
                    (elementar(3, 1) == 0 && imgBw(column, row + 2) == 1))
                clearValue = 1;
            end

            if elementar(3, 2) == 1 && imgBw(column + 1, row + 2) == 1
                fprintf("row=%d, column=%d == 1\n", row + 2, column + 1);
                count = count + 1;
            elseif ((elementar(3, 2) == 1 && imgBw(column + 1, row + 2) == 0) || ...
                    (elementar(3, 2) == 0 && imgBw(column + 1, row + 2) == 1))
                clearValue = 1;
            end

            if elementar(3, 3) == 1 && imgBw(column + 2, row + 2) == 1
                fprintf("row=%d, column=%d == 1\n", row + 2, column + 2);
                count = count + 1;
            elseif ((elementar(3, 3) == 1 && imgBw(column + 2, row + 2) == 0) || ...
                    (elementar(3, 3) == 0 && imgBw(column + 2, row + 2) == 1))
                clearValue = 1;
            end

            %fprintf("(%d,%d)=1\n", row, column);

            if (clearValue == 1 || count == 0)
                outputMatrix(column + 1, row + 1) = 0;
            else
                outputMatrix(column + 1, row + 1) = 1;
                fprintf("(%d, %d) == 1\n", column + 1, row + 1);
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
            else
                imgOutput(column, row) = 0;
            end
        end
    end
end

function imgOutput = imgIntersection(img1, img2, width, height)
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