function h = neuroio_import_header(filepath)

    if isfile(filepath) == false
        error('[neuroio] - File %s does not exist', filepath)
    end

    if exist('sopen', 'file') == false
        error('[neuroio] - biosig toolbox must be in the MATLAB path')
    end

    h = sopen(filepath, 'r');

end