pkg load image;

img = imread('tv.png');

whos

[height, width, layers] = size(img);

disp('Size of image:');
printf('Width: %d\n', width);
printf('Height: %d\n', height);
printf('Layers: %d\n', layers);

img_rotate = imrotate(img, 45);

[height, width, layers] = size(img_rotate);

disp('Size of rotate image:');
printf('Width: %d\n', width);
printf('Height: %d\n', height);
printf('Layers: %d\n', layers);

imshow(img_rotate);

pause;
