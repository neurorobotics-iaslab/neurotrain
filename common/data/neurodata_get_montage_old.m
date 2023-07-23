function montage = neuro_get_montage(name)


    montage.layouts = {'eeg.gtec.smr.16', 'eeg.gtec.smr.eog.16', 'eeg.antneuro.smr.32', 'eeg.antneuro.smr.eog.33', 'eeg.antneuro.64'};
    
    name = lower(name);
    if isempty(find(contains(montage.layouts, name), 1))
        error(['[neuro_channels_layout] - The provided name ''' name ''' is not in the default layouts']);
    end


    switch(name)
        case 'eeg.gtec.smr.16'
            labels = { 'FZ', 'FC3', 'FC1', 'FCZ', 'FC2', 'FC4',  'C3',  'C1', ...
                       'CZ',  'C2',  'C4', 'CP3', 'CP1', 'CPZ', 'CP2', 'CP4' };
            index  = 1:length(labels);
        case 'eeg.gtec.smr.eog.16'
            labels = {'FZ', 'FC3', 'FC1', 'FCZ', 'FC2', 'FC4',  'C3',  'C1', ...
                      'CZ',  'C2',  'C4', 'FP1', 'CP1', 'CPZ', 'CP2', 'FP2'};
            index  = 1:length(labels);
        case 'eeg.antneuro.smr.32'
            labels = { 'FP1', 'FP2', 'FZ', 'FC5', 'FC1', 'FC2', 'FC6',  'C3',  'CZ', ... 
                        'C4', 'CP5', 'CP1', 'CP2', 'CP6',  'P3', 'Pz',  'P4',  'F1', ... 
                        'F2', 'FC3', 'FCZ', 'FC4', 'C5',  'C1',  'C2',  'C6', 'CP3', ...
                       'CP4',  'P5',  'P1', 'P2',  'P6'};
            index  = 1:length(labels);
        case 'eeg.antneuro.smr.eog.33' 
            labels = { 'FZ', 'FC5', 'FC1', 'FC2', 'FC6',  'C3', 'CZ',  'C4',  ...
                      'CP5', 'CP1', 'CP2', 'CP6',  'P3',  'Pz', 'P4', 'POZ', ...
                      'EOG',  'F1',  'F2', 'FC3', 'FCZ', 'FC4', 'C5',  'C1',  ...
                       'C2',  'C6', 'CP3', 'CP4',  'P5',  'P1', 'P2',  'P6'};
            index  = 1:length(labels);
        case 'eeg.antneuro.64'
            labels = {'FP1', 'FPz', 'FP2',  'F7',  'F3',  'Fz',  'F4',  'F8', 'FC5', 'FC1', 'FC2', ... 
                      'FC6',  'M1',  'T7',  'C3',  'Cz',  'C4',  'T8',  'M2', 'CP5', 'CP1', 'CP2', ...
                      'CP6',  'P7',  'P3',  'Pz',  'P4',  'P8', 'POz',  'O1',  'O2', 'EOG', 'AF7', ...
                      'AF3', 'AF4', 'AF8',  'F5',  'F1',  'F2',  'F6', 'FC3', 'FCz', 'FC4',  'C5', ...
                       'C1',  'C2',  'C6', 'CP3', 'CP4',  'P5',  'P1',  'P2',  'P6', 'PO5', 'PO3', ...
                      'PO4', 'PO6', 'FT7', 'FT8', 'TP7', 'TP8', 'PO7', 'PO8', 'Oz'};
            index  = 1:length(labels);
    end

    montage.labels = labels;
    montage.index  = index;
    montage.name   = name;

end


