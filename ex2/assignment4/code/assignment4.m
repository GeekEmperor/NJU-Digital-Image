im = imread('../asset/image/woman.png');
f = im2double(im);
g = imbilatfilt(f);
imshow(g);
imwrite(g, '../asset/result/woman.png');