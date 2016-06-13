function dodom(files, outfile)

    fid = fopen(outfile,'w');
    
    for file = files'
        x = ge_parrottImport(file.name);
        fprintf(fid, '%s,', file.name);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f', x{3});
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f\n', x{4});
    end
    
    fclose(fid);
    
end

