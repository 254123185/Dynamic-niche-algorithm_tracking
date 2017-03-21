%观测值和估计值模型更新
function [SampleProbability, Estimate, vx, vy, TargetPic]  = ObserveandEstimate(SampleSet, Estimate, targetHistgram,new_sita,loop,afterProp,Image,N,first,High, Wide, x, y)
TotalProbability = 0;
ansProbability = 0;
for i = 1:N
    SampleHistgream(i).element = testHistgram(SampleSet(i).x, SampleSet(i).y, High, Wide, Image);
    SampleProbability(i) = testWeight(targetHistgram, SampleHistgream(i).element, new_sita);    %相似性度量，Bhattacharyya距离权重
    TotalProbability = TotalProbability + SampleProbability(i);  %总权值
    
end
for i = 1:N
    SeProbability(i) =  SampleProbability(i) / TotalProbability;    %权重归一化处理
     myProbability(i) = SeProbability(i).^2;
    ansProbability = ansProbability + myProbability(i);
end
global OurProbability;
OurProbability(loop) = 1/ansProbability;
Estimate(loop).x = 0;  
Estimate(loop).y = 0;
% Estimate(loop).High = 0;
% Estimate(loop).Wide = 0;
for i = 1 : 1: N
    Estimate(loop).x = Estimate(loop).x + SampleSet(i).x * SampleProbability(i) / TotalProbability; %状态量更新
    Estimate(loop).y = Estimate(loop).y + SampleSet(i).y * SampleProbability(i) / TotalProbability;

end
Estimate(loop).histgram = testHistgram(Estimate(loop).x, Estimate(loop).y, High, Wide, Image);

% Estimate(loop).prob = testWeight(targetHistgram, Estimate(loop).histgram, new_sita);
%%%这是一个检测变量，是判断是否进行颜色参考模型更新的主要依据，
%%%根据颜色参考分布和当前目标颜色分布的Bhattacharyya系数对参考颜色柱状图进行实时跟新


%计算速度
a = Estimate(loop).x;
b = Estimate(loop-1).x;
vx = a - b; %中心点偏移距离
c = Estimate(loop).y;
d = Estimate(loop-1).y;
vy = c - d;
global Wucha;
Wucha(loop) = ((a-x).^2+(c-y).^2).^0.5;
% for newx = a-1 : a + 1
%     for newy = c - 1:c + 1;
%         afterProp(round(newx), round(newy), 1) = 255;  %新中心点标定
%         afterProp(round(newx), round(newy), 2) = 255;
%     end
% end
TargetPic = huading(afterProp, ceil(a), ceil(c), High,  Wide); %新框标记
a=num2str(loop+first-1);
b=['C:\Users\254123185\Desktop\asd\',a];
 imwrite(TargetPic,[b,'.jpg']);