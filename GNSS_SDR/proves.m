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
% fileName='C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';
% [fid1, message] = fopen(fileName, 'rb');
% blksize=2;
% dataType='int8';
% [rawSignal, samplesRead] = fread(fid1, blksize, dataType);
% rawSignal
% [rawSignal, samplesRead] = fread(fid1, blksize, dataType);
% rawSignal
% 
% fileName='C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';
% [fid, message] = fopen(fileName, 'rb');
% blksize=3;
% dataType='int8';
% [rawSignal1, samplesRead] = fread(fid, 2*blksize, dataType);
% rawSignal1
% blksize=2;
% [rawSignal2, samplesRead] = fread(fid1, blksize, dataType);
% rawSignal2
%%
% fileName='C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';
% [fid1, message] = fopen(fileName, 'rb');
% blksize=10;
% dataType='int8';
% [rawSignal, samplesRead] = fread(fid1, blksize, dataType);
% rawSignal
% 
% 
% fileName='C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';
% [fid, message] = fopen(fileName, 'rb');
% [rawSignal2, samplesRead] = fread(fid, 5, dataType);
% rawSignal2
% rawSignal2(1:2)
% %fseek(fid, 5, 'bof');
% [rawSignal3, samplesRead] = fread(fid, 5, dataType);
% rawSignal3
% rawSignal3(1:2)
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
a='ATP';
if a=='ATP'
    b=2
end