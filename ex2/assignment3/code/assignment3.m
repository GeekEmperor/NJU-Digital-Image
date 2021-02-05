im = imread('../asset/image/455.png');
f = im2double(rgb2gray(im));
[m, n] = size(f);
mask = ones(2*m, 2*n);
mask(1:2:end, 2:2:end) = -1;
mask(2:2:end, 1:2:end) = -1;
f(m+1:2*m, :) = 0;
f(:, n+1:2*n) = 0;
f = f .* mask;
F = fft2(f);
D = [30, 45, 60];
for i = 1:3
    y = -m+1:m;
    x = -n+1:n;
    H = 1./(1+((D(i).^2)./(x.^2+y'.^2)).^2);
    G = H .* F;
    g = real(ifft2(G));
    g = g .* mask;
    g = g(1:m, 1:n);
    subplot(1, 3, i);
    imshow(g);
end
saveas(gcf, '../asset/result/455.png');