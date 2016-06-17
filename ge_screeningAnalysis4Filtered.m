
function ge_screeningAnalysis3Filtered(rootEDFFile)
    % function ge_screeningAnalysis3Filtered(rootEDFFile)
    % 
    % Quick mod for EEG reading group! Do not use!!
    %
    % Transforms EDF files into sliced raw EEG, then executes a Navin-style
    % analysis and leaves the resulting pictures in a newly created folder
    % under the execution directory.
    %
    % MDT
    % 2016.06.16
    
    % Setup
    
    lowerBound = 1;     % Bandpass filter bounds in Hz
    upperBound = 41;
    
    %eeglab;     % Use eeglab functions to do conversion
    %close all;  % Close eeglab window

    % Decompose the EDF name and make eeg data file name and directory
    
    %[subjectName, runName, runDate, runTime] = ge_edf2info(rootEDFFile);
    
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

    % Check for rawEEG data file and warn!
    
    if exist([pwd filesep rawEEGFile], 'file')
        warning(['The rawEEG data file:  ' rawEEGFile '  exists and will be overwritten.']);
    end
    
    % Make rawEEG file 
    
    full_EEG = pop_biosig(rootEDFFile);
    EEG_Only = ge_extractExperimentDataset(full_EEG);
    EEG_Only = pop_eegfilt(EEG_Only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);
    pop_saveset(EEG_Only, 'filename', rawEEGFile);
    
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