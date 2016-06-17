function AIS = ge_parrottImport(filename)

    lowerBound  = 2;
    upperBound  = 41;
    eegChannels = 3:16;
    
    % The file in loaded (or imported) and a "derived" data set is made
    %    that contains the EEG data only.  The original data with markers
    %    is in EEG2; the selected/filtered data is in EEG_only.

    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
    elseif regexp(filename,'edf$')
        EEG2 = pop_biosig(filename);
    else
        error('ge_handContraction: File type unknown');
    end
    
    %EEG2     = pop_biosig(filename);
    %EEG2     = pop_loadset(filename);
    EEG_only = pop_select(EEG2, 'channel', eegChannels);
    EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);

    % Make the blocks of selected/filtered data:
    
    for m = 3:4
        ss      = ge_getSampleBounds(EEG2, m);    % Bounds from EEG2
        data{m} = EEG_only.data(:,ss(1):ss(2));   % Data from EEG_only
    end

    % Do the analysis to each block:
    
    blob.Fs = 128;
    for ii  = 3:4
        blob.data = data{ii}';
        AIS{ii}   = alphaImbalance(blob);
    end
end