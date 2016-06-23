% wrapper function -DHB 6/16

function ge_handcontractionBlockImport(files, outfile)

% ge_tapBlockImport(files, outfile)
%
% Imports a block of files in the required format for Dom Parrott's "TAP" 
% experiments. Uses the ge_parrottImport.m function to resolve markers and
% pre-process data. Uses a dir() object as input! (Will break on a list or
% some other format.
%
% MDT
% 2016.06.13
% Version 0.8.3

    fid = fopen(outfile,'w');
    for file = files'
        file.name
        % Subject and condition data:
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        namelist  = strsplit(cleanname, '-');
        subnum    = namelist{1};
        handorder  = namelist{3};
        sessionnumber  = regexprep(namelist{2}, '^S', '');
        % Data analysis to get AIS's:
        x = ge_handContraction(file.name);
        % Write the "obvious" data to the file
        fprintf(fid, '%s,%s,%s,%s,', subnum, sessionnumber, handorder, file.name);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{3});
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f\n', x{5});
      
    end
    fclose(fid);
    fclose('all');     % Testing to fix the matlab open file bug!
end

