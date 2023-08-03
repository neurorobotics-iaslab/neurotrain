function neurodata = neurodata_load_data(settings, filepath)

    
    if isfile(filepath) == false
        error('[neurodata_load_data] - File %s does not exist', filepath)
    end

    if exist('sload', 'file') == false
        error('[neurodata_load_data] - sload from biosig toolbox must be in the MATLAB path')
    end


    %% Loading file
    try 
        [s, h] = sload(filepath);
    catch
        error('[neurodata_load_data] - Cannot load the GDF file %s', filepath);
    end
    

    %% Create neurodata struct
    neurodata = neurodata_default_struct();
    neurodata = neurodata_parse_info(neurodata, filepath);
    neurodata.settings = settings;
    
    neurodata.data = s;
    neurodata.samples = size(s,1);
    neurodata.SampleRate = h.SampleRate;
    
    neurodata.channels.labels = h.Label;
    
    neurodata.events.TYP = h.EVENT.TYP;
    neurodata.events.POS = h.EVENT.POS;
    neurodata.events.DUR = h.EVENT.DUR;
    
    
    %% Exclude channels
    %settings.processing.channels.excluded = {'status', 'EOG', 'FP1'}; % TO BE REMOVED AND SET IN THE GUI
    %neurodata = neurocompute_channels_manipulate(neurodata, settings.processing.channels);

end