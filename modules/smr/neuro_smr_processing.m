function neuro_smr_processing(settings, filepath)

    
    if isfile(filepath) == false
        error('[neuroprocessing] - File %s does not exist', filepath)
    end

    if exist('sload', 'file') == false
        error('[neuroprocessing] - sload from biosig toolbox must be in the MATLAB path')
    end


    %% Loading file
    try 
        [s, h] = sload(filepath);
    catch
        error('[neuroprocessing] - Cannot load the GDF file %s', filepath);
    end
    

    %% Create neurodata struct
    neurodata = neurodata_default_struct();
    neurodata = neurodata_parse_info(neurodata, filepath);
    neurodata.settings = settings;
    
    neurodata.data = s;
    neurodata.SampleRate = h.SampleRate;
    
    neurodata.channels.labels = h.Label;
    
    neurodata.events.TYP = h.EVENT.TYP;
    neurodata.events.POS = h.EVENT.POS;
    neurodata.events.DUR = h.EVENT.DUR;
    
    
    %% Exclude channels
    settings.processing.channels.excluded = {'status', 'EOG', 'FP1'}; % TO BE REMOVED AND SET IN THE GUI
    neurodata = neurocompute_channels_manipulate(neurodata, settings.processing.channels);
    

    %% Apply filters
    settings.processing.filters.filterchain = {'dc', 'car'};  % TO BE REMOVED AND SET IN THE GUI
    neurodata = neurocompute_filterchain(neurodata, settings.processing.filters);


    %% Apply PSD
    neurodisp('Computing spectrogram');
    neurodata = neurocompute_spectrogram(neurodata, settings.processing.psd);


    %% Save the data
    if settings.storage.save
        [path,name,ext] = fileparts(filepath);
        filesave = [path, '/', name, '.mat'];
        save(filesave, 'neurodata');
    end


end