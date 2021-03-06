
lowerBound = 2
upperBound = 41
eegChannels = 3:16;

%EEG2 = pop_biosig('test.edf')
EEG2 = pop_loadset('test.set')
EEG_only = pop_select(EEG2, 'channel', eegChannels)
EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0)

for m = 3:5
    ss = ge_getSampleBounds(EEG2, m)
    data{m} = EEG_only.data(:,ss(1):ss(2))
end

blob.Fs = 128

for ii = 3:5
    blob.data = data{ii}'
    AIS{ii} = alphaImbalance(blob)
end