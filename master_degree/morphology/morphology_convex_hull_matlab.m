% Digital Image Processing
% Morphology
% Convex Hull using Matlab functions from Image Processing Toolbox
%

% Original image

subplot(2, 2, 1);
imgOriginal = imread('convex_hull_bw_1.tif');
imshow(imgOriginal);
title('Original');

% Convex Hull of all objects in the image

subplot(2, 2, 2);
convexHull = bwconvhull(imgOriginal);
imshow(convexHull);
title('Convex Hull of all objects');

% Convex Hull individual foreground objects

subplot(2, 2, 3);
convexHullObjects = bwconvhull(imgOriginal, 'objects');
imshow(convexHullObjects);
title('Convex Hull - individual objects');

subplot(2, 2, 4);
convexHullObjects = bwconvhull(imgOriginal, 'union');
imshow(convexHullObjects);
title('Convex Hull - Union');