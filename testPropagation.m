function [SampleSet, afterProp]=testPropagation(NewSampleSet, vx, vy, BaseHigh, BaseWide, NewImage, N, High, Wide)

%������������
sigmax = 10;
sigmay = 10;

afterProp = NewImage;

rn = random('Normal', vx, sigmax, 1, 3000*N);    %1*300000���������
rn2 = random('Normal', vy, sigmay, 1, 3000*N);
count = 1;
i = 1;
while count <= N
    
    currentx = NewSampleSet(count).x;
    currenty = NewSampleSet(count).y;
    


    randx = rn(i);
    randy = rn2(i);

    if(i >= 3000*N-1)
        i = 1;
        rn = random('Normal', vx, sigmax, 1, 3000*N);
        rn2 = random('Normal', vy, sigmay, 1, 3000*N);
    end
    if( floor(currentx+randx+High/2)>BaseHigh || floor(currenty+randy+Wide/2)>BaseWide || currentx+randx < round(High/2) || currenty+randy < round(Wide/2))  %%������ͼ�������
        i = i + 1;
        randx = rn(i);  %�����������
        randy = rn2(i);
    else
        i = 1;
        rn = random('Normal', vx, sigmax, 1, 3000*N);
        rn2 = random('Normal', vy, sigmay, 1, 3000*N);
    end
    
    SampleSet(count).x = round(currentx + randx);  %һ���Իع�ģ��
    SampleSet(count).y = round(currenty + randy);
    count = count + 1;
    i = i + 1;
end

% js = 1;
% for js = 1:1:N
%     afterProp(SampleSet(js).x, SampleSet(js).y, 1) = 255;
%     afterProp(SampleSet(js).x, SampleSet(js).y, 2) = 0;
%     afterProp(SampleSet(js).x, SampleSet(js).y, 3) = 0;
% end