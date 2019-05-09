imagescaling('girl.tif', 0.5, 0.5);

function imagescaling(filePath, scaleFactorX, scaleFactorY)
    imgOriginal = imread(filePath);

    [M, N] = size(imgOriginal);

    fprintf('Size of orignal image: %dx%d\n', M, N);

    M_New = round(M * scaleFactorX);
    N_New = round(N * scaleFactorY);

    fprintf('Size of the new image: %dx%d\n', M_New, N_New);

    imgResized = imresize(imgOriginal, [M_New, N_New]);

    imwrite(imgResized, 'img_resized.tif');

    subplot(1, 2, 1);
    imshow(imgOriginal);

    subplot(1, 2, 2);
    imshow(imgResized);
end