
% NEWEEG = ge_extractExperimentDataset(EEGVAR)
% 
% Extracts and experiment bounded with "beeps" from an EEGLAB standard
% dataset. Returns a new dataset with just the EEG channels (3:16 default
% for Emotiv) and standard "2" beeps. (This latter can be changed in the 
% ge_getSampleBounds.m function, but a new higher-level script will be
% needed.
%
% MDT
% 2015.07.07

function NEWEEG = ge_extractExperimentDataset(EEGVAR)

    eegChannels = 3:16;     % EEG channels for the Emotiv EPOC
    
    bounds = ge_getSampleBounds(EEGVAR);
    EEGVAR = pop_select(EEGVAR, 'point', bounds);
    NEWEEG = pop_select(EEGVAR, 'channel', eegChannels);