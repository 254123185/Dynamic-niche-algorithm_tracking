clc, clear
%way = 'D:\2HXX\CZC_PAPER\CODE\粒子滤波\TestVideo\Girl\';
%readname = [way,'1.bmp']
%ImageBase = imread(readname);
%imshow(ImageBase);
%rect = getrect();
%x1 = rect(2); x2 = rect(2) + rect(4);High = round(rect(4));    %得到纵坐标数据，High为框高
%y1 = rect(1); y2 = rect(1) + rect(3);Wide = round(rect(3));    %得到横坐标数据，Wide为框宽
%x = round((x1 + x2)/2);
%y = round((y1 + y2)/2);     %划定框的中心点坐标
%After = huading(ImageBase, x, y, High, Wide);   %得到新的划定框的图像数据
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
v_count = 512;  %8*8*8 颜色直方图桩数
matrix = 1:1:v_count;
first = 1;
N = 100;    %粒子数量
ImageBase=imread(char(s_frames(1)));
[BaseHigh, BaseWide, CRGB] = size(ImageBase);
x=floor(53+290/2);y=floor(51+87/2);
Wide=87;High=290;
imshow(ImageBase);
[SampleSet, SampleProbability, Estimate, targeHistgram] = testInitial(x, y, High, Wide, ImageBase, N)  %测试初始化子程序;
vx = 0;
vy = 0;
for loop = 2:1:seq.len
       b=imread(char(s_frames(loop)));
      %  NewImage = imread(b);
        NewImage = b;
            NewSampleSet = testSelect(SampleSet, SampleProbability, loop, NewImage, N);    %采样方法的选择(重要性采样SIR)
            [SampleSet,afterProp] = testPropagation(NewSampleSet, vx, vy, BaseHigh, BaseWide, NewImage, N, High, Wide);%%随机采样产生100个候选粒子,按照动态模型进行演化
            [SamplePprobability, Estimate, vx, vy, TargetPic]=ObserveandEstimate(SampleSet, Estimate, targeHistgram, newSita,loop, afterProp, NewImage, N, first, High, Wide, x, y); %更新
    imshow(TargetPic);
end
