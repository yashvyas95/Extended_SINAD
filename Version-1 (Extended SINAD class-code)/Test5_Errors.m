%TEST 5 
%ERRORS

%1 Negative Sampling Rate

SamplingRate = -4e3;
t = 0:1/SamplingRate:1;
Af = 1500;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));
y = SINAD.Extended(signal,SamplingRate,1)

%2 GIVING improper WINDOWING OPTION

SamplingRate = 4e3;
t = 0:1/SamplingRate:1;
Af = 1500;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));
y = SINAD.Extended(signal,SamplingRate,-2)

%3 Giving Improper Input Frequency

SamplingRate = 4e3;
t = 0:1/SamplingRate:1;
Af = 1500;
signal = 0.2*sin(2*pi*50*t)+1*sin(2*pi*Af*t)+0.05*randn(size(t));
y = SINAD.Extended(signal,SamplingRate,1,20)
