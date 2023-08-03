function [matfilepath, matpath, matname] = neuroio_gdf2mat(gdffilepath, subfolder)

    if isfile(gdffilepath) == false
        error('[neuroio] - File %s does not exist', filepath)
    end

    [path,name,ext] = fileparts(gdffilepath);

    if ~strcmp(ext, '.gdf')
        error('[neuroio] - The file must be *.gdf format. *%s is not accepted', ext)
    end

    matpath = [path, '/', subfolder];
    if ~exist(matpath, 'dir')
        mkdir(matpath)
    end 

    matname = [name, '.mat'];
    matfilepath = [matpath, '/', matname];

end