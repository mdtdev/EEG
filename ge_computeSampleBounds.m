% bounds = ge_computeSampleBounds(EEGVAR, beepValue, markerChannel)
% 
% Determines the start and stop samples of an EEG experiment.
%
% MDT
% 2015.07.01

function bounds = ge_computeSampleBounds(EEGVAR, beepValue, markerChannel)

    if nargin == 2
        markerChannel = 20;     % Default EPOC(+) marker channel
    elseif nargin == 1
        beepValue     = 2;      % Original default beep marker
        markerChannel = 20;
    end
    
    nonzeroSamplePoints = find(EEGVAR.data(markerChannel,:));
    nonzeroSampleValues = EEGVAR.data(markerChannel, nonzeroSamplePoints);