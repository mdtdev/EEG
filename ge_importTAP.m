function ge_importTAP(filenameRoot)

% ge_importTAP(filenameRoot)
%
% TAP Experiment Import Script. Imports a raw EDF file, looks for
% open/closed markers, then re-imports the data with a bandpass filter
% (boundaries 2 Hz and 41 Hz), and makes two new files: one for the eyes
% closed condition and another for the eyes open. All filenames derived
% from original EDF root filename.
%
% MDT
% 2016.04.17
% Version 0.1

    % Setup:
    
    lowerBound = 2;     % Bandpass filter bounds in Hz
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
    

end