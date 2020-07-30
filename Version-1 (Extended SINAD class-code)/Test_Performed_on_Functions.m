%FUNCTION Extended/EXTENDED SINAD
%FOLLOWING FUNCTION IS PREPARED AS INDIVIDUAL PROJECT IN GUIDANCE OF :PROF DR PECH
%AUTHOR/STUDENT : YASH VYAS 1266490
%ASSUMPTIONS FOR THE DATA : DATA IS SAMPLED AT NYQUIST FREQUENCY OR
%GREATER
%FUNCTION PARAMETER : SIGNAL DATA,SAMPLINGRATE,WINDOWING
%SIGNAL DATA = TIME DOMAIN DATA 
%SAMPLING RATE = SAMPLING RATE OF SIGNAL
%WINDOWING = 1.HAMMING , 2.KAISER , 3.GAUSSIAN
%FUNCTION SIMPLE/EXTENDED SINAD
%FOLLOWING FUNCTION IS PREPARED AS INDIVIDUAL PROJECT IN GUIDANCE OF :PROF DR PECH
%AUTHOR/STUDENT : YASH VYAS 1266490
%ASSUMPTIONS FOR THE DATA : DATA IS SAMPLED AT NYQUIST FREQUENCY OR
%GREATER
%FUNCTION PARAMETER : SIGNAL DATA,SAMPLINGRATE,WINDOWING
%SIGNAL DATA = TIME DOMAIN DATA 
%SAMPLING RATE = SAMPLING RATE OF SIGNAL
%WINDOWING = 1.HAMMING , 2.KAISER , 3.GAUSSIAN
%INPUT FREQUENCY = numeric

%TEST 1
%SAME FREQUENCY DIFFERENT AMPLITUDES
%SamplingRate = 2.4 Hz | Fundamental_Frequency = 250 Hz | Fundamental_Amplitude = 1
%Harmonic added at frequency 1000 Hz with Amplitude 0.4

Test_1_SINAD_Window_1 = [];
Test_1_SINAD_Window_2 = [];
Test_1_SINAD_Window_3 = [];
Test_1_SINAD_Matlab = [];
Test_1_SINAD_Theroetical = [];
Test_1_Amplitude = [];

SamplingRate = 2.4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;
Am = 0.3;
signal = 0.2*sin(2*pi*250*t)+Am*sin(2*pi*1000*t)+0.05*randn(size(t));

%   signal = 1.2*cos(2*pi*250*t)+0.2*sin(2*pi*1000*t);
%   signal = 1.4*cos(2*pi*250*t)+0.4*sin(2*pi*1000*t);
%   signal = 0.8*cos(2*pi*250*t)+0.6*sin(2*pi*1000*t);
%   signal = 1*cos(2*pi*250*t)+0.8*sin(2*pi*1000*t);
%   signal = 0.9*cos(2*pi*250*t)+0.9*sin(2*pi*1000*t);

%Matlab Inbuilt Sinad Calculated
matlabsinad = sinad(signal);

%Theoretical Sinad Calculated
thsinad = (10*log(Am/(0.2.^2+0.05.^2)))/2

%Extended Sinad
[SINAD_Window_1] = ExtendedSINAD(signal,SamplingRate,1,1000);
[SINAD_Window_2] = ExtendedSINAD(signal,SamplingRate,2,1000);
[SINAD_Window_3] = ExtendedSINAD(signal,SamplingRate,3,1000);


Test_1_SINAD_Window_1 = [Test_1_SINAD_Window_1 SINAD_Window_1]
Test_1_SINAD_Window_2 = [Test_1_SINAD_Window_2 SINAD_Window_2]
Test_1_SINAD_Window_3 = [Test_1_SINAD_Window_3 SINAD_Window_3]
Test_1_SINAD_Matlab = [Test_1_SINAD_Matlab matlabsinad]
Test_1_SINAD_Theroetical = [Test_1_SINAD_Theroetical thsinad]

Test_1_Amplitude = [Test_1_Amplitude Am]

%save('Test_1.mat','Test_1_SINAD_Window_1','Test_1_SINAD_Window_2','Test_1_SINAD_Window_3','Test_1_SINAD_Matlab','Test_1_SINAD_Theroetical','Test_1_Amplitude')

load('Test_1.mat','Test_1_SINAD_Window_1','Test_1_SINAD_Window_2','Test_1_SINAD_Window_3','Test_1_SINAD_Matlab','Test_1_SINAD_Theroetical','Test_1_Amplitude')

plot(Test_1_Amplitude,Test_1_SINAD_Window_1,'--ok')
hold on
plot(Test_1_Amplitude,Test_1_SINAD_Window_2,'--or')
plot(Test_1_Amplitude,Test_1_SINAD_Window_3,'--om')

plot(Test_1_Amplitude,Test_1_SINAD_Matlab,'--ob')
plot(Test_1_Amplitude,Test_1_SINAD_Theroetical,'--og')
xlabel('Fundamental Amplitude')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off

%TEST 2
%SAME Amplitude DIFFERENT Freuqnecy

Test_2_SINAD_Window_1 = [];
Test_2_SINAD_Window_2 = [];
Test_2_SINAD_Window_3 = [];
Test_2_SINAD_Matlab = [];
Test_2_SINAD_Theroetical = [];
Test_2_Frequency = [];

SamplingRate = 2.4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;
Af = 200;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));



%Matlab Inbuilt Sinad Calculated
matlabsinad = sinad(signal);

%Theoretical Sinad Calculated
thsinad = (10*log(1/(0.2.^2+0.05.^2)))/2

%Extended Sinad
[SINAD_Window_1] = ExtendedSINAD2(signal,SamplingRate,1,[1000]);
[SINAD_Window_2] = ExtendedSINAD(signal,SamplingRate,2);
[SINAD_Window_3] = ExtendedSINAD(signal,SamplingRate,3);

%Detailed Sinad
[SINAD2,ENOB,THD] = SINAD_detailed(signal,SamplingRate,1000,2);

Test_2_SINAD_Window_1 = [Test_2_SINAD_Window_1 SINAD_Window_1]
Test_2_SINAD_Window_2 = [Test_2_SINAD_Window_2 SINAD_Window_2]
Test_2_SINAD_Window_3 = [Test_2_SINAD_Window_3 SINAD_Window_3]
Test_2_SINAD_Matlab = [Test_2_SINAD_Matlab matlabsinad]
Test_2_SINAD_Theroetical = [Test_2_SINAD_Theroetical thsinad]

Test_2_Frequency = [Test_2_Frequency Af]

save('Test_2.mat','Test_2_SINAD_Window_1','Test_2_SINAD_Window_2','Test_2_SINAD_Window_3','Test_2_SINAD_Matlab','Test_2_SINAD_Theroetical','Test_2_Frequency')

load('Test_2.mat','Test_2_SINAD_Window_1','Test_2_SINAD_Window_2','Test_2_SINAD_Window_3','Test_2_SINAD_Matlab','Test_2_SINAD_Theroetical','Test_2_Frequency')

plot(Test_2_Frequency,Test_2_SINAD_Window_1,'--ok')
hold on
plot(Test_2_Frequency,Test_2_SINAD_Window_2,'--or')
plot(Test_2_Frequency,Test_2_SINAD_Window_3,'--om')

plot(Test_2_Frequency,Test_2_SINAD_Matlab,'--ob')
plot(Test_2_Frequency,Test_2_SINAD_Theroetical,'--og')
xlabel('Fundamental Frequency')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off


%TEST 3
%COHERENT Sampled

Test_3_SINAD_Window_1 = [];
Test_3_SINAD_Window_2 = [];
Test_3_SINAD_Window_3 = [];
Test_3_SINAD_Matlab = [];
Test_3_SINAD_Theroetical = [];
Test_3_Frequency = [];
Test_3_Sampling = [];
Test_3_No_Points = [];

SamplingRate = 4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;


Af = 2000;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));

%Matlab Inbuilt Sinad Calculated
matlabsinad = sinad(signal);

%Theoretical Sinad Calculated
thsinad = (10*log(1/(0.2.^2+0.05.^2)))/2


%Extended Sinad
[SINAD_Window_1] = ExtendedSINAD(signal,SamplingRate,1);
[SINAD_Window_2] = ExtendedSINAD(signal,SamplingRate,2);
[SINAD_Window_3] = ExtendedSINAD(signal,SamplingRate,3);


Test_3_SINAD_Window_1 = [Test_3_SINAD_Window_1 SINAD_Window_1];
Test_3_SINAD_Window_2 = [Test_3_SINAD_Window_2 SINAD_Window_2];
Test_3_SINAD_Window_3 = [Test_3_SINAD_Window_3 SINAD_Window_3]
Test_3_SINAD_Matlab = [Test_3_SINAD_Matlab matlabsinad]
Test_3_SINAD_Theroetical = [Test_3_SINAD_Theroetical thsinad]
Test_3_Frequency = [Test_3_Frequency Af]
Test_3_Sampling = [Test_3_Sampling SamplingRate];
Test_3_No_Points = [Test_3_No_Points length(signal)];

save('Test_3.mat','Test_3_SINAD_Window_1','Test_3_SINAD_Window_2','Test_3_SINAD_Window_3','Test_3_SINAD_Matlab','Test_3_SINAD_Theroetical','Test_3_Frequency','Test_3_No_Points','Test_3_Frequency','Test_3_Sampling')

load('Test_3.mat','Test_3_SINAD_Window_1','Test_3_SINAD_Window_2','Test_3_SINAD_Window_3','Test_3_SINAD_Matlab','Test_3_SINAD_Theroetical','Test_3_Frequency','Test_3_No_Points','Test_3_Frequency','Test_3_Sampling')

plot(Test_3_Frequency,Test_3_SINAD_Window_1,'--ok')
hold on
plot(Test_3_Frequency,Test_3_SINAD_Window_2,'--or')
plot(Test_3_Frequency,Test_3_SINAD_Window_3,'--om')

plot(Test_3_Frequency,Test_3_SINAD_Matlab,'--ob')
plot(Test_3_Frequency,Test_3_SINAD_Theroetical,'--og')
xlabel('Fundamental Frequency')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off



%TEST 4
%Non-COHERENT SAMPLED


Test_4_SINAD_Window_1 = [];
Test_4_SINAD_Window_2 = [];
Test_4_SINAD_Window_3 = [];
Test_4_SINAD_Matlab = [];
Test_4_SINAD_Theroetical = [];
Test_4_Frequency = [];
Test_4_Sampling = [];
Test_4_No_Points = [];

SamplingRate = 4e3;
t = 0:1/1000:999;


Af = 3000;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));

%Matlab Inbuilt Sinad Calculated
matlabsinad = sinad(signal);

%Theoretical Sinad Calculated
thsinad = (10*log(1/(0.2.^2+0.05.^2)))/2


%Extended Sinad
[SINAD_Window_1] = ExtendedSINAD(signal,SamplingRate,1);
[SINAD_Window_2] = ExtendedSINAD(signal,SamplingRate,2);
[SINAD_Window_3] = ExtendedSINAD(signal,SamplingRate,3);


Test_4_SINAD_Window_1 = [Test_4_SINAD_Window_1 SINAD_Window_1]
Test_4_SINAD_Window_2 = [Test_4_SINAD_Window_2 SINAD_Window_2]
Test_4_SINAD_Window_3 = [Test_4_SINAD_Window_3 SINAD_Window_3]
Test_4_SINAD_Matlab = [Test_4_SINAD_Matlab matlabsinad]
Test_4_SINAD_Theroetical = [Test_4_SINAD_Theroetical thsinad]
Test_4_Frequency = [Test_4_Frequency Af]
Test_4_Sampling = [Test_4_Sampling SamplingRate];
Test_4_No_Points = [Test_4_No_Points length(signal)];

save('Test_4.mat','Test_4_SINAD_Window_1','Test_4_SINAD_Window_2','Test_4_SINAD_Window_3','Test_4_SINAD_Matlab','Test_4_SINAD_Theroetical','Test_4_Frequency','Test_4_No_Points','Test_4_Frequency','Test_4_Sampling')

load('Test_4.mat','Test_4_SINAD_Window_1','Test_4_SINAD_Window_2','Test_4_SINAD_Window_3','Test_4_SINAD_Matlab','Test_4_SINAD_Theroetical','Test_4_Frequency','Test_4_No_Points','Test_4_Frequency','Test_4_Sampling')

plot(Test_4_Frequency,Test_4_SINAD_Window_1,'--ok')
hold on
plot(Test_4_Frequency,Test_4_SINAD_Window_2,'--or')
plot(Test_4_Frequency,Test_4_SINAD_Window_3,'--om')

plot(Test_4_Frequency,Test_4_SINAD_Matlab,'--ob')
plot(Test_4_Frequency,Test_4_SINAD_Theroetical,'--og')
xlabel('Fundamental Frequency')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off



%TEST 5 
%ERRORS

%1 Negative Sampling Rate
SamplingRate = -20;

%2 SIgnal data as improper vector

x = sin(2*pi*0*0)
y = SINAD_detailed(1)

%3 GIVING improper WINDOWING OPTION

SamplingRate = 4e3;
t = 0:1/SamplingRate:1;
Af = 1500;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));
y = SINAD_Extended(signal,SamplingRate,1)

%TEST6
%EXTENDED SINAD

SamplingRate = 4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;
Af = 1000;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));

sinadExtended1 = ExtendedSINAD(signal,SamplingRate,1,999)
sinadExtended2 = ExtendedSINAD(signal,SamplingRate,1,1000)
sinadExtended3 = ExtendedSINAD(signal,SamplingRate,1,1001)
final = sinadExtended1+sinadExtended2+sinadExtended3
x = [999,1000,1000001.22222]; 
sinadExtended = ExtendedSINAD2(signal,SamplingRate,1,x)
matlabSINAD = sinad(signal)
thsinad = 10*log(1/((0.2).^2 + (0.05).^2))/2
