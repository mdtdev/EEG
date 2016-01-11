
function bounds = ge_screeningAnalysis(rootEDFFile)
    % function bounds = ge_screeningAnalysis(rootEDFFile)
    % 
    % Transforms EDF files into sliced raw EEG, then executes a Navin-style
    % analysis and leaves the resulting pictures in a newly created folder
    % under the execution directory.
    %
    % MDT
    % 2016.01.09
    % Version 0.1
    
    % Setup
    
    %eeglab;     % Use eeglab functions to do conversion
    %close all;  % Close eeglab window

    % Decompose the EDF name and make eeg data file name and directory
    
    [subjectName, runName, runDate, runTime] = ge_edf2info(rootEDFFile);
    
    rawEEGFile  = [subjectName '_' runName '_eegdata.set'];
    figRootName = [subjectName '_' runName];
    screenDir   = ['Screening_' subjectName '_' runName];

    % Create the DIR (check if exists first)
    
    if isdir(screenDir)
        warning(['The Screening Directory: ' screenDir ' exists. Skipping.']);
        return;
    else
        mkdir(screenDir);
    end

    % Make rawEEG file (check if exists first)
    
    if exist([pwd filesep rawEEGFile], 'file')
        error('The raw EEG data already exists! Delete it to proceed.');
    else
        full_EEG = pop_biosig(rootEDFFile);
        EEG_Only = ge_extractExperimentDataset(full_EEG);
        pop_saveset(EEG_Only, 'filename', rawEEGFile);
    end
    
    % Make the plots and place them in the directory
    
    [cbt, nc, cNames, sr] = ge_extractTimeCourses(EEG_Only);
    
    for ii = 1:nc

      % Setup for a channel
      channelName = cNames(ii,:);
      if ii < 10
          figureFile  = [figRootName '_prelimfigure' '_0' int2str(ii) '_' channelName '.fig'];
      else
          figureFile  = [figRootName '_prelimfigure' '_' int2str(ii) '_' channelName '.fig'];
      end

      % Make Overall Figure
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
      savefig(gcf, [pwd filesep screenDir filesep figureFile]);
      close all;
    end
end