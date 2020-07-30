%TEST 3
%COHERENT Sampled

Test_3_SINAD_Window_1 = [];
Test_3_SINAD_Window_2 = [];
Test_3_SINAD_Window_3 = [];
Test_3_SINAD_Window_4 = [];

Test_3_SINAD_Matlab = [];
Test_3_SINAD_Theroetical = [];
Test_3_Frequency = [];
Test_3_Sampling = [];
Test_3_No_Points = [];

SamplingRate = 4e3;
t = 0:1/SamplingRate:1-1/SamplingRate;


Af = 1250;%1000;%750;%500;%250;
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


Test_3_SINAD_Window_1 = [Test_3_SINAD_Window_1 SINAD_Window_1];
Test_3_SINAD_Window_2 = [Test_3_SINAD_Window_2 SINAD_Window_2];
Test_3_SINAD_Window_3 = [Test_3_SINAD_Window_3 SINAD_Window_3];
Test_3_SINAD_Window_4 = [Test_3_SINAD_Window_4 SINAD_Window_4];

Test_3_SINAD_Matlab = [Test_3_SINAD_Matlab matlabsinad]
Test_3_SINAD_Theroetical = [Test_3_SINAD_Theroetical thsinad]
Test_3_Frequency = [Test_3_Frequency Af]
Test_3_Sampling = [Test_3_Sampling SamplingRate];
Test_3_No_Points = [Test_3_No_Points length(signal)];

save('Test_3.mat','Test_3_SINAD_Window_1','Test_3_SINAD_Window_2','Test_3_SINAD_Window_3','Test_3_SINAD_Window_4','Test_3_SINAD_Matlab','Test_3_SINAD_Theroetical','Test_3_Frequency','Test_3_No_Points','Test_3_Frequency','Test_3_Sampling')

load('Test_3.mat','Test_3_SINAD_Window_1','Test_3_SINAD_Window_2','Test_3_SINAD_Window_3','Test_3_SINAD_Window_4','Test_3_SINAD_Matlab','Test_3_SINAD_Theroetical','Test_3_Frequency','Test_3_No_Points','Test_3_Frequency','Test_3_Sampling')

plot(Test_3_Frequency,Test_3_SINAD_Window_1,'--ok')
hold on
plot(Test_3_Frequency,Test_3_SINAD_Window_2,'--or')
plot(Test_3_Frequency,Test_3_SINAD_Window_3,'--om')
plot(Test_3_Frequency,Test_3_SINAD_Window_4,'--oc')


plot(Test_3_Frequency,Test_3_SINAD_Matlab,'--ob')
plot(Test_3_Frequency,Test_3_SINAD_Theroetical,'--og')
xlabel('Fundamental Frequency')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Cyan = Hann Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off
