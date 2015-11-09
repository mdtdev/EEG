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

datasetFileName = '1006-session2_eegOnly.set';
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

EEG                   = pop_loadset('filename',datasetFileName);
[cbt, nc, cNames, sr] = ge_extractTimeCourses(EEG);

% Generate the plots for each channel:

for ii = 1:nc

  % Setup for a channel
  channelName = cNames(ii,:);
  if ii < 10
      figureFile  = [datasetFileRoot '_prelimfigure' '_0' int2str(ii) '_' channelName '.fig'];
  else
      figureFile  = [datasetFileRoot '_prelimfigure' '_' int2str(ii) '_' channelName '.fig'];
  end
  
  fprintf(['\tChannel: ' channelName ' to file: ' figureFile '\n']);

  % Overall figure
  figure;

  % Time Domain Plot
  t     = linspace(0, length(cbt(ii,:))/sr, length(cbt(ii,:)));
  tempe = cbt(ii,:) - mean(cbt(ii,:));

  subplot(2,2,1);
  plot(t,tempe);
  hold on;
  plot(xlim, [0 0], '-r');
  hold off;
  xlabel('Time in seconds');
  ylabel('Amplitude');
  title(['Mean removed time domain plot for channel: ' channelName]);

  % Fourier Spectrum Plot
  L    = length(tempe);
  NFFT = 2^nextpow2(L);
  Y    = fft(tempe, NFFT)/L;
  f    = (sr/2) * linspace(0, 1, (NFFT/2) + 1);

  subplot(2,2,2);
  plot(f, 2*abs(Y(1:(NFFT/2)+1)));
  title(['Single-Sided Amplitude Spectrum using FFT for channel: ' channelName]);
  xlabel('Frequency (Hz)');
  ylabel('|Y(f)|');

  % Spectrogram Plot
  [S, Freq, T, P] = spectrogram(tempe, sr, 32, sr, sr);

  subplot(2,2,[3 4]);
  surf(T, Freq, 10*log10(P), 'edgecolor', 'none');
  axis tight;
  view(0,90);
  title(['Spectrogram: Entire spectrum for whole session, channel: ' channelName]);
  colorbar;
  xlabel('Time (Seconds)'); ylabel('Hz');

  % Save the figure
  savefig(gcf, figureFile);
  close all;
end
