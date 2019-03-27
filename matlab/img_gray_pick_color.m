img = imread('tv.png');

% Determine image size

[width, height, bpp] = size(img);

fprintf('Size of image: width=%d, height=%d, bpp=%d\n', width, height, bpp);

% Get image information

info = imfinfo('cktboard_200dpi_gl.jpg');

% Image format

fprintf('Image format: %s\n', info.Format);

for column = 1:width-1
    for row = 1:height-1
        grayLevel = pixVal4e(img, row, column);

        fprintf("%d ", grayLevel);
    end

    fprintf('\n');
end

imshow(img);

while 1
  fprintf('Click with the mouse on image:\n');

  [x, y, button] = ginput(1);

  if isempty(button)
      break
  end

  row = round(x);
  column = round(y);

  fprintf('Mouse click at pixel: (x=%d, y=%d)\n', row, column);

  grayLevel = pixVal4e(img, row, column);

  fprintf('Color at that image pixel: %d\n\n', grayLevel);
end

function level = pixVal4e(img, row, column)
  level = img(column, row);
end
