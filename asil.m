%
% Test of inner loop for EPOCPrelimAnalysis script
% Temporary!

ii = 1;  % This will be the index for the loop

channelName = cNames(ii,:);
figureFile  = [datasetFileRoot '_prelimfigure' '_' channelName '.pdf'];

% time domain plot

t     = linspace(0, length(cbt(ii,:))/sr, length(cbt(ii,:)));
tempe = cbt(ii,:) - mean(cbt(ii,:));

figure;
plot(t,tempe);
xlabel('Time in seconds');
ylabel('Amplitude');
title('Mean Removed Time domain plot');

saveas(gcf, figureFile, 'pdf');
