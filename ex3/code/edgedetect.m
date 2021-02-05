function g = edgedetect(im)
% 输入灰度图像，输出二值边缘图像
im = imgaussfilt(im, 2);
[h, w] = size(im);
gx = imfilter(im, [1 2 1; 0 0 0; -1 -2 -1]);
gy = imfilter(im, [1 0 -1; 2 0 -2; 1 0 -1]);
m = sqrt(gx.^2 + gy.^2);    % 梯度大小
alpha = atan(gy./gx);   % 梯度方向
[~, d] = min(abs(alpha(:) - (-pi/2:pi/4:pi/2)), [], 2);	% 最接近的方向
d(d == 5) = 1;  
d = reshape(d, size(im));
b = [0,-1; 1,-1; 1,0; 1,1];	% 四种方向坐标偏移
g = m;
for i = 2:h-1
    for j = 2:w-1
        k = d(i,j);
        if m(i+b(k,1),j+b(k,2)) > m(i,j) || m(i-b(k,1),j-b(k,2)) > m(i,j)
            g(i,j) = 0;	% 非最大抑制
        end
    end
end
th = 0.1;   % 上阈值
tl = 0.4 * th;  % 下阈值
gh = g >= th;
gl = g < th & g >= tl;
row = zeros(h*w, 1);  % 行索引栈
col = zeros(h*w, 1);  % 列索引栈
top = sum(gh(:));   % 栈顶
[row(1:top), col(1:top)] = find(gh);
b = [-1 -1; -1 0; -1 1; 0 -1; 0 1; 1 -1; 1 0; 1 1];    % 八个邻居偏移
g = gh;
while top > 0
    i = row(top);
    j = col(top);
    top = top - 1;
    for k = 1:8
        x = i + b(k, 1);
        y = j + b(k, 2);
        if x>=1 && x<=h && y>=1 && y<=w && gl(x, y)==1
            top = top + 1;
            row(top) = x;
            col(top) = y;
            g(x, y) = 1;
            gl(x, y) = 0;
        end
    end
end