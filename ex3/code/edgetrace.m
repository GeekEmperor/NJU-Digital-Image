function f = edgetrace(g)
% 输入二值图像，输出边缘分量
[h, w] = size(g);
[by, bx] = meshgrid(-2:2);
b = [-1 -1; -1 0; -1 1; 0 -1; 0 1; 1 -1; 1 0; 1 1];    % 八个邻居偏移
f = uint16(~g);
c = 1;  % 连通分量数
for j = 1:w
    for i = 1:h
        if f(i, j) == 0
            c = c + 1;
            f(i, j) = c;
            row = i;    % 行索引栈
            col = j;    % 列索引栈
            while ~isempty(row)
                s = row(end);
                t = col(end);
                row(end) = [];
                col(end) = [];
                for k = 1:25
                    x = s + bx(k);
                    y = t + by(k);
                    if x>=1 && x<=h && y>=1 && y<=w && f(x, y)==0
                        row(end + 1) = x;
                        col(end + 1) = y;
                        f(x, y) = c;
                    end
                end
            end
        end
    end
end
f = label2rgb(f - 1);