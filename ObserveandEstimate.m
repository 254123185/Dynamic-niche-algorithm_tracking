%�۲�ֵ�͹���ֵģ�͸���
function [SampleProbability, Estimate, vx, vy, TargetPic]  = ObserveandEstimate(SampleSet, Estimate, targetHistgram,new_sita,loop,afterProp,Image,N,first,High, Wide, x, y)
TotalProbability = 0;
ansProbability = 0;
for i = 1:N
    SampleHistgream(i).element = testHistgram(SampleSet(i).x, SampleSet(i).y, High, Wide, Image);
    SampleProbability(i) = testWeight(targetHistgram, SampleHistgream(i).element, new_sita);    %�����Զ�����Bhattacharyya����Ȩ��
    TotalProbability = TotalProbability + SampleProbability(i);  %��Ȩֵ
    
end
for i = 1:N
    SeProbability(i) =  SampleProbability(i) / TotalProbability;    %Ȩ�ع�һ������
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
    Estimate(loop).x = Estimate(loop).x + SampleSet(i).x * SampleProbability(i) / TotalProbability; %״̬������
    Estimate(loop).y = Estimate(loop).y + SampleSet(i).y * SampleProbability(i) / TotalProbability;

end
Estimate(loop).histgram = testHistgram(Estimate(loop).x, Estimate(loop).y, High, Wide, Image);

% Estimate(loop).prob = testWeight(targetHistgram, Estimate(loop).histgram, new_sita);
%%%����һ�������������ж��Ƿ������ɫ�ο�ģ�͸��µ���Ҫ���ݣ�
%%%������ɫ�ο��ֲ��͵�ǰĿ����ɫ�ֲ���Bhattacharyyaϵ���Բο���ɫ��״ͼ����ʵʱ����


%�����ٶ�
a = Estimate(loop).x;
b = Estimate(loop-1).x;
vx = a - b; %���ĵ�ƫ�ƾ���
c = Estimate(loop).y;
d = Estimate(loop-1).y;
vy = c - d;
global Wucha;
Wucha(loop) = ((a-x).^2+(c-y).^2).^0.5;
% for newx = a-1 : a + 1
%     for newy = c - 1:c + 1;
%         afterProp(round(newx), round(newy), 1) = 255;  %�����ĵ�궨
%         afterProp(round(newx), round(newy), 2) = 255;
%     end
% end
TargetPic = huading(afterProp, ceil(a), ceil(c), High,  Wide); %�¿���
a=num2str(loop+first-1);
b=['C:\Users\254123185\Desktop\asd\',a];
 imwrite(TargetPic,[b,'.jpg']);