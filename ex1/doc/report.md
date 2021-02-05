直方图匹配[[维基百科](https://en.wikipedia.org/wiki/Histogram_matching)]又称为直方图规定化，是指将一幅图像的直方图变成规定形状的直方图而进行的图像增强方法。即将某幅影像或某一区域的直方图匹配到另一幅影像上，使两幅影像的色调保持一致。

读取输入图像和模板图像，定义输出图像和图像大小。

```matlab
input = imread('../asset/input.jpg');
template = imread('../asset/template.jpg');
output = zeros(size(input), 'uint8');
[m, n, c] = size(input);
[x, y, c] = size(template);
```

输入图像在某个通道上的概率密度函数$p_r(r_j)=n_j/mn$，其中$r_j$是强度，$n_j$是该通道上$r_j$出现的次数。计算变换函数$s(r_k)=(L-1)\sum_{j=0}^k p_r(r_j)$，用于直方图均衡。同理计算模板图像的$p_z(z_j)$和$g(z_k)$。

```matlab
% k is a channel
pr = imhist(input(:,:,k)) / (m * n);
s = uint8(255 * cumsum(pr));
pz = imhist(template(:,:,k)) / (x * y);
g = uint8(255 * cumsum(pz));
```

计算变换函数$g$的反函数$f$，若缺失则需要填充，这里使用最近填充。

```matlab
f = zeros(256, 1);
f(:) = nan;
for i = 1:256
	f(g(i) + 1) = i;
end
f = fillmissing(f, 'nearest');
f = uint8(f);
```

输入图像的像素，经过复合变换$fs$得到对应输出图像的像素。

```matlab
for i = 1:m
	for j = 1:n
		output(i,j,k) = f(s(input(i,j,k) + 1) + 1);
	end
end
```

最终输出图像结果。

![output](../asset/output.jpg)