% disp('These are the available signals to read and process:')
% disp('1) Borre_DiscreteComponents')
% disp('2) TEXBAT_cleanStatic')
% disp('3) TEXBAT_ds3')
% prompt='Choose the signal by entering the number: ';
% signal_file1=input(prompt)
% signal_file='Borre_DiscreteComponents';
% switch signal_file
%     case 'Borre_DiscreteComponents'
%         a=3
%         b=4
%     case 'TEXBAT_cleanStatic'
%     case 'TEXBAT_ds3'
%     otherwise
%         disp('error')
% end

% A=[1 2 3]
% 
% A=[A 4]

% figure 
% x=1:10
% y=1:10
% plot(x,y)
% PRN=21;
% nom='eric'
% title(['PCPS ' nom ' Acquisition grid for SV ID ', num2str(PRN)]);
% 
% fprintf("Hola "+ nom+ " que tal")


% acqSatellitePresentList=[1 2 3; 4 5 6; 7 8 9]
% max(acqSatellitePresentList(2,:))
%%
fileName='C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';
[fid1, message] = fopen(fileName, 'rb');
blksize=2;
dataType='int8';
[rawSignal, samplesRead] = fread(fid1, blksize, dataType);
rawSignal
[rawSignal, samplesRead] = fread(fid1, blksize, dataType);
rawSignal

fileName='C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';
[fid, message] = fopen(fileName, 'rb');
blksize=3;
dataType='int8';
[rawSignal1, samplesRead] = fread(fid, 2*blksize, dataType);
rawSignal1
blksize=2;
[rawSignal2, samplesRead] = fread(fid1, blksize, dataType);
rawSignal2
%%
%Abro el archivo y leo las primeras 25 muestras
fileName='D:\TexBat_spoofedsignals\ds3.bin';
[fid1, message] = fopen(fileName, 'rb');
blksize=30;
dataType='int16';
[rawSignal, samplesRead] = fread(fid1, blksize, dataType);
rawSignal

%Vuelvo a abrir el archivo de nuevo y empiezo a leer a partir de la segunda
%muestra (me salto 1B). Leo dos grupos de 10 muestras consecutivos.
fileName='D:\TexBat_spoofedsignals\ds3.bin';
[fid, message] = fopen(fileName, 'rb');
fseek(fid, 1, 'bof');
ftell(fid)
[rawSignal_skip_1, samplesRead] = fread(fid, 10, dataType);
rawSignal_skip_1
ftell(fid)
[rawSignal4_skip_2, samplesRead] = fread(fid, 10, dataType);
rawSignal4_skip_2

%CONCLUSIÓ: NUMBERBYTESTOSKIP (IN THIS CASE 1) CORRESPONDS TO THE NUMBER OF
%SAMPLES TO SKIP
%%
numSat=3
channelPerSat=1
channel=[]
a=0;
for i=1:numSat
    
    for j=1:channelPerSat
        
        channel=[channel; a];
    end
    a=a+1;
end
channel

%% 
a= [1 2 3 4 5 6 7 8 9 10]
b= a(1:2:end)
%%
a=[1:3 5:8 9:13]
%%
a=[1 2 3 4 5 6 7 8 9 10]
b=a(1:2:end)+j*a(2:2:end)
%%
 %--- Find the correlation peak and the carrier frequency --------------
%M = max(A,[],dim) returns the maximum element along dimension dim. For example, if A is a matrix, then max(A,[],2) is a column vector containing the maximum value of each row.
samplesPerCode=10;
results=[1 2 3 4 5 1 1 1 1 1; 2 1 2 1 1 2 3 2 3 1; 1 8 1 1 2 500 50 3 1 1;]
[primaryPeakSize frequencyBinIndex] = max(max(results, [], 2));

%--- Find code phase of the same correlation peak ---------------------
[primaryPeakSize primaryCodePhase] = max(max(results));

%--- Find 1 chip wide C/A code phase exclude range around the peak ----
samplesPerCodeChip   = 2;
excludeRangeIndex1 = primaryCodePhase - samplesPerCodeChip;
excludeRangeIndex2 = primaryCodePhase + samplesPerCodeChip;

%--- Correct C/A code phase exclude range if the range includes array
%boundaries
if excludeRangeIndex1 < 2
    codePhaseRange = excludeRangeIndex2 : ...
    (samplesPerCode + excludeRangeIndex1);

elseif excludeRangeIndex2 >= samplesPerCode
    codePhaseRange = (excludeRangeIndex2 - samplesPerCode) : ...
    excludeRangeIndex1;
else
    codePhaseRange = [1:excludeRangeIndex1, ...
    excludeRangeIndex2 : samplesPerCode];
end

%--- Find the second highest correlation peak in the same freq. bin ---
[secondaryPeakSize secondaryPeakCodePhase] = max(results(frequencyBinIndex, codePhaseRange));

%--- Store result -----------------------------------------------------
acqResults.peakMetric(1,1) = primaryPeakSize/secondaryPeakSize;


%--- Save properties of the detected satellite signal -------------
acqResults.carrFreq(1,1)  = frequencyBinIndex;
acqResults.codePhase(1,1) = primaryCodePhase;

%--- Find 1 chip wide C/A code phase exclude range around the peak ----
excludeRangeIndex11 = secondaryPeakCodePhase - samplesPerCodeChip;
excludeRangeIndex22 = secondaryPeakCodePhase + samplesPerCodeChip;

%--- Correct C/A code phase exclude range if the range includes array
%boundaries
if excludeRangeIndex1 < 2
codePhaseRange2 = [excludeRangeIndex2 : excludeRangeIndex11...
          excludeRangeIndex22:(samplesPerCode + excludeRangeIndex1)];

elseif excludeRangeIndex2 >= samplesPerCode
codePhaseRange2 = [(excludeRangeIndex2 - samplesPerCode):excludeRangeIndex11 ...
         excludeRangeIndex22:excludeRangeIndex1] ;
else
    if excludeRangeIndex1<excludeRangeIndex11
    codePhaseRange2 = [1:excludeRangeIndex1  excludeRangeIndex2:excludeRangeIndex11 excludeRangeIndex22:samplesPerCode];
    else
    codePhaseRange2 = [1:excludeRangeIndex11  excludeRangeIndex22:excludeRangeIndex1 excludeRangeIndex2:samplesPerCode];
    end
end

%--- Find the second highest correlation peak in the same freq. bin ---
[thirdPeakSize thirdPeakCodePhase] = max(results(frequencyBinIndex, codePhaseRange2));

%--- Store result secondary peak in case it overcomes the APT threshold-----------------------------------------------------

acqResults.peakMetric(2,PRN) = secondaryPeakSize/thirdPeakSize;
acqResults.carrFreq(2,PRN) = frqBins(frequencyBinIndex);
acqResults.codePhase(2,PRN) =secondaryPeakCodePhase; 
%%
for i=1:2:16
    i
end
%%
duration=0.000001;
start_time=0.00000008;%0.00000004
texbat=3;

sample_rate=25000000;%Hz
number_samples=ceil(duration*sample_rate);% number of samples to return
count=2*number_samples;%number of values to read (I & Q are interleaved)
point_to_begin=2*ceil(start_time*sample_rate)*2;%pointer to first value x2 for
skipIQSamples=3;
if texbat~=3;error('Only scenario 3 at this point');end;
fid=fopen('D:\TexBat_spoofedsignals\ds3.bin','r'); % open the file
fseek(fid,point_to_begin , 'bof');% position the start
%fseek(fid, skipIQSamples*4, 'bof');% position the start
ftell(fid)
s=fread(fid,count,'int16')';% read in Is and Qs
fclose(fid);
samples=s(1:2:count-1)+j*s(2:2:count) % Convert and return complex form

a=1;
