function [channelByTime, numChannels, channelNames, sr] = ge_extractTimeCourses(EEG)

  % function [channelByTime, numChannels, channelNames, sr] = ge_extractTimeCourses(EEG)
  %
  % Extract the channel x time course matrix from an EEG data structure. Along
  % with some other general information needed for analysis or labeling. the
  % returned values are the channel x time matrix, the number of channels, the
  % channel names (as a vertical list of strings), and the sampling rate. This
  % is basically a 'getter' wrapper.
  %
  % MDT
  % 2015.11.06 (Second Revision)

  % Simple copies
  channelByTime = EEG.data;
  numChannels   = EEG.nbchan;
  x             = EEG.chanlocs;
  sr            = EEG.srate;

  % Channel labels are in a more complex array so some work
  C = '';
  for kk = 1:numChannels
    if length(C) == 0
      C = x(kk).labels;
    else
      C = char(C, x(kk).labels);
    end
  end
  channelNames = C;
end
