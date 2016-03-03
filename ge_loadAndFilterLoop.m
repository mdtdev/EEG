% Dangerous script to do all of the loading and filtering (1-41 Hz) in an
% assumed clean directory. May fail if any subdirectories are in place or
% if any of the data already converted from EDF!
%
% MDT
% 2016.03.03
% Alpha

eeglab;
close all;
clc;

fileList = ls('*.edf');

[numFiles, useless] = size(fileList);

disp(['Current directory:  ' pwd]);
disp(['Number of files:  ' numFiles]);

for ii = 1:numFiles
    curFile = fileList(ii,:);
    ge_importScript2(strtrim(curFile));
end