function analysis(Dir,Dat);% 

close all;

%% load the subject matlab file
cd(Dir.anadir);eval(sprintf('fl=dir(''%s_1.mat'');',Dat.file(1:(end-4))));
load(fl(1).name);

ds=Dat.ds;
thechan = [3 4 5 6 7 8 9 10 11 12 13 14 15 16];% Emotiv EEG Channels

 for k=1:length(thechan)
%% Time domain plot
cd(Dir.croth);
t=linspace(0,length(data(thechan(k),:))/ds,length(data(thechan(k),:)));
tempe=data(thechan(k),:)-mean(data(thechan(k),:));
figure,plot(t,tempe);xlabel('Time in seconds');ylabel('Amplitude');
title('Mean Removed Time domain plot')

%saveas(gcf,strcat('TimeDomain_channel', int2str(k)), 'pdf')
%saveas(gcf,strcat('TimeDomain_channel', int2str(k+4)), 'pdf')
close all

% PSD plot
% Hs=spectrum.welch;
% Hs.SegmentLength=128;% set to sampling rate
% figure,psd(Hs,data(thechan(k),:),'Fs',ds);
%% Freq domain 
% FFT code
L=length(tempe);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(tempe,NFFT)/L;
f = ds/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure,plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum using FFT')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%saveas(gcf,strcat('FFT_channel', int2str(k)), 'pdf')


% Spectrogram plot
%[S,Freq,T,P]=spectrogram(x,window,noverlap,F,fs);% S-STFT;Freq=rounded freq,T=vector of times at which 
% specgram is % %computed,P=power spectral intensity of each segment;noverlap is less than window size
[S,Freq,T,P] = spectrogram(tempe,ds,32,ds,ds); figure
surf(T,Freq,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);title('Spectrogram showing Entire spectrum for whole session');colorbar
xlabel('Time (Seconds)'); ylabel('Hz');
%eval(sprintf('Spectrogram_channel%0.0f.png -m2.5 -painters',k))
%saveas(gcf,strcat('Specgram_channel', int2str(k)), 'fig')
%saveas(gcf,strcat('Specgram_channel', int2str(k)), 'pdf')
close all

 end

 
 
