function [acqResults] = acquisition_module(raw_signal_FI_2ms,settings)
%ACQUISITION_MODULE Summary: This function performs the acquisition of the
%all (32, configurable though) satellites. 

%It adapts the input data (which is the same input data as the original Borre software acquisition.m function) in order
%to use the function pcps_acquisition (from NACC practises) which performs the pcps
%acquisition for a given (single) satellite. By doing so, at a high-level point
%of view, the input and the output of this function is the same as the
%original Borre software acquisition.m function. However, it uses the
%pcps_acquisition function since this function performs acquisition plots.

%% Global variables in this function context

Ts=1/settings.samplingFreq;

%Frequency axis of the search band
FreqMin=-(settings.acqSearchBand*1000/2);
FreqMax=(settings.acqSearchBand*1000/2);
FreqStep=settings.acqFreqStep;

%% Down conversion to base band (BB) of the raw_signal_FI_2ms
samplesPerCode = round(settings.samplingFreq / ...
                        (settings.codeFreqBasis / settings.codeLength));
                    
phasePoints = (0 : (2*samplesPerCode-1)) * 2 * pi * Ts; %recall that the function input raw signal (centered at FI) contains 2ms

%raw_signal_BB_2ms = raw_signal_FI_2ms.*exp(-1i*settings.IF*phasePoints);

%% Acquisition for each satellite
 for SV=1:1:32 
     acqResults_one_sat=pcps_acquisition_single_sat(raw_signal_FI_2ms, settings, SV);
     
     acqResults.carrFreq(SV)=acqResults_one_sat.carrFreq;
     acqResults.codePhase(SV)=acqResults_one_sat.codePhase;
     acqResults.peakMetric(SV)=acqResults_one_sat.peakMetric;
 end
end

