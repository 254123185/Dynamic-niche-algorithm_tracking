%本函数为画框函数
%输入参数依次为图像矩阵、圈定框中心横坐标x，纵坐标y，宽度x，高度Y
%输出函数为画框后的图像
function AfterImage = huading(Image, Centerx, Centery, High, Wide)
AfterImage = Image;
Gx = round(Centerx - High/2);   %中心纵坐标
Gy = round(Centery - Wide/2) ;  %中心横坐标
for i = Gx - 1 : Gx + 1
    for j = Gy : Gy+Wide
              AfterImage(i, j, 3) = 255;
         AfterImage(i, j, 2) = 0;
        AfterImage(i, j, 1) = 255;
    end
end
for i = Gx+High-1 : Gx+High+1
    for j = Gy : Gy+Wide
              AfterImage(i, j, 3) = 255;
         AfterImage(i, j, 2) = 0;
        AfterImage(i, j, 1) = 255;
    end
end
for i = Gx : Gx+High
    for j = Gy-1 :  Gy+1
              AfterImage(i, j, 3) = 255;
         AfterImage(i, j, 2) = 0;
        AfterImage(i, j, 1) = 255;
    end
end
for i = Gx : Gx+High
    for j = Gy+Wide-1 :  Gy+Wide+1
              AfterImage(i, j, 3) = 255;
         AfterImage(i, j, 2) = 0;
        AfterImage(i, j, 1) = 255;
    end
end
