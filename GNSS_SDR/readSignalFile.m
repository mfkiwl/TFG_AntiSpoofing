function [data,fid] = readSignalFile(fileID,settings,numSamples,openFile)
%Performs the data format adaptation depending on the signal file format

%numOfCodes is the number of codes to read. As one code lasts 1 ms, it also
%corresponds to the number of ms to read


%% Open file in case it is necessary. In case the user wants to skip some bytes and start the execution in the middle of the file, here it is done the fseek
switch openFile
    case 0 %To read the signal, it is not necessary to open the file as it is not the first time (the file has been already opened)
        fid=fileID;
    case 1 %To read the signal, it is necessary to open the file as it is the first time
        fid=fopen(settings.fileName,'r'); % open the file
        switch settings.dataFormat
            case 'byte'
                point_to_begin=ceil(settings.fileStartingReadingSecond*settings.samplingFreq);
            case 'ishort'
                point_to_begin=2*ceil(settings.fileStartingReadingSecond*settings.samplingFreq)*2;
        end
        fseek(fid, point_to_begin , 'bof');% position the start
end

%% Read the file and return data
switch settings.dataFormat
    
    %--------Real samples [S1,S2,...Sn]----------------------------------------
    case 'byte'
        data = fread(fid, numSamples, settings.dataType)';
        
    %-------IQ (ishort) samples [I1, Q1, I2, Q2 ... In, Qn]--------------------    
    case 'ishort'
        numSamples=2*numSamples;%number of values to read (I & Q are interleaved)
        s=fread(fid,numSamples,'int16')';% read in Is and Qs
        %fclose(fid);
        ftell(fid)
        data=s(1:2:numSamples-1)+j*s(2:2:numSamples); % Convert and return complex form
    otherwise
        data=[];
end

end

