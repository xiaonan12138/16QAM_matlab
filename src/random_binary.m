function [info]=random_binary(N)
if nargin == 0%如果没有输入参数，则指定信息序列为 10000 个码元
N=10000;
end
for i=1:N
temp=rand;
if (temp<0.5)
info(i)=0; % 1/2 的概率输出为 0
else
info(i)=1; % 1/2 的概率输出为 1
end
end