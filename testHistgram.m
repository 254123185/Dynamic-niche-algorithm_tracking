%��ȡĿ��ͼ�����ɫֱ��ͼ��Ϣ��
%�����������ΪĿ�������������x��������y����ߣ����ȣ�����ͼ��
%�������Ϊ��ɫ�ֲ�ģ��
function bin = testHistgram(x, y, High, Wide, I)
global v_count; %Ϊ�����еĲ���m��Ŀǰѡ�����ͼ���е����ظ���
global matrix;
bin = zeros(1, v_count);

normalizationConstant = (High.^2 + Wide^2).^0.5;    %���������С
pixel_Constant = normalizationConstant;
Constant = 0;   %��һ������
r = 0;  %���������ĵĿռ����
count = 0;


    for pixel_x = round(x-High/2) : 1 : floor(x+High/2)
        for pixel_y = round(y-Wide/2) : 1 : floor(y+Wide/2)     %��ΧΪ���ٿ���
            if(((x - pixel_x).^2)/High + ((y - pixel_y).^2)/Wide < 1)    %Ŀ��㵽���ĵĿռ�����볣����ֵС��1
            r = ((x - pixel_x).^2 + (y - pixel_y).^2).^0.5/normalizationConstant;            
            k = 1 - r.^2;    %�ռ���Ϣ�ںϺ���
            %k=exp((-1/2)*r^2)��ѡ������˹�˺�����Ŀ���������������Ȩ�ظ�
            R = double(I(pixel_x, pixel_y, 1));
            G = double(I(pixel_x, pixel_y, 2));
            B = double(I(pixel_x, pixel_y, 3));     %R��G��B����
            a1 = floor(R/32);   %floor�ȸ�ֵС�Ҿ��������һ��������
            a2 = floor(G/32);   %ÿ��ͨ������Ϊ32������
            a3 = floor(B/32);
            bin_id = matrix(a1*64+a2*8+a3+1);
            bin(bin_id) = bin(bin_id) + k;  %��Ӧ����ɫ���ϸ�����ɫֵ
            Constant = Constant + k;
            end
        end
    end
dConstant = 1/Constant;
next = 1:1:v_count;
bin(next) = dConstant*bin(next);    %�����ɫ�ֲ�ģ��