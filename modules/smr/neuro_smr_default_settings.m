function settings = neuro_smr_default_settings()
    
    %% Processing

    settings.processing.psd.wlength    = 0.5;
    settings.processing.psd.pshift     = 0.25;                  
    settings.processing.psd.wshift     = 0.0625; 
    settings.processing.psd.mlength    = 1;
    settings.processing.psd.winconv    = 'backward';

    %% Classification
    settings.classification.train_on_all = false;

    %% Storage
    settings.storage.save      = true;
    settings.storage.recompute = true;
end
