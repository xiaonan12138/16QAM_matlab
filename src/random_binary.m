function [info]=random_binary(N)
if nargin == 0%���û�������������ָ����Ϣ����Ϊ 10000 ����Ԫ
N=10000;
end
for i=1:N
temp=rand;
if (temp<0.5)
info(i)=0; % 1/2 �ĸ������Ϊ 0
else
info(i)=1; % 1/2 �ĸ������Ϊ 1
end
end