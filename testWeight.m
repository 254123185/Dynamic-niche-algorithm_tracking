function w = testWeight(p,q,sita)
m = 512;
simi = 0;
for i = 1:m
    simi = simi + (p(i) * q(i)).^0.5;    %ģ��ֱ��ͼ�� qΪģ�����ɫ�ֲ�ģ�ͣ�pΪĳһ���ĵ���ɫֱ��ͼ��Bhattacharyyaϵ������
end
d = (1 - simi).^0.5;
 w=(1/(sita*(2*pi).^0.5))*exp(-(d.^2)/(2*sita.^2));   %p��z/x��=(1/(sita*(2*pi)^0.5))*exp(-(d^2)/(2*sita^2))Ϊ�����ӵ�Ȩֵ��������sitaͨ��ȡΪ0.2
% w = exp(-(d.^2)/(2*sita.^2));
return