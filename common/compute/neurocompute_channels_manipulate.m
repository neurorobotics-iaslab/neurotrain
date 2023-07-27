function neurodata = neurocompute_channels_manipulate(neurodata, settings)

    if isfield(settings, 'selected')
        [s, labels] = neuro_channels_extract(neurodata.data, neurodata.channels.labels, settings.selected);
        neurodata.data = s;
        neurodata.channels.labels = labels;
    end
    
    if isfield(settings, 'excluded')
        [s, labels] = neuro_channels_exclude(neurodata.data, neurodata.channels.labels, settings.excluded);
        neurodata.data = s;
        neurodata.channels.labels = labels;
    end


end

