%%  screenUpdate.m
%
% screenUpdate.m is the script to check for new EDF files in the working
% directory and, if present, to build acreening analysis figures for them.
% It will SKIP any files for which the "screening" directories already
% exist, and it will warn when data files exist for an EDF (without a
% screening directory).
%
% For a completely new directory, screenLoop.m can be used as well, but
% this one should be safer!
%
% MDT
% 2016.01.11
% Alpha

% Initialize eeglab for use by ge_screeningAnalysis2 function

eeglab;
close all;
clc;

% Make list of EDF files

fileList           = ls('*.edf');
[numFiles useless] = size(fileList);

disp('screenUpdate.m Running');
disp(['Current directory:  ' pwd]);
disp(['Number of EDF files:  ' int2str(numFiles)]);

for ii = 1:numFiles
    curFile = fileList(ii,:);
    ge_screeningAnalysis2(curFile);
end
