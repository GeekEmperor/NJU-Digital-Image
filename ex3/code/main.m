names = dir('../images/*g');
for i = 1:length(names)
    name = names(i).name;
    im = imread(['../images/', name]);
    im = rgb2gray(im);
    im = im2double(im);
    g = edgedetect(im);
    f = edgetrace(g);
    figure
    subplot(131)
    imshow(im)
    subplot(132)
    imshow(g)
    subplot(133)
    imshow(f)
    name = name(1:end-4);
    imwrite(g, ['../result/', name, '_detect.png']);
    imwrite(f, ['../result/', name, '_trace.png']);
end