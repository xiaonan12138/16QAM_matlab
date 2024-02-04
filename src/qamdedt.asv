function [xn,x]=qamdet(y,fs,fb,fc);
dt=1/fs; t=0:dt:(length(y)-1)*dt;
I=y.*cos(2*pi*fc*t);
Q=-y.*sin(2*pi*fc*t);
[b,a]=butter(2,2*fb/fs); %设计巴特沃斯滤波器
I=filtfilt(b,a,I);
Q=filtfilt(b,a,Q);
m=4*fs/fb; N=length(y)/m; n=(.6:1:N)*m; n=fix(n);
In=I(n); Qn=Q(n); xn=four2two([In Qn]);
%I 分量 Q 分量并/串转换，最终恢复成码元序列 xn
nn=length(xn);
xn=xn(:);
xn=[xn(1:nn/2);xn(nn/2+1:nn)];
xn=xn';[6]