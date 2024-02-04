function c=constel(x,fs,fb,fc)
N=length(x); m=2*fs/fb; n=fs/fc;
i1=m-n; i=1; ph0=(i1-1)*2*pi/n;
while i <= N/m
xi=x(i1:i1+n-1);
y=2*fft(xi)/n; c(i)=y(2);
i=i+1; i1=i1+m;
end
%如果无输出，则作图
if nargout<1
cmax=max(abs(c));
ph=(0:5:360)*pi/180;
plot(1.414*cos(ph),1.414*sin(ph),'c');
hold on;
for i=1:length(c)
ph=ph0-angle(c(i));
a=abs(c(i))/cmax*1.414;
plot(a*cos(ph),a*sin(ph),'r*');
end
plot([-1.5 1.5],[0 0],'k:',[0 0],[-1.5 1.5],'k:');
hold off; axis equal; axis([-1.5 1.5 -1.5 1.5]);
end