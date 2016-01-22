function quickView(dataset)
    % quickView(dataset)
    %
    % Displays a scroll view of the data set named in "dataset". Launches,
    % removes the baseline, then opens the scroll view with a window size of 30
    % seconds.
    %
    % MDT
    % 2016.01.21
    
    eeglab;
    close all;

    EEG = pop_loadset('filename', dataset);
    EEG = pop_rmbase(EEG,[]);
    eegplot(EEG.data, 'winlength', 30, 'plottitle', dataset);
end