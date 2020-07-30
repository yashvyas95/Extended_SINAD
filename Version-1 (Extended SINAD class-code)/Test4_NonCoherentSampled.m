%TEST 4
%Non-COHERENT SAMPLED


Test_4_SINAD_Window_1 = [];
Test_4_SINAD_Window_2 = [];
Test_4_SINAD_Window_3 = [];
Test_4_SINAD_Window_4 = [];

Test_4_SINAD_Matlab = [];
Test_4_SINAD_Theroetical = [];
Test_4_Frequency = [];
Test_4_Sampling = [];
Test_4_No_Points = [];

SamplingRate = 4e3;
t = 0:1/1000:999;


Af = 3000;%250;500;2000;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));

%Matlab Inbuilt Sinad Calculated
matlabsinad = sinad(signal);

%Theoretical Sinad Calculated
thsinad = (10*log(1/(0.2.^2+0.05.^2)))/2


%Extended Sinad
[SINAD_Window_1] = SINAD.Extended(signal,SamplingRate,1);
[SINAD_Window_2] = SINAD.Extended(signal,SamplingRate,2);
[SINAD_Window_3] = SINAD.Extended(signal,SamplingRate,3);
[SINAD_Window_4] = SINAD.Extended(signal,SamplingRate,4);


Test_4_SINAD_Window_1 = [Test_4_SINAD_Window_1 SINAD_Window_1]
Test_4_SINAD_Window_2 = [Test_4_SINAD_Window_2 SINAD_Window_2]
Test_4_SINAD_Window_3 = [Test_4_SINAD_Window_3 SINAD_Window_3]
Test_4_SINAD_Window_4 = [Test_4_SINAD_Window_4 SINAD_Window_4]


Test_4_SINAD_Matlab = [Test_4_SINAD_Matlab matlabsinad]
Test_4_SINAD_Theroetical = [Test_4_SINAD_Theroetical thsinad]
Test_4_Frequency = [Test_4_Frequency Af]
Test_4_Sampling = [Test_4_Sampling SamplingRate];
Test_4_No_Points = [Test_4_No_Points length(signal)];

save('Test_4.mat','Test_4_SINAD_Window_1','Test_4_SINAD_Window_2','Test_4_SINAD_Window_3','Test_4_SINAD_Window_4','Test_4_SINAD_Matlab','Test_4_SINAD_Theroetical','Test_4_Frequency','Test_4_No_Points','Test_4_Frequency','Test_4_Sampling')

load('Test_4.mat','Test_4_SINAD_Window_1','Test_4_SINAD_Window_2','Test_4_SINAD_Window_3','Test_4_SINAD_Window_4','Test_4_SINAD_Matlab','Test_4_SINAD_Theroetical','Test_4_Frequency','Test_4_No_Points','Test_4_Frequency','Test_4_Sampling')

plot(Test_4_Frequency,Test_4_SINAD_Window_1,'--ok')
hold on
plot(Test_4_Frequency,Test_4_SINAD_Window_2,'--or')
plot(Test_4_Frequency,Test_4_SINAD_Window_3,'--om')
plot(Test_4_Frequency,Test_4_SINAD_Window_4,'--oc')


plot(Test_4_Frequency,Test_4_SINAD_Matlab,'--ob')
plot(Test_4_Frequency,Test_4_SINAD_Theroetical,'--og')
xlabel('Fundamental Frequency')
ylabel('SINAD')
legend({'black = Hamming Window','red = Kaiser Window','Magenta = Gaussian Window','Cyan = Hann Window','Blue = Matlab','Green = Theoretical Sinad'},'Location','southeast')
hold off


