function [y,yn]=two2four(x,m)
T=[0 1;3 2]; n=length(x); ii=1;
for i=1:2:n-1
xi=x(i:i+1)+1;
yn(ii)=T(xi(1),xi(2));
ii=ii+1;
end
yn=yn-1.5; y=yn;
for i=1:m-1
y=[y;yn];
end
y=y(:)'; %ӳ���ƽ�ֱ�Ϊ-1.5��0.5��0.5��1.5