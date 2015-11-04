% Import Script for EDF files from EPOC/EPOC+
%
% Give this function the full name of the EDF file. It will delete the
% date and time stamp, and make a new file name ending in '_eegOnly' for
% the data set.
%
% MDT 2015.11.04 (Revised)

function [] = ge_importScript(filenameRoot)

  % Filename string manipulations
  fullEDFname  = filenameRoot;
  filenameRoot = regexprep(filenameRoot, 'edf$','');      % Remove extension at end of string
  filenameRoot = regexprep(filenameRoot, '-[\d.]+$','');  % Chop off everything after '-' to the end of string
  filenameRoot = strcat(filenameRoot,'_eegOnly.set');

  fprintf(strcat('\nGE\tInput filename:\t\t', fullEDFname,  '\n'));
  fprintf(strcat('GE\tOutput filename:\t',  filenameRoot, '\n\n'));

  % Do the actual work...
  full_EEG = pop_biosig(fullEDFname);
  fprintf(strcat('\n\tGE\t', fullEDFname, '\t imported with BIOSIG.\n\n'));

  EEG_only = ge_extractExperimentDataset(full_EEG);
  fprintf('\n\tGE\tExperimental data extracted from full file.\n\n')

  pop_saveset(EEG_only, 'filename', filenameRoot);
  fprintf('\n\tGE\tNew data set created in file.\n');
  fprintf(strcat('\tGE\t\tFilename:\t', filenameRoot, '\n\n'));
end
