%初始化子程序
%各个变量预分配
function [SampleSet, SampleProbability, Estimate, targeHistgram] = testInitial(x, y, High, Wide, Image, N)
Estimate(1).x = x;  %状态量
Estimate(1).y = y;
% Estimate(1).prob=0.98;


%样本数据初始化
for i = 1 : N
    SampleSet(i).x = x; %样本观测量
    SampleSet(i).y = y;
    SampleSet(i).High = High;
    SampleSet(i).Wide = Wide;
end

targeHistgram = testHistgram(x, y, High, Wide, Image);  %获取选中直方图的颜色分布模型
Estimate(1).histgram = targeHistgram;
initialProbability = 0.98;  %初始概率权值为0.98

for i  = 1 : N
    SampleSet(i).element = testHistgram(SampleSet(i).x, SampleSet(i).y, SampleSet(i).High, SampleSet(i).Wide, Image);   %每帧图像参考颜色模型
    SampleProbability(i) = initialProbability;
end

% for new_x = x - 1 : x + 1
%     for new_y = y - 1 : y + 1
%         Image(new_x, new_y, 1) = 255;    %标记中心点
%         Image(new_x, new_y, 2) = 255; 
% 
%     end
% end
newImage = huading(Image, x, y, High, Wide);    %标记范围框
imshow(newImage);   