% Generated by MATLAB(R) 9.13 (R2022b) and WLAN Toolbox 3.5 (R2022b).
% Generated on: 01-Apr-2024 16:13:50

%% Generating 802.11n/ac (OFDM) waveform
% 802.11n/ac (OFDM) configuration
htCfg = wlanHTConfig('ChannelBandwidth', 'CBW40', ...
    'NumTransmitAntennas', 1, ...
    'NumSpaceTimeStreams', 1, ...
    'SpatialMapping', 'Direct', ...
    'MCS', 0, ...
    'GuardInterval', 'Long', ...
    'ChannelCoding', 'BCC', ...
    'AggregatedMPDU', false, ...
    'RecommendSmoothing', true, ...
    'PSDULength', 1024);

numPackets = 1;
% input bit source:
in = randi([0, 1], 1000, 1);


% Generation
waveform = wlanWaveformGenerator(in, htCfg, ...
    'NumPackets', numPackets, ...
    'IdleTime', 0, ...
    'OversamplingFactor', 1, ...
    'ScramblerInitialization', 93, ...
    'WindowTransitionTime', 1e-07);

Fs = wlanSampleRate(htCfg, 'OversamplingFactor', 1); 								 % Specify the sample rate of the waveform in Hz

%% Visualize
% Spectrum Analyzer
spectrum = spectrumAnalyzer('SampleRate', Fs);
spectrum(waveform);
release(spectrum);


