%提取目标图像的颜色直方图信息，
%输入参数依次为目标区域的纵坐标x，横坐标y，框高，框宽度，输入图像
%输出参数为颜色分布模型
function bin = testHistgram(x, y, High, Wide, I)
global v_count; %为论文中的参数m，目前选择的是图像中的像素个数
global matrix;
bin = zeros(1, v_count);

normalizationConstant = (High.^2 + Wide^2).^0.5;    %区域面积大小
pixel_Constant = normalizationConstant;
Constant = 0;   %归一化因子
r = 0;  %到区域中心的空间距离
count = 0;


    for pixel_x = round(x-High/2) : 1 : floor(x+High/2)
        for pixel_y = round(y-Wide/2) : 1 : floor(y+Wide/2)     %范围为跟踪框内
            if(((x - pixel_x).^2)/High + ((y - pixel_y).^2)/Wide < 1)    %目标点到中心的空间距离与常数比值小于1
            r = ((x - pixel_x).^2 + (y - pixel_y).^2).^0.5/normalizationConstant;            
            k = 1 - r.^2;    %空间信息融合函数
            %k=exp((-1/2)*r^2)候选函数高斯核函数，目标中心区域的像素权重高
            R = double(I(pixel_x, pixel_y, 1));
            G = double(I(pixel_x, pixel_y, 2));
            B = double(I(pixel_x, pixel_y, 3));     %R、G、B分量
            a1 = floor(R/32);   %floor比该值小且距离最近的一个整数。
            a2 = floor(G/32);   %每个通道量化为32个级别
            a3 = floor(B/32);
            bin_id = matrix(a1*64+a2*8+a3+1);
            bin(bin_id) = bin(bin_id) + k;  %相应的颜色柱上附上颜色值
            Constant = Constant + k;
            end
        end
    end
dConstant = 1/Constant;
next = 1:1:v_count;
bin(next) = dConstant*bin(next);    %输出颜色分布模型