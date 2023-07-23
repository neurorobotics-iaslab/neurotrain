function montages = neurodata_get_montages(rootdir)

    if isfolder(rootdir) == false
        error(['The provided path ''' rootdir ''' does not exist']);
    end


    entries = dir(rootdir);
    montagefiles = [];
    for dId = 1:length(entries)
        centry = entries(dId);
        [~, ~, ext] = fileparts(centry.name);
        if(strcmpi(ext, '.layout'))        
            montagefiles = cat(1, montagefiles, {fullfile(centry.folder, centry.name)});
        end
    end

    montages = [];
    for mId = 1:length(montagefiles)
        filepath = montagefiles{mId};
        T = readtable(filepath, 'FileType', 'text');

        [~, name, ext] = fileparts(filepath);

        cmontage.name   = [name ext];
        cmontage.index  = table2array(T(:, 1))';
        cmontage.labels = table2cell(T(:, 2))';

        montages = cat(1, montages, cmontage);

    end

end


