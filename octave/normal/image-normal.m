pkg load image;

img = imread('neptune.png');

whos

img_hsv = rgb2hsv(img);

img_hsv = img_hsv(:,:,3);

% img_hsv = (img(:,:,1) + img(:,:,2) + img(:,:,3)) / 3;

[height, width, layers] = size(img_hsv);

disp('Size of image:');
printf('Width: %d\n', width);
printf('Height: %d\n', height);
printf('Layers: %d\n', layers);

imwrite(img_hsv, 'normal-output.png');

imshow(img_hsv);

pause;
