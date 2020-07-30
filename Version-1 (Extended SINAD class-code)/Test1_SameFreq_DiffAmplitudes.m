%TEST 1
%----SAME FREQUENCY DIFFERENT AMPLITUDES
%----SamplingRate = 2.4 Hz | Fundamental_Frequency = 250 Hz | Fundamental_Amplitude = 1
%----Harmonic added at frequency 1000 Hz with Amplitude 0.4

Test_1_SINAD_Window_1 = [];
Test_1_SINAD_Window_2 = [];
Test_1_SINAD_Window_3 = [];
Test_1_SINAD_Window_4 = [];

Test_1_SINAD_Matlab = [];
Test_1_SINAD_Theroetical = [];
Test_1_Amplitude = [];

SamplingRate = 2.4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;
Am = 1.1; %0.9 %0.7; %0.5; %0.3;
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
[SINAD_Window_1] = SINAD.Extended(signal,SamplingRate,1,1000);
[SINAD_Window_2] = SINAD.Extended(signal,SamplingRate,2,1000);
[SINAD_Window_3] = SINAD.Extended(signal,SamplingRate,3,1000);
[SINAD_Window_4] = SINAD.Extended(signal,SamplingRate,4,1000);

Test_1_SINAD_Window_1 = [Test_1_SINAD_Window_1 SINAD_Window_1]
Test_1_SINAD_Window_2 = [Test_1_SINAD_Window_2 SINAD_Window_2]
Test_1_SINAD_Window_3 = [Test_1_SINAD_Window_3 SINAD_Window_3]
Test_1_SINAD_Window_4 = [Test_1_SINAD_Window_4 SINAD_Window_4]

Test_1_SINAD_Matlab = [Test_1_SINAD_Matlab matlabsinad]
Test_1_SINAD_Theroetical = [Test_1_SINAD_Theroetical thsinad]

Test_1_Amplitude = [Test_1_Amplitude Am]

save('Test_1.mat','Test_1_SINAD_Window_1','Test_1_SINAD_Window_2','Test_1_SINAD_Window_3','Test_1_SINAD_Window_4','Test_1_SINAD_Matlab','Test_1_SINAD_Theroetical','Test_1_Amplitude')

load('Test_1.mat','Test_1_SINAD_Window_1','Test_1_SINAD_Window_2','Test_1_SINAD_Window_3','Test_1_SINAD_Window_4','Test_1_SINAD_Matlab','Test_1_SINAD_Theroetical','Test_1_Amplitude')

plot(Test_1_Amplitude,Test_1_SINAD_Window_1,'--ok')
hold on
plot(Test_1_Amplitude,Test_1_SINAD_Window_2,'--or')
plot(Test_1_Amplitude,Test_1_SINAD_Window_3,'--om')
plot(Test_1_Amplitude,Test_1_SINAD_Window_4,'--oy')

plot(Test_1_Amplitude,Test_1_SINAD_Matlab,'--ob')
plot(Test_1_Amplitude,Test_1_SINAD_Theroetical,'--og')
xlabel('Fundamental Amplitude')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Yellow = Hann Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off
