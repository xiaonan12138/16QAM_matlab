fs=32; %抽样频率
fb=1;
fc=4; %载波频率,为便于观察已调信号，我们把载波频率设的较低
N=10000;
Kbase=2; % Kbase=1,不经基带成形滤波，直接调制;
% Kbase=2,基带经成形滤波器滤波后，再进行调制
info=random_binary(N); %产生二进制信号序列
[y,I,Q]=qam(info,Kbase,fs,fb,fc); %对基带信号进行 16QAM 调制
y1=y; y2=y; %备份信号，供后续仿真用
T=length(info)/fb; m=fs/fb; nn=length(info);
dt=1/fs; t=0:dt:T-dt;
subplot(211);
%便于观察，这里显示的已调信号及其频谱均为无噪声干扰的理想情况
%由于测试信号码元数量为 10000 个，在这里我们只显示其总数的 1/10
plot(t(1:1000),y(1:1000),t(1:1000),I(1:1000),t(1:1000),Q(1:1000),[0 35],[0 0],'b:');
title('已调信号(In:red,Qn:green)');
%傅里叶变换，求出已调信号的频谱
n=length(y); y=fft(y)/n; y=abs(y(1:fix(n/2)))*2;
q=find(y<1e-04); y(q)=1e-04; y=20*log10(y);
f1=m/n; f=0:f1:(length(y)-1)*f1;
subplot(223);
plot(f,y,'r');
grid on;
title('已调信号频谱'); xlabel('f/fb');
%画出 16QAM 调制方式对应的星座图
subplot(224);
constel(y1,fs,fb,fc); title('星座图');
SNR_in_dB=8:2:24; %AWGN 信道信噪比
for j=1:length(SNR_in_dB)
y_add_noise=awgn(y2,SNR_in_dB(j)); %加入不同强度的高斯白噪声
y_output=qamdet(y_add_noise,fs,fb,fc); %对已调信号进行解调
numoferr=0;
for i=1:N
if (y_output(i)~=info(i))
numoferr=numoferr+1;
end
end
Pe(j)=numoferr/N; %统计误码率
end
figure;
semilogy(SNR_in_dB,Pe,'red*-');
grid on;
xlabel('SNR in dB');
ylabel('Pe');
title('16QAM 调制在不同信道噪声强度下的误码率');