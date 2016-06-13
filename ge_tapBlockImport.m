function ge_tapBlockImport(files, outfile)

% ge_tapBlockImport(files, outfile)
%
% Imports a block of files in the required format for Dom Parrott's "TAP" 
% experiments. Uses the ge_parrottImport.m function to resolve markers and
% pre-process data.
%
% MDT
% 2016.06.13
% Version 0.8

    fid = fopen(outfile,'w');
    for file = files'
        % Subject and condition data:
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        namelist  = strsplit(cleanname, '-');
        subnum    = regexprep(namelist{1}, '^SUB|sub|Sub','');
        eyeorder  = namelist{2};
        seqorder  = namelist{3};
        % Data analysis to get AIS's:
        x = ge_parrottImport(file.name);
        % Write the "obvious" data to the file
        fprintf(fid, '%s,%s,%s,%s,', subnum, seqorder, eyeorder, file.name);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{3});
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{4});
        % Also the averages:
        avgx = (x{3} + x{4})./2;
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f\n', avgx);
    end
    fclose(fid);
    
end

