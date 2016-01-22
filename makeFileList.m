function [fileList, numFiles] = makeFileList(GLOB)
    % [fileList, numFiles] = makeFileList(GLOB)
    %
    % Uses a glob to generate a list of files and returns the list and the
    % count of files in the list.
    %
    % MDT
    % 2016.01.21
    
    fileList           = ls(GLOB);
    [numFiles useless] = size(fileList);
end