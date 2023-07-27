function neurodata = neurodata_default_struct()

    %% Info
    neurodata.info.subject = '';
    neurodata.info.date = {''};
    neurodata.info.time = {''};
    neurodata.info.modality = {''};
    neurodata.info.task = {''};
    neurodata.info.extra = {''};
    neurodata.info.filepath = {''};
    
    %% Data
    neurodata.data = [];
    neurodata.SampleRate = 0; % [Hz]
    
    %% Channels
    neurodata.channels.labels = [];
    neurodata.channels.locs = [];
    
    %% Events
    neurodata.events.TYP = [];
    neurodata.events.POS = [];
    neurodata.events.DUR = [];
    

end
