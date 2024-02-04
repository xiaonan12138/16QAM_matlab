function [y,I,Q]=qam(x,Kbase,fs,fb,fc)
%
T=length(x)/fb; m=fs/fb; nn=length(x);
dt=1/fs; t=0:dt:T-dt;
%串/并变换分离出 I 分量、Q 分量，然后再分别进行电平映射
I=x(1:2:nn-1); [I,~]=two2four(I,4*m);
Q=x(2:2:nn); [Q,~]=two2four(Q,4*m);
if Kbase==2 %基带成形滤波
I=bshape(I,fs,fb/4); Q=bshape(Q,fs,fb/4);
end
y=I.*cos(2*pi*fc*t)-Q.*sin(2*pi*fc*t); %调制