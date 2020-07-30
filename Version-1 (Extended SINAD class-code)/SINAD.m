classdef SINAD
    
%------SINAD Class
%------3 FUNCTIONS : a)Classical version b)Extended version c)ExtendedBundled version  
%------Individual Project SS2020
%------Guide : Prof. Dr. Pech
%------Created By : Yash vyas 1266490

  
    properties
    end
    
    methods (Static = true)
        
        function [Sinad_ratio,fundamental_frequency,frequencies_present] = Classical(signalData,SamplingRate,Windowing)
        
            switch nargin
                case 3  % Checking Window Argument
                    switch Windowing
                        case 1
                            signalWindowed = signalData(:).*hamming(length(signalData));
                        case 2
                            signalWindowed = signalData(:).*kaiser(length(signalData));
                        case 3
                            signalWindowed = signalData(:).*gausswin(length(signalData));
                        case 4 
                            signalWindowed = signalData(:).*hann(langth(signalData));
                        case -1
                            signalWindowed = signalData;
                        otherwise
                            disp('1.Hamming 2.Kaiser 3.Gaussian 4.Hann');
                            error('Wrong Input Argument for Windowing ');       
                    end
                case 2  
                    if(SamplingRate <= 0)
                        error('Sampling Rate Cannot be Negative or zero');
                    end
                case 1
                    SamplingRate = 1; % assigning default sample rate
            end
            
            signalWindowed = signalWindowed - mean(signalWindowed);% remove DC offset
           
            Number_of_Data_Points = length(signalWindowed);  % Number of Data Points
          
            fft_signal = abs(fft(signalWindowed));   % FFT transformation [only real values taken into consideration]
          
            % Removing bin 1 [DC bin]
            down_index = signalWindowedoor(Number_of_Data_Points/2);
            fft_signal = fft_signal(2:down_index);

            freqLines = SamplingRate*(1:(Number_of_Data_Points/2)-1)/Number_of_Data_Points;  % Number of Frequency Lines
         
            %Higher Frequencies and fundamental frequency
            [frequencies fundamental_frequency fundamental_amplitude] = Extended_SINAD.FrequencyExtractor(fft_signal,length(freqLines));
            frequencies_present = frequencies;

            %Spectral Leakage Reduction around Fundamental Frequency
            fft_signal(fundamental_frequency-1) = 0;
            fft_signal(fundamental_frequency+1) = 0;

            %Calculating Numerator and Denominator for SINAD ratio
            numerator = (fundamental_amplitude)^2;
            denominator = sum(fft_signal.^2)-(fundamental_amplitude.^2);

            %SINAD CALCULATION
            Sinad_ratio = (10*log(numerator/denominator))/2;

        end
       
        function [Sinad_ratio] = Extended(signalData,SamplingRate,Windowing,input_freq)
     
            switch nargin
                case {3,4}  
                    switch Windowing %Checking Windowing Argument
                        case 1
                            signalWindowed = signalData(:).*hamming(length(signalData));
                        case 2
                            signalWindowed = signalData(:).*kaiser(length(signalData));
                        case 3
                            signalWindowed = signalData(:).*gausswin(length(signalData));
                        case 4 
                            signalWindowed = signalData(:).*hann(length(signalData));
                        case -1
                            signalWindowed = signalData;
                        otherwise
                            disp('1.Hamming 2.Kaiser 3.Gaussian 4.Hann');
                            error('Wrong Input Argument for Windowing ');       
                    end
                case 2  
                     signalWindowed = signalData(:);
                case 1
                    error('Not enought Input Arguments')
                otherwise
                    error('ERROR');
            end
    
    % checking Sampling Rate
    if SamplingRate < 0
        error('Sampling Rate is Negative')
    end
    % remove DC offset
    signalWindowed = signalWindowed - mean(signalWindowed);
    
    % Number of Data Points
    Number_of_Data_Points = length(signalData);

    % FFT transformation [only real values taken into consideration]
    fft_signal = abs(fft(signalWindowed));

    % Removing bin 1 [DC bin]
    down_index = floor(Number_of_Data_Points/2);
    fft_signal = fft_signal(2:down_index);

    % Number of Frequency Lines
    no_frequency_lines = SamplingRate*(1:(Number_of_Data_Points/2)-1)/Number_of_Data_Points;

    %Higher Frequencies and fundamental frequency
    [frequencies fundamental_frequency fundamental_amplitude] = SINAD.FrequencyExtractor(fft_signal,length(no_frequency_lines));
    
    if nargin == 3 || nargin == 2
        Down_limit_freq = num2str(no_frequency_lines(1));
        Up_limit_freq = num2str(no_frequency_lines(length(no_frequency_lines)));
        Message = strcat('Frequencies Range Present',{' '},Down_limit_freq,{' '},'to',{' '}, Up_limit_freq)
        disp(Message);
        Message2 = strcat('Fundamental Frequency is ',{' '},num2str(fundamental_frequency))
        disp(Message2);
        input_freq = input('Input frequency');
        if(input_freq < no_frequency_lines(1) || input_freq > (down_index-1))
            error('Input Frequency Out of Range');
        end
    elseif nargin == 4
         if(input_freq < no_frequency_lines(1) || input_freq > (down_index-1))
            error('Input Frequency Out of Range');
         elseif any(no_frequency_lines(:) == input_freq)
         else
                error('Please check Input frequency | Check signalWindowedoating Points | Try Interger values')
         end
   
    end

%     %Checking Input Fundamental Frequency and Calculated Fundamental
%     %Frequency
%     %Spectral Leakage Reduction around INPUT Fundamental Frequencies
     fft_signal(input_freq-1) = 0;
     fft_signal(input_freq+1) = 0;
    
    %Calculating Numerator and Denominator for SINAD ratio
    numerator = fft_signal(input_freq).^2;
    denominator = sum(fft_signal.^2)-(numerator);
  
    %SINAD CALCULATION
    Sinad_ratio = (10*log(numerator/denominator))/2;
   
        end

        function [frequencies,fundamental_frequency,fundamental_amplitude] = FrequencyExtractor(fft_signal,No_of_Freq_Lines)

            %fundamental Frequency Amplitude and Index
                [max_a, max_a] = max((fft_signal));
                fundamental_amplitude = fft_signal(max_a);

            %Higher Frequencies and fundamental frequency
                frequencies = [];
                fundamental_frequency = [];
                for i = (1:(No_of_Freq_Lines-1))
                    if fundamental_amplitude == fft_signal(i)
                        fundamental_frequency = [fundamental_frequency i];
                        frequencies = [frequencies i];
                    elseif 0.2 <= fft_signal(i)
                        frequencies = [frequencies i];
                    end
                end

        end
        
        function [Sinad_ratio] = ExtendedBundled(signalData,SamplingRate,Windowing,input_freq)

            %CHECKNIG INPUT ARGUMENTS AND RUNNING LOOP FOR BUNDLE SINAD
             tf = isa(input_freq,'double');
             if nargin == 4
                if tf == 1
                     Sinad_ratio = 0;
                     for i = 1:(length(input_freq))
                        Sinad_ratio = Sinad_ratio + SINAD.Extended(signalData,SamplingRate,Windowing,input_freq(i))
                     end
                else
                     error('Improper type Input_FREQ')
                end
             else
                 error('Not enough Input Arguments')
             end
        end
        
        %calculating ENOB from SINAD
        function [ENOB] = calculateENOB(SINAD)
            ENOB = (SINAD - 1.76)/6.02
        end
    end
end

