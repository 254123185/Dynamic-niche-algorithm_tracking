clc, clear
ImageBase = imread('0.jpg');
imshow(ImageBase);
[BaseHigh, BaseWide, CRGB] = size(ImageBase);
rect = getrect();
x1 = rect(2); x2 = rect(2) + rect(4);High = round(rect(4));    %得到纵坐标数据，High为框高
y1 = rect(1); y2 = rect(1) + rect(3);Wide = round(rect(3));    %得到横坐标数据，Wide为框宽
x = round((x1 + x2)/2);
y = round((y1 + y2)/2);     %划定框的中心点坐标
After = huading(ImageBase, x, y, High, Wide);   %得到新的划定框的图像数据
newSita = 0.2;
global v_count;
global matrix;
global first;
global Wucha;
v_count = 512;  %8*8*8 颜色直方图桩数
matrix = 1:1:v_count;
first = 1;
N = 500;    %粒子数量
[SampleSet, SampleProbability, Estimate, targeHistgram] = testInitial(x, y, High, Wide, ImageBase, N)  %测试初始化子程序
vx = 0;
vy = 0;
Wucha = zeros(1,300);

%程序循环开始
n = 300;    %图片数量
for loop = 2:1:n
        loop
        a = num2str(loop+first-1);  %读取下一帧图片
        b = [a, '.jpg'];
        NewImage = imread(b);
            NewSampleSet = testSelect(SampleSet, SampleProbability, loop, NewImage, N);    %采样方法的选择(重要性采样SIR)
            [SampleSet,afterProp] = testPropagation(NewSampleSet, vx, vy, BaseHigh, BaseWide, NewImage, N, High, Wide);%%随机采样产生100个候选粒子,按照动态模型进行演化
            [SamplePprobability, Estimate, vx, vy, TargetPic]=ObserveandEstimate(SampleSet, Estimate, targeHistgram, newSita,loop, afterProp, NewImage, N, first, High, Wide, x, y); %更新
    imshow(TargetPic);
end

x= 1:1:300;
plot(x,Wucha);
Wucha = Wucha';
xlswrite('F:\CZC_PAPER\CODE\粒子滤波\my_test2\Wucha.xlsx',Wucha);