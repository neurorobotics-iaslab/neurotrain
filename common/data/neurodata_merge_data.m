function neurodata = neurodata_merge_data(neurodataset)

NumFiles = length(neurodataset);

neurodata = neurodata_default_struct();
fn = fieldnames(neurodata);
for i = 1:length(fn)
   neurodata.(fn{i}) = neurodataset{1}.(fn{i});
end
neurodata.info.date = char(datetime("today", 'Format', 'yyyyMMdd'));
neurodata.info.time = 'merged';
neurodata.info.filepath = 'merged';
neurodata.info.files = cell(NumFiles, 1); neurodata.info.files{1} = neurodataset{1}.info.filepath;

datadims = size(neurodata.data, 2:ndims(neurodata.data));

for f = 2:NumFiles

    % Info.subject
    if ~strcmp(neurodataset{f}.info.subject, neurodata.info.subject)
        error('[%s] - Data must come from the same subject to be merged', mfilename)
    end
    % Info.modality
    if ~strcmp(neurodataset{f}.info.modality, neurodata.info.modality)
        neurodata.info.modality = 'merged';
    end
    % Info.task
    if ~strcmp(neurodataset{f}.info.task, neurodata.info.task)
        error('[%s] - Data must have the same task to be merged', mfilename)
    end
    % Info.modality
    if ~strcmp(neurodataset{f}.info.extra, neurodata.info.extra)
        neurodata.info.extra = 'merged';
    end
    % Info.filepath
    neurodata.info.files{f} = neurodataset{f}.info.filepath;

    % Channels
    if ~isequal(neurodataset{f}.channels.labels, neurodata.channels.labels)
        error('[%s] - Data must have the channel labels to be merged', mfilename)
    end

    % Events
    neurodata.events.TYP = [neurodata.events.TYP; neurodataset{f}.events.TYP];
    neurodata.events.POS = [neurodata.events.POS; neurodataset{f}.events.POS + neurodata.samples];
    neurodata.events.DUR = [neurodata.events.DUR; neurodataset{f}.events.DUR];

    % Data
    currdims = size(neurodataset{f}.data, 2:ndims(neurodataset{f}.data));
    if ~isequal(currdims, datadims)
        error('[%s] - Data must have the same size to be merged', mfilename)
    end
    neurodata.data = [neurodata.data; neurodataset{f}.data];
    neurodata.samples = size(neurodata.data, 1);

    if neurodataset{f}.SampleRate ~= neurodata.SampleRate
        error('[%s] - Data must have the same SampleRate to be merged', mfilename)
    end


end



end