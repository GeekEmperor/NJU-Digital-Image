input = imread('../asset/input.jpg');
template = imread('../asset/template.jpg');
output = zeros(size(input), 'uint8');
[m, n, c] = size(input);
[x, y, c] = size(template);
for k = 1:c
    pr = imhist(input(:,:,k)) / (m * n);
    s = uint8(255 * cumsum(pr));
    pz = imhist(template(:,:,k)) / (x * y);
    g = uint8(255 * cumsum(pz));
    f = zeros(256, 1);
    f(:) = nan;
    for i = 1:256
        f(g(i) + 1) = i - 1;
    end
    f = fillmissing(f, 'nearest');
    f = uint8(f);
    for i = 1:m
        for j = 1:n
            output(i,j,k) = f(s(input(i,j,k) + 1) + 1);
        end
    end
end
imwrite(output, '../asset/output.jpg');
imshow(output);