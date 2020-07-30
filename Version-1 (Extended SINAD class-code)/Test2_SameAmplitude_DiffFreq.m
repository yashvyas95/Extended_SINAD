%TEST 2
%SAME Amplitude DIFFERENT Freuqnecy

Test_2_SINAD_Window_1 = [];
Test_2_SINAD_Window_2 = [];
Test_2_SINAD_Window_3 = [];
Test_2_SINAD_Window_4 = [];

Test_2_SINAD_Matlab = [];
Test_2_SINAD_Theroetical = [];
Test_2_Frequency = [];

SamplingRate = 2.4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;
Af = 1000;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));



%Matlab Inbuilt Sinad Calculated
matlabsinad = sinad(signal);

%Theoretical Sinad Calculated
thsinad = (10*log(1/(0.2.^2+0.05.^2)))/2

%Extended Sinad
[SINAD_Window_1] = SINAD.Extended(signal,SamplingRate,1,Af);
[SINAD_Window_2] = SINAD.Extended(signal,SamplingRate,2,Af);
[SINAD_Window_3] = SINAD.Extended(signal,SamplingRate,3,Af);
[SINAD_Window_4] = SINAD.Extended(signal,SamplingRate,4,Af);


Test_2_SINAD_Window_1 = [Test_2_SINAD_Window_1 SINAD_Window_1]
Test_2_SINAD_Window_2 = [Test_2_SINAD_Window_2 SINAD_Window_2]
Test_2_SINAD_Window_3 = [Test_2_SINAD_Window_3 SINAD_Window_3]
Test_2_SINAD_Window_4 = [Test_2_SINAD_Window_4 SINAD_Window_4]


Test_2_SINAD_Matlab = [Test_2_SINAD_Matlab matlabsinad]
Test_2_SINAD_Theroetical = [Test_2_SINAD_Theroetical thsinad]

Test_2_Frequency = [Test_2_Frequency Af]

save('Test_2.mat','Test_2_SINAD_Window_1','Test_2_SINAD_Window_2','Test_2_SINAD_Window_3','Test_2_SINAD_Window_4','Test_2_SINAD_Matlab','Test_2_SINAD_Theroetical','Test_2_Frequency')

load('Test_2.mat','Test_2_SINAD_Window_1','Test_2_SINAD_Window_2','Test_2_SINAD_Window_3','Test_2_SINAD_Window_4','Test_2_SINAD_Matlab','Test_2_SINAD_Theroetical','Test_2_Frequency')

plot(Test_2_Frequency,Test_2_SINAD_Window_1,'--ok')
hold on
plot(Test_2_Frequency,Test_2_SINAD_Window_2,'--or')
plot(Test_2_Frequency,Test_2_SINAD_Window_3,'--om')
plot(Test_2_Frequency,Test_2_SINAD_Window_4,'--oc')


plot(Test_2_Frequency,Test_2_SINAD_Matlab,'--ob')
plot(Test_2_Frequency,Test_2_SINAD_Theroetical,'--og')
xlabel('Fundamental Frequency')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Cyan = Hann Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off
