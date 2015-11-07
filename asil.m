%
% Test of inner loop for EPOCPrelimAnalysis script
% Temporary!

ii = 1;  % This will be the index for the loop

% Setup for a channel

channelName = cNames(ii,:);
figureFile  = [datasetFileRoot '_prelimfigure' '_' channelName '.fig'];

fprintf(['\tChannel: ' channelName ' to file: ' figureFile '\n']);

% Overall figure

figure;

% Time Domain Plot
%

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
%

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
%

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
