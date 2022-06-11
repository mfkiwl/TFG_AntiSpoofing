function [succ] = APT_detection_check(settings,fid1,SatellitePresentList)
%APT_DETECTION_CHECK calls acquisition function in order to perform the APT
%check with the purpose of detecting a possible secondary peak in the
%search grid. 
succ=0;
samplesPerCode = round(settings.samplingFreq / ...
                           (settings.codeFreqBasis / settings.codeLength));
                       
raw_signal_AptPeriod_long = fread(fid1, settings.AptPeriod*samplesPerCode, settings.dataType)'; %settings.AptPeriod corresponds to the ms between apt check and samplesPercode, as 1 code=1ms, correspond to the samples per code. the multiplication is the samples between apt check
raw_signal_11ms=raw_signal_AptPeriod_long(1:11*samplesPerCode);

acqType='APT';
acqResults = acquisition(raw_signal_11ms, settings, acqType,SatellitePresentList)
succ=1;
end

%[channel.PRN]