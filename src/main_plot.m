fs=32; %����Ƶ��
fb=1;
fc=4; %�ز�Ƶ��,Ϊ���ڹ۲��ѵ��źţ����ǰ��ز�Ƶ����Ľϵ�
N=10000;
Kbase=2; % Kbase=1,�������������˲���ֱ�ӵ���;
% Kbase=2,�����������˲����˲����ٽ��е���
info=random_binary(N); %�����������ź�����
[y,I,Q]=qam(info,Kbase,fs,fb,fc); %�Ի����źŽ��� 16QAM ����
y1=y; y2=y; %�����źţ�������������
T=length(info)/fb; m=fs/fb; nn=length(info);
dt=1/fs; t=0:dt:T-dt;
subplot(211);
%���ڹ۲죬������ʾ���ѵ��źż���Ƶ�׾�Ϊ���������ŵ��������
%���ڲ����ź���Ԫ����Ϊ 10000 ��������������ֻ��ʾ�������� 1/10
plot(t(1:1000),y(1:1000),t(1:1000),I(1:1000),t(1:1000),Q(1:1000),[0 35],[0 0],'b:');
title('�ѵ��ź�(In:red,Qn:green)');
%����Ҷ�任������ѵ��źŵ�Ƶ��
n=length(y); y=fft(y)/n; y=abs(y(1:fix(n/2)))*2;
q=find(y<1e-04); y(q)=1e-04; y=20*log10(y);
f1=m/n; f=0:f1:(length(y)-1)*f1;
subplot(223);
plot(f,y,'r');
grid on;
title('�ѵ��ź�Ƶ��'); xlabel('f/fb');
%���� 16QAM ���Ʒ�ʽ��Ӧ������ͼ
subplot(224);
constel(y1,fs,fb,fc); title('����ͼ');
SNR_in_dB=8:2:24; %AWGN �ŵ������
for j=1:length(SNR_in_dB)
y_add_noise=awgn(y2,SNR_in_dB(j)); %���벻ͬǿ�ȵĸ�˹������
y_output=qamdet(y_add_noise,fs,fb,fc); %���ѵ��źŽ��н��
numoferr=0;
for i=1:N
if (y_output(i)~=info(i))
numoferr=numoferr+1;
end
end
Pe(j)=numoferr/N; %ͳ��������
end
figure;
semilogy(SNR_in_dB,Pe,'red*-');
grid on;
xlabel('SNR in dB');
ylabel('Pe');
title('16QAM �����ڲ�ͬ�ŵ�����ǿ���µ�������');