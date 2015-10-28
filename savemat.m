function savemat(Dir,Dat)
%% filters and detrends the data and saves it in analysis

cd(Dir.anadir);
eval(sprintf('EEG=ft_read_data(''%s'');',Dat.file));

% load the subject file);
data=EEG(:,:);

numchan=size(EEG,1);
ds = Dat.ds;

% % Design lowpass filter
% [N,Wn]=buttord(50/(ds/2),60/(ds/2),1,18);
% [Blow,Alow]=butter(N,Wn,'low');
% freqz(Blow,Alow,ds/2,ds);
% cd(Dir.anadir);cd diagnostics;
% eval(sprintf('saveas(gcf,''Lowpass.jpg'')'));
%
% % Design highpass filter
% [N,Wn]=buttord(.000001/(ds/2),10/(ds/2),1,30);
% [Bhigh,Ahigh]=butter(N,Wn,'high');
% freqz(Bhigh,Ahigh,ds/2,ds);
% cd(Dir.anadir);cd diagnostics;
% eval(sprintf('saveas(gcf,''Highpass.jpg'')'));
% close all;
%
% %% detrend and filter
% for gc = 1:numchan;
% data(gc,:) = detrend(data(gc,:));
% data(gc,:) = filtfilt(Blow,Alow,double(data(gc,:)));
% data(gc,:) = filtfilt(Bhigh,Ahigh,double(data(gc,:)));
% end;

cd(Dir.anadir);
eval(sprintf('save %s_1.mat data',Dat.file(1:(end-4))));
cd(Dir.scriptdir);
