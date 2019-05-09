imgOriginal = imread('testpattern1024.tif');

whos imgOriginal

subplot(1, 3, 1);
imshow(imgOriginal);
title('Original');

r = 100;
c = 100;

% Padding with zeroes

imgPadding = imagePad4e(imgOriginal, r, c, 'zeros');

subplot(1, 3, 2);
imshow(imgPadding);
title('Padding zeroes');

% Padding replicating pixels at borders

imgPadding = imagePad4e(imgOriginal, r, c, 'replicate');

subplot(1, 3, 3);
imshow(imgPadding);
title('Padding replicated');

function g = imagePad4e(img, r, c, padtype)
    if (padtype == "replicate")
        g = padarray(img, [r c], 'replicate', 'both');
    else
        g = padarray(img, [r c]);
    end
end