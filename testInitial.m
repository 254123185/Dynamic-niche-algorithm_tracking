%��ʼ���ӳ���
%��������Ԥ����
function [SampleSet, SampleProbability, Estimate, targeHistgram] = testInitial(x, y, High, Wide, Image, N)
Estimate(1).x = x;  %״̬��
Estimate(1).y = y;
% Estimate(1).prob=0.98;


%�������ݳ�ʼ��
for i = 1 : N
    SampleSet(i).x = x; %�����۲���
    SampleSet(i).y = y;
    SampleSet(i).High = High;
    SampleSet(i).Wide = Wide;
end

targeHistgram = testHistgram(x, y, High, Wide, Image);  %��ȡѡ��ֱ��ͼ����ɫ�ֲ�ģ��
Estimate(1).histgram = targeHistgram;
initialProbability = 0.98;  %��ʼ����ȨֵΪ0.98

for i  = 1 : N
    SampleSet(i).element = testHistgram(SampleSet(i).x, SampleSet(i).y, SampleSet(i).High, SampleSet(i).Wide, Image);   %ÿ֡ͼ��ο���ɫģ��
    SampleProbability(i) = initialProbability;
end

% for new_x = x - 1 : x + 1
%     for new_y = y - 1 : y + 1
%         Image(new_x, new_y, 1) = 255;    %������ĵ�
%         Image(new_x, new_y, 2) = 255; 
% 
%     end
% end
newImage = huading(Image, x, y, High, Wide);    %��Ƿ�Χ��
imshow(newImage);   