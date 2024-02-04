function y=bshape(x,fs,fb,N,alfa,~)
%设置默认参数
if nargin<6; delay=8; end
if nargin<5; alfa=0.5; end
if nargin<4; N=16; end
b=firrcos(N,fb,2*alfa*fb,fs);
y=filter(b,1,x);