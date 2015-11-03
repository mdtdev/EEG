%% Import Script for MATLAB
% DRAFT

function [] = ge_importScript(filenameRoot)
  full_EEG = pop_biosig(strcat(filenameRoot,'.edf'));
  fprintf('Done with biosig import.\n')
  EEG_only = ge_extractExperimentDataset(full_EEG);
  fprintf('Done with extract experiment call.\n')
  pop_saveset(EEG_only, 'filename', strcat(filenameRoot,'_eegOnly.set'));
  fprintf('Done done.\n')
end
