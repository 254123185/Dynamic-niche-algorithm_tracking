%������Ϊ������
%�����������Ϊͼ�����Ȧ�������ĺ�����x��������y�����x���߶�Y
%�������Ϊ������ͼ��
function AfterImage = huading(Image, Centerx, Centery, High, Wide)
AfterImage = Image;
Gx = round(Centerx - High/2);   %����������
Gy = round(Centery - Wide/2) ;  %���ĺ�����
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
