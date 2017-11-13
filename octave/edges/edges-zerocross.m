pkg load image

img_original = imread("tv.png");

colormap_ntsc = rgb2ntsc(img_original);

lap = fspecial('laplacian', 0);

img_edge_sobel = edge(colormap_ntsc(:,:,1), 'zerocross', [], lap);

imshow(img_edge_sobel);

imwrite(img_edge_sobel, "edges-zerocross.output.png");

pause;
