function [subjectName, runName, runDate, runTime] = ge_edf2info(EDF_filename)
% [subjectName, runName, runDate, runTime] = function ge_edf2info(EDF_filename)
%
% Convert EDF filename to useful information. Use full EDF name with extension.
%
% Based on the clinical study of mindfulness. Input filenames have three parts
% separated by DASHES. Viz.
%
% 1006-session2-02.11.2015.20.02.38.edf
%
% Returns: subjectName ('1006'); runName ('session2'); runDate ('2015.11.02');
%          & runTime ('20.02'). Note that runDate is corrected to a more
%          standard format, and time is cut to HH.MM!
%
% MDT 2015.11.12

  noEnding    = regexprep(EDF_filename, '\.edf$','');
  itemList    = strsplit(noEnding, '-');
  subjectName = itemList{1};
  runName     = itemList{2};
  dateTime    = itemList{3};
  dte         = strsplit(dateTime, '.');
  runDate     = [dte{3} '.' dte{2} '.' dte{1}];
  runTime     = [dte{4} '.' dte{5}];
end
