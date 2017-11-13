pkg load image;

img = imread('asimov.png');

img = rgb2hsv(img);

img_double = im2double(img);   % imgd in [0,1]

whos

img_smooth = img(:,:,3);

mask = ones(3, 3) / 9;

img_smooth = conv2(img_smooth, mask);

imwrite(img_smooth, 'smooth.output.png');

imshow(img_smooth);

pause;
