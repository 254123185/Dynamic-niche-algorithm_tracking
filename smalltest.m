clc, clear
ImageBase = imread('0.jpg');
imshow(ImageBase);
[BaseHigh, BaseWide, CRGB] = size(ImageBase);
rect = getrect();
x1 = rect(2); x2 = rect(2) + rect(4);High = round(rect(4));    %�õ����������ݣ�HighΪ���
y1 = rect(1); y2 = rect(1) + rect(3);Wide = round(rect(3));    %�õ����������ݣ�WideΪ���
x = round((x1 + x2)/2);
y = round((y1 + y2)/2);     %����������ĵ�����
After = huading(ImageBase, x, y, High, Wide);   %�õ��µĻ������ͼ������
newSita = 0.2;
global v_count;
global matrix;
global first;
global Wucha;
v_count = 512;  %8*8*8 ��ɫֱ��ͼ׮��
matrix = 1:1:v_count;
first = 1;
N = 500;    %��������
[SampleSet, SampleProbability, Estimate, targeHistgram] = testInitial(x, y, High, Wide, ImageBase, N)  %���Գ�ʼ���ӳ���
vx = 0;
vy = 0;
Wucha = zeros(1,300);

%����ѭ����ʼ
n = 300;    %ͼƬ����
for loop = 2:1:n
        loop
        a = num2str(loop+first-1);  %��ȡ��һ֡ͼƬ
        b = [a, '.jpg'];
        NewImage = imread(b);
            NewSampleSet = testSelect(SampleSet, SampleProbability, loop, NewImage, N);    %����������ѡ��(��Ҫ�Բ���SIR)
            [SampleSet,afterProp] = testPropagation(NewSampleSet, vx, vy, BaseHigh, BaseWide, NewImage, N, High, Wide);%%�����������100����ѡ����,���ն�̬ģ�ͽ����ݻ�
            [SamplePprobability, Estimate, vx, vy, TargetPic]=ObserveandEstimate(SampleSet, Estimate, targeHistgram, newSita,loop, afterProp, NewImage, N, first, High, Wide, x, y); %����
    imshow(TargetPic);
end

x= 1:1:300;
plot(x,Wucha);
Wucha = Wucha';
xlswrite('F:\CZC_PAPER\CODE\�����˲�\my_test2\Wucha.xlsx',Wucha);