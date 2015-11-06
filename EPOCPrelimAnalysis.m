% Matlab script to do Navin-style preliminary analysis of EEG data from the
% emotiv EPOC study (mindfulness).
%
% MDT
% 2015.11.01 (revision 3)

% Reset Environment

clear all;
eeglab;       % eeglab must be installed and working before use
close all;    % Placed last to close eeglab interactive window

% Set Variables Here, then run script:

datasetFileName = '1004_Intake_eegOnly.set';
datasetFileRoot = datasetFileName(1:(end-4));

% This script does ONE analysis run on ONE data set, hopefully it can be
% easily converted to a function later on. Unlike Navin's original script,
% I will be making use of EEGLAB's functions so if this crashes, try
% running eeglab at the command line first!

fprintf('\n\nPreliminary Analysis Script (TEST VERSION)\n\n');
fprintf('(1) Manually edit script to change filename.\n');
fprintf('(2) If it does not work, try the command "eeglab" before using!\n');
fprintf('(3) Run this from the data directory, unless you know what you\n\tare doing!\n\n');

% Grab the time series with the getter function

EEG                  = pop_loadset('filename',datasetFileName);
[cbt, nc, cNames,sr] = ge_extractTimeCourses(EEG);
