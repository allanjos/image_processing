I = imread("neptune.png");

% S = conv2(I, ones (5, 5) / 25, "same");

[dx, dy] = gradient(I);

disp("dx = "), disp(dx)
disp("dy = "), disp(dy)
