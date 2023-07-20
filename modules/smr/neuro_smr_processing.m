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

    %% Extract data informations
    info.events.TYP = h.EVENT.TYP;
    info.events.POS = h.EVENT.POS;
    info.events.DUR = h.EVENT.DUR;
    info.SampleRate = h.SampleRate;


    %% Exclude channels
    settings.processing.channels.excluded = {'status', 'EOG', 'FP1'};
    [s, labels] = neuro_channels_extract(s, h.Label, settings.processing.channels.excluded);

    %% Apply filters

    if settings.processing.filters.dc.enable == true
        neurodisp('Applying DC filter to the data');
        s = neurofilter_dc(s);
    end

    if settings.processing.filters.car.enable == true
        neurodisp('Applying CAR filter to the data');
        s = neurofilter_car(s);
    end

    if settings.processing.filters.laplacian.enable == true
        neurodisp('Applying Laplacian filter to the data');
        s = neurofilter_laplacian(s);
    end

    %% Apply PSD
    neurodisp('Computing spectrogram');
    [psd, freqgrid] = proc_spectrogram(s, settings.processing.psd.wlength, settings.processing.psd.wshift, settings.processing.psd.pshift, info.SampleRate, settings.processing.psd.mlength);



    %% Save the data







end