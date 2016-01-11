% Slightly dangerous script to do all of the screening in a clean
% directory. Will fail if any subdirectories are in place or if any of the
% data already converted from EDF!
%
% MDT
% 2016.01.11
% Alpha

fileList = ls('*.edf');

[numFiles useless] = size(fileList);

disp(['Current directory:  ' pwd]);
disp(['Number of files:  ' numFiles]);

for ii = 1:numFiles
    curFile = fileList(ii,:);
    ge_screeningAnalysis(curFile);
end