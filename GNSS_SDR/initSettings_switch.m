function settings = initSettings_switch()
%Functions initializes and saves settings. Settings can be edited inside of
%the function, updated from the command line or updated using a dedicated
%GUI - "setSettings".  
%
%All settings are described inside function code.
%
%settings = initSettings()
%
%   Inputs: 
%         signal_file (string): name of the signal file to be read and processed. It can be a
%                               signal of the Borre software or the TEXBAT spoofed signals
%                               repository 
%
%   Outputs:
%       settings     - Receiver settings (a structure). 

%   Cases:
%         -1)Borre_DiscreteComponents
%         -2)TEXBAT_cleanStatic
%         -3)TEXBAT_ds3

%% Display the available signals in order to let the user decide
disp('These are the available signals to read and process:')
disp('1) Borre_DiscreteComponents')
disp('2) TEXBAT_cleanStatic')
disp('3) TEXBAT_ds3')
prompt='Choose the signal by entering the number: ';
signal_file=input(prompt);

%% Switch event. Creating the settings structure depending on the signal choosen by the user
switch signal_file
    case 1 %'Borre_DiscreteComponents'
        %% Processing settings ====================================================
        % Number of milliseconds to be processed used 36000 + any transients (see
        % below - in Nav parameters) to ensure nav subframes are provided
        settings.msToProcess        = 37000;        %[ms]

        % Number of channels to be used for signal processing
        settings.numberOfChannels   = 8;

        % Move the starting point of processing. Can be used to start the signal
        % processing at any point in the data record (e.g. for long records). fseek
        % function is used to move the file read point, therefore advance is byte
        % based only. 
        settings.skipNumberOfBytes     = 0;

        %% Raw signal file name and other parameter ===============================
        % This is a "default" name of the data file (signal record) to be used in
        % the post-processing mode
        settings.fileName           = ...
            'C:\Users\erics\OneDrive\Documentos\MATLAB\TFG\Borre\GNSS_signal_records\GPSdata-DiscreteComponents-fs38_192-if9_55.bin';

        % Data type used to store one sample
        settings.dataType           = 'int8';

        % Intermediate, sampling and code frequencies
        settings.IF                 = 9.548e6;%[Hz]
        settings.samplingFreq       = 38.192e6;     %[Hz]
        settings.codeFreqBasis      = 1.023e6;      %[Hz]

        % Define number of chips in a code period
        settings.codeLength         = 1023;

        %% Acquisition settings ===================================================
        % Skips acquisition in the script postProcessing.m if set to 1
        settings.skipAcquisition    = 1;
        % List of satellites to look for. Some satellites can be excluded to speed
        % up acquisition
        settings.acqSatelliteList   = 1:32;         %[PRN numbers]
        % Band around IF to search for satellite signal. Depends on max Doppler
        settings.acqSearchBand      = 14;
        % settings.acqSearchBand      = 14;           %[kHz]
        settings.acqFreqStep=500; %[Hz]
        % Threshold for the signal presence decision rule
        settings.acqThreshold       = 2.5;
        %% Tracking loops settings ================================================
        % Code tracking loop parameters
        settings.dllDampingRatio         = 0.7;
        settings.dllNoiseBandwidth       = 2;       %[Hz]
        settings.dllCorrelatorSpacing    = 0.5;     %[chips]

        % Carrier tracking loop parameters
        settings.pllDampingRatio         = 0.7;
        settings.pllNoiseBandwidth       = 25;      %[Hz]

        %% Navigation solution settings ===========================================

        % Period for calculating pseudoranges and position
        settings.navSolPeriod       = 500;          %[ms]

        % Elevation mask to exclude signals from satellites at low elevation
        settings.elevationMask      = 10;           %[degrees 0 - 90]
        % Enable/dissable use of tropospheric correction
        settings.useTropCorr        = 1;            % 0 - Off
                                                    % 1 - On

        % True position of the antenna in UTM system (if known). Otherwise enter
        % all NaN's and mean position will be used as a reference .
        settings.truePosition.E     = nan;
        settings.truePosition.N     = nan;
        settings.truePosition.U     = nan;

        %% Plot settings ==========================================================
        % Enable/disable plotting of the tracking results for each channel
        settings.plotTracking       = 1;            % 0 - Off
                                                    % 1 - On

        %% Constants ==============================================================

        settings.c                  = 299792458;    % The speed of light, [m/s]
        settings.startOffset        = 68.802;       %[ms] Initial sign. travel time

    case 2%'TEXBAT_cleanStatic'
        %% Processing settings ====================================================
        % Number of milliseconds to be processed used 36000 + any transients (see
        % below - in Nav parameters) to ensure nav subframes are provided
        settings.msToProcess        = 37000;        %[ms]

        % Number of channels to be used for signal processing
        settings.numberOfChannels   = 8;

        % Move the starting point of processing. Can be used to start the signal
        % processing at any point in the data record (e.g. for long records). fseek
        % function is used to move the file read point, therefore advance is byte
        % based only. 
        settings.skipNumberOfBytes     = 0;

        %% Raw signal file name and other parameter ===============================
        % This is a "default" name of the data file (signal record) to be used in
        % the post-processing mode
        settings.fileName           = ...
            'D:\TexBat_spoofedsignals\cleanStatic.bin';

        % Data type used to store one sample
        settings.dataType           = 'int16';

        % Intermediate, sampling and code frequencies
        settings.IF                 = 0;%1575420000
        settings.samplingFreq       = 25e6;     %[Hz]
        % % Define number of chips in a code period
        settings.codeFreqBasis      = 1.023e6;      %[Hz]

        % Define number of chips in a code period
        settings.codeLength         = 1023;

        %% Acquisition settings ===================================================
        % Skips acquisition in the script postProcessing.m if set to 1
        settings.skipAcquisition    = 1;
        % List of satellites to look for. Some satellites can be excluded to speed
        % up acquisition
        settings.acqSatelliteList   = 1:32;         %[PRN numbers]
        % Band around IF to search for satellite signal. Depends on max Doppler
        settings.acqSearchBand      = 14;
        % settings.acqSearchBand      = 14;           %[kHz]
        settings.acqFreqStep=500; %[Hz]
        % Threshold for the signal presence decision rule
        settings.acqThreshold       = 1.5;
        %% Tracking loops settings ================================================
        % Code tracking loop parameters
        settings.dllDampingRatio         = 0.7;
        settings.dllNoiseBandwidth       = 2;       %[Hz]
        settings.dllCorrelatorSpacing    = 0.5;     %[chips]

        % Carrier tracking loop parameters
        settings.pllDampingRatio         = 0.7;
        settings.pllNoiseBandwidth       = 25;      %[Hz]

        %% Navigation solution settings ===========================================

        % Period for calculating pseudoranges and position
        settings.navSolPeriod       = 500;          %[ms]

        % Elevation mask to exclude signals from satellites at low elevation
        settings.elevationMask      = 10;           %[degrees 0 - 90]
        % Enable/dissable use of tropospheric correction
        settings.useTropCorr        = 1;            % 0 - Off
                                                    % 1 - On

        % True position of the antenna in UTM system (if known). Otherwise enter
        % all NaN's and mean position will be used as a reference .
        settings.truePosition.E     = nan;
        settings.truePosition.N     = nan;
        settings.truePosition.U     = nan;

        %% Plot settings ==========================================================
        % Enable/disable plotting of the tracking results for each channel
        settings.plotTracking       = 1;            % 0 - Off
                                                    % 1 - On

        %% Constants ==============================================================

        settings.c                  = 299792458;    % The speed of light, [m/s]
        settings.startOffset        = 68.802;       %[ms] Initial sign. travel time

    case 3%'TEXBAT_ds3'
        %% Processing settings ====================================================
        % Number of milliseconds to be processed used 36000 + any transients (see
        % below - in Nav parameters) to ensure nav subframes are provided
        settings.msToProcess        = 37000;        %[ms]

        % Number of channels to be used for signal processing
        settings.numberOfChannels   = 8;

        % Move the starting point of processing. Can be used to start the signal
        % processing at any point in the data record (e.g. for long records). fseek
        % function is used to move the file read point, therefore advance is byte
        % based only. 
        settings.skipNumberOfBytes     = 0;

        %% Raw signal file name and other parameter ===============================
        % This is a "default" name of the data file (signal record) to be used in
        % the post-processing mode
        settings.fileName           = ...
            'D:\TexBat_spoofedsignals\ds3.bin';

        % Data type used to store one sample
        settings.dataType           = 'int16';

        % Intermediate, sampling and code frequencies
        settings.IF                 = 0;%1575420000
        settings.samplingFreq       = 25e6;     %[Hz]
        % % Define number of chips in a code period
        settings.codeFreqBasis      = 1.023e6;      %[Hz]
        
        % Define number of chips in a code period
        settings.codeLength         = 1023;

        %% Acquisition settings ===================================================
        % Skips acquisition in the script postProcessing.m if set to 1
        settings.skipAcquisition    = 1;
        % List of satellites to look for. Some satellites can be excluded to speed
        % up acquisition
        settings.acqSatelliteList   = 1:32;         %[PRN numbers]
        % Band around IF to search for satellite signal. Depends on max Doppler
        settings.acqSearchBand      = 14;
        % settings.acqSearchBand      = 14;           %[kHz]
        settings.acqFreqStep=500; %[Hz]
        % Threshold for the signal presence decision rule
        settings.acqThreshold       = 1.4;
        %% Tracking loops settings ================================================
        % Code tracking loop parameters
        settings.dllDampingRatio         = 0.7;
        settings.dllNoiseBandwidth       = 2;       %[Hz]
        settings.dllCorrelatorSpacing    = 0.5;     %[chips]

        % Carrier tracking loop parameters
        settings.pllDampingRatio         = 0.7;
        settings.pllNoiseBandwidth       = 25;      %[Hz]

        %% Navigation solution settings ===========================================

        % Period for calculating pseudoranges and position
        settings.navSolPeriod       = 500;          %[ms]

        % Elevation mask to exclude signals from satellites at low elevation
        settings.elevationMask      = 10;           %[degrees 0 - 90]
        % Enable/dissable use of tropospheric correction
        settings.useTropCorr        = 1;            % 0 - Off
                                                    % 1 - On

        % True position of the antenna in UTM system (if known). Otherwise enter
        % all NaN's and mean position will be used as a reference .
        settings.truePosition.E     = nan;
        settings.truePosition.N     = nan;
        settings.truePosition.U     = nan;

        %% Plot settings ==========================================================
        % Enable/disable plotting of the tracking results for each channel
        settings.plotTracking       = 1;            % 0 - Off
                                                    % 1 - On

        %% Constants ==============================================================

        settings.c                  = 299792458;    % The speed of light, [m/s]
        settings.startOffset        = 68.802;       %[ms] Initial sign. travel time
    otherwise
        disp('Error, the input signal file name is not contemplated, either choose another signal file or create a case for this specific scenario')
end
end

