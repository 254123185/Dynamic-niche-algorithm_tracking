clc, clear
%way = 'D:\2HXX\CZC_PAPER\CODE\�����˲�\TestVideo\Girl\';
%readname = [way,'1.bmp']
%ImageBase = imread(readname);
%imshow(ImageBase);
%rect = getrect();
%x1 = rect(2); x2 = rect(2) + rect(4);High = round(rect(4));    %�õ����������ݣ�HighΪ���
%y1 = rect(1); y2 = rect(1) + rect(3);Wide = round(rect(3));    %�õ����������ݣ�WideΪ���
%x = round((x1 + x2)/2);
%y = round((y1 + y2)/2);     %����������ĵ�����
%After = huading(ImageBase, x, y, High, Wide);   %�õ��µĻ������ͼ������
seq=struct('name','Singer1','path','D:\data_seq\Singer1\','startFrame',1,'endFrame',500,'nz',4,'ext','jpg','init_rect',  [53,51	,290,87]);
seq.len = seq.endFrame - seq.startFrame + 1;
seq.s_frames = cell(seq.len,1);
nz	= strcat('%0',num2str(seq.nz),'d'); %number of zeros in the name of image
for i=1:seq.len
    image_no = seq.startFrame + (i-1);
    id = sprintf(nz,image_no);
    seq.s_frames{i} = strcat(seq.path,'img\',id,'.',seq.ext); % add 'img/' in every image path
end
s_frames = seq.s_frames;
newSita = 0.2;
global v_count;
global matrix;
global first;
v_count = 512;  %8*8*8 ��ɫֱ��ͼ׮��
matrix = 1:1:v_count;
first = 1;
N = 100;    %��������
ImageBase=imread(char(s_frames(1)));
[BaseHigh, BaseWide, CRGB] = size(ImageBase);
x=floor(53+290/2);y=floor(51+87/2);
Wide=87;High=290;
imshow(ImageBase);
[SampleSet, SampleProbability, Estimate, targeHistgram] = testInitial(x, y, High, Wide, ImageBase, N)  %���Գ�ʼ���ӳ���;
vx = 0;
vy = 0;
for loop = 2:1:seq.len
       b=imread(char(s_frames(loop)));
      %  NewImage = imread(b);
        NewImage = b;
            NewSampleSet = testSelect(SampleSet, SampleProbability, loop, NewImage, N);    %����������ѡ��(��Ҫ�Բ���SIR)
            [SampleSet,afterProp] = testPropagation(NewSampleSet, vx, vy, BaseHigh, BaseWide, NewImage, N, High, Wide);%%�����������100����ѡ����,���ն�̬ģ�ͽ����ݻ�
            [SamplePprobability, Estimate, vx, vy, TargetPic]=ObserveandEstimate(SampleSet, Estimate, targeHistgram, newSita,loop, afterProp, NewImage, N, first, High, Wide, x, y); %����
    imshow(TargetPic);
end
