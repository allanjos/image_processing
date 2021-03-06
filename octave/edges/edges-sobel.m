pkg load image

img_original = imread('tv.png');

colormap_ntsc = rgb2ntsc(img_original);

img_edge_sobel = edge(colormap_ntsc(:,:,1), 'Sobel');

imshow(img_edge_sobel);

imwrite(img_edge_sobel, 'edges-sobel.output.png');

pause;
