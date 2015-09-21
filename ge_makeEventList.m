% eventList = ge_makeEventList(EEGVAR, markerChannel)
% 
% Function to make an event list matrix out of the marker channel on
% EEG. Specifically set up for EPOC/EPOC+.  Note that the marker codes
% are not labelled, just returned. The three columns of the matrix are
% event number (1 to n), event sample point, and event label. The marker
% channel is optional and defaults to the EPOC's channel 20.
%
% MDT
% 2015.07.01

function eventList = ge_makeEventList(EEGVAR, markerChannel)
    if nargin < 2
        markerChannel = 20;     % Default EPOC(+) marker channel
    end
    
    nonzeroSamplePoints = find(EEGVAR.data(markerChannel,:));
    nonzeroSampleValues = EEGVAR.data(markerChannel, nonzeroSamplePoints);
    
    n = length(nonzeroSamplePoints);
    count = 1:n;
    
    eventList = horzcat(count', nonzeroSamplePoints', nonzeroSampleValues');