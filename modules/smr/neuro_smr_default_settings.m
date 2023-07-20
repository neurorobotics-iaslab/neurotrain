function settings = neuro_smr_default_settings()

    %% Pre-processing filters
    settings.processing.filters.dc.enable        = true;
    settings.processing.filters.car.enable       = true;
    settings.processing.filters.laplacian.enable = false;
    
    %% Processing PSD

    settings.processing.psd.wlength    = 0.5;
    settings.processing.psd.pshift     = 0.25;                  
    settings.processing.psd.wshift     = 0.0625; 
    settings.processing.psd.mlength    = 1;

    %% Classification
    settings.classification.train_on_all = false;

    %% Storage
    settings.storage.save      = true;
    settings.storage.recompute = true;
end
