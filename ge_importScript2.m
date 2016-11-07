% ge_importScript2(filenameRoot)
%
% Import Script for EDF files from EPOC/EPOC+
%
% Give this function the full name of the EDF file. It will delete the
% date and time stamp, and make a new file name ending in '_filtEEG' for
% the data set.
%
% MDT 2015.11.04 (Revised)

function ge_importScript2(filenameRoot)

    % Setup:

    lowerBound = 1;     % Bandpass filter bounds in Hz
    upperBound = 40;

    % Filename string manipulations - Built for MEDITATION Study Data
    %    NB: This should work for any data saved from Emotiv Testbench
    %    using the defaults, i.e. subjectname and condition with dashes &
    %    dates

    fullEDFname  = filenameRoot;
    filenameRoot = regexprep(filenameRoot, 'edf$','');     % Remove fn ext
    filenameRoot = regexprep(filenameRoot, '-[\d.]+$',''); % Chop off date/time
    filenameRoot = strcat(filenameRoot,'_filtEEG.set');

    fprintf(strcat('\nGE\tInput filename:\t\t', fullEDFname,  '\n'));
    fprintf(strcat('GE\tOutput filename:\t',  filenameRoot, '\n\n'));

    % In the original importScript, this was:
    %    * pop_biosig -> extractExperimentDataset -> pop_saveset *
    % and some printing. This version adds several features: it does a filter
    % of the data immediately after loading, then adds in the CED data for
    % head geometry

    % Import
    full_EEG = pop_biosig(fullEDFname);
    fprintf(strcat('\n\tGE\t', fullEDFname, '\t imported with BIOSIG.\n\n'));

    % Chop out non-experimental junk data
    EEG_only = ge_extractExperimentDataset(full_EEG);
    fprintf('\n\tGE\tExperimental data extracted from full file.\n\n')

    % Run the bandpass filter
    EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);

    % Set CED data for geometry of head/electrode positions
    %EEG=pop_chanedit(EEG, 'load',{'D:\\mdt\\LOCAL_MATLAB_TOOLBOXES\\EEG\\emotiv_local.ced' 'filetype' 'autodetect'});

    % Save the result
    pop_saveset(EEG_only, 'filename', filenameRoot);
    fprintf('\n\tGE\tNew data set created in file.\n');
    fprintf(strcat('\tGE\t\tFilename:\t', filenameRoot, '\n\n'));
end
