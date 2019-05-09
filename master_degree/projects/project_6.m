% Image 1

img1Original = imread('hidden-horse.tif');

whos imgOriginal

% Image 1: Show original

subplot(4, 2, 1);
imshow(img1Original);

subplot(4, 2, 2);
imhist(img1Original);

% Image 1: Equalized histogram

img1Equalized = histEqual4e(img1Original);

imwrite(img1Equalized, 'hidden-horse-histeq.tif');

subplot(4, 2, 3);
imshow(img1Equalized);

subplot(4, 2, 4);
imhist(img1Equalized);


% Image 2

img2Original = imread('spillway-dark.tif');

whos imgOriginal

% Image 1: Show original

subplot(4, 2, 5);
imshow(img2Original);

subplot(4, 2, 6);
imhist(img2Original);

% Image 1: Equalized histogram

img2Equalized = histEqual4e(img2Original);

imwrite(img2Equalized, 'spillway-dark-histeq.tif');

subplot(4, 2, 7);
imshow(img2Equalized);

subplot(4, 2, 8);
imhist(img2Equalized);

function g = histEqual4e(img)
    g = histeq(img);
end