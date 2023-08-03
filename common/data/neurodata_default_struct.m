function neurodata = neurodata_default_struct()

    %% Info
    neurodata.info.subject = 'unknown';
    neurodata.info.date = 'unknown';
    neurodata.info.time = 'unknown';
    neurodata.info.modality = 'unknown';
    neurodata.info.task = 'unknown';
    neurodata.info.extra = '';
    neurodata.info.filepath = 'unknown';
    
    %% Data
    neurodata.data = [];
    neurodata.samples = 0;
    neurodata.SampleRate = 0; % [Hz]
    
    %% Channels
    neurodata.channels.labels = [];
    %neurodata.channels.locs = [];
    
    %% Events
    neurodata.events.TYP = [];
    neurodata.events.POS = [];
    neurodata.events.DUR = [];
    

end
