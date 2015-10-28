%% ANALYZE Emotiv DATA
% Edited

close all
clc
clear all
% set a path to fieldtrip (if you haven't already)
%addpath(genpath('\\loki\export\mialab\users\ncota\NeonatalEEG\fieldtrip-lite-20150218\fieldtrip-20150218\fileio'));
%% set directories
Dir.rawpath = '\\XXXXXPATHXXXXX\NeonatalEEG'
Dir.scriptdir = [Dir.rawpath '\scripts'];
Dir.anadir = [Dir.rawpath '\ANALYSIS\cd-resting-forest-eyesclosed'];
Dir.croth = [Dir.rawpath '\out_fig\cd-resting-forest-eyesclosed'];

% % set a path to fieldtrip (if you haven't already)
% adcd-resting-forest-eyesclosedath(genpath('/export/mialab/users/ncota/NeonatalEEG/fieldtrip-lite-20150218/fieldtrip-20150218/fileio'));
% %% set directories
% Dir.rawpath = '/export/mialab/users/ncota/NeonatalEEG'
% Dir.scriptdir = [Dir.rawpath '/scripts'];
% Dir.anadir = [Dir.rawpath '/ANALYSIS/cd-resting-forest-eyesclosed'];
% Dir.croth = [Dir.rawpath '/out_fig/cd-resting-forest-eyesclosed'];

%Linux paths
% adcd-resting-forest-eyesclosedath(genpath('/export/mialab/users/ncota/NeonatalEEG/fieldtrip-lite-20150218/fieldtrip-20150218/fileio'));
% Dir.rawpath = '/export/mialab/users/ncota/NeonatalEEG';
% Dir.scriptdir = [Dir.rawpath '/scripts'];
% Dir.anadir = [Dir.rawpath '/ANALYSIS/cd-resting-forest-eyesclosed'];% CHANGE FOR EACH NEW SUB
% Dir.croth = [Dir.rawpath '/out_fig/cd-resting-forest-eyesclosed'];


%% Experiment files and parameters
Dat{1}.ds = 128;

% First subject
%Dat{1}.file='ws-resting-12.02.2015.12.52.42.edf';
% Second subject
%Dat{1}.file='MDT-resting01-03.02.2015.14.51.27.edf';
% Third subject
Dat{1}.file='cd-resting-forest-eyesclosed-17.04.2015.16.04.24.edf';

run =1;
for G = run
    theDat=Dat{G};

    %% save the data as a Matlab file when u get the data first time
    %savemat(Dir,theDat); %detrend and filtering commented


    %%Time domain plot,Welch PSD,spectrogram and wavelet time-frequency decomposition
    analysis(Dir,theDat); % Basic Analysis
    %implement_wavelet(Dir,theDat);%% Implementation of M-EMD
    %implement_emd(Dir,theDat); % Implementation of M-EMD
    %implement_syn(Dir,theDat); % Implementation of synchronizing transfrom
    %% Trim data and extract the first 5 min of every hour
    %analysis1(Dir,theDat); % trims data and runs Ica
    %analysis2(Dir,theDat); % extract the 5 mins of every hour for Navins Data (7)
    %analysisJ(Dir,theDat); % extracts the three hours for Johns Data
end;

cd(Dir.scriptdir);
