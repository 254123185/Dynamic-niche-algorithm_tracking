%���������ز���������ΪSIR����
function NewSampleSet = testSelect(SampleSet, SampleProbability, loop, NewImage, N)

CProbability(1) = SampleProbability(1); %0.98

for i = 2:N
    CProbability(i) = SampleProbability(i) + CProbability(i - 1);
end

for i = 1:N
    CumulativeProbability(i) = CProbability(i)/CProbability(N);
end
% for i = 1:N;
%     CumulativeProbability(i) = i/N;
% end
Y = rand(1,N);  %���������
for i = 1:N
    j = min(find(CumulativeProbability >= Y(i)));
    NewSampleSet(i) = SampleSet(j);
end