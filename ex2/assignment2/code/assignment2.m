im = imread('../asset/image/3_3.jpg');
% ‘≠Õº
f = im2double(im);
subplot(1, 3, 1);
imshow(f);
% ∆µ¬ ”Ú¬À≤®
[m, n] = size(im);
mask = ones(m+2, n+2);
mask(1:2:end, 2:2:end) = -1;
mask(2:2:end, 1:2:end) = -1;
f(m+1:m+2, :) = 0;
f(:, n+1:n+2) = 0;
f = f .* mask;
F = fft2(f);
h = zeros(m+2, n+2);
a = fix(m/2)+1;
b = fix(n/2)+1;
h(a:a+2, b:b+2) = [-1,0,1;-2,0,2;-1,0,1];
h = h .* mask;
H = fft2(h);
H = imag(H) .* i;
H = H .* mask;
G = H .* F;
g = real(ifft2(G));
g = g .* mask;
g = g(1:m, 1:n);
subplot(1, 3, 2);
imshow(g, []);
% ø’º‰”Ú¬À≤®
f = zeros(m+2, n+2);
f(2:m+1, 2:n+1) = im2double(im);
h = [-1,0,1;-2,0,2;-1,0,1];
g = zeros(m, n);
for i = 1:m
    for j = 1:n
        g(i, j) = sum(f(i:i+2, j:j+2) .* h, 'all');
    end
end
subplot(1, 3, 3);
imshow(g, []);
saveas(gcf, '../asset/result/439.png');