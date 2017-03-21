function w = testWeight(p,q,sita)
m = 512;
simi = 0;
for i = 1:m
    simi = simi + (p(i) * q(i)).^0.5;    %模板直方图， q为模板的颜色分布模型，p为某一中心的颜色直方图，Bhattacharyya系数度量
end
d = (1 - simi).^0.5;
 w=(1/(sita*(2*pi).^0.5))*exp(-(d.^2)/(2*sita.^2));   %p（z/x）=(1/(sita*(2*pi)^0.5))*exp(-(d^2)/(2*sita^2))为该粒子的权值，均方差sita通常取为0.2
% w = exp(-(d.^2)/(2*sita.^2));
return