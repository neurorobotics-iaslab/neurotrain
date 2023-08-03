function settings = neurotrain_smr_launcher(InputArgs)
    arguments
        InputArgs.WaitForField char    = 'action'
        InputArgs.WaitForValue logical = true;
        InputArgs.OutputFieldName char = 'settings'
    end
    
    %% Launching SMR train GUI
    output = [];
    settingsgui = NeuroTrainSmr();

    % Wait for the GUI
    waitfor(settingsgui, InputArgs.WaitForField, InputArgs.WaitForValue);

    % Get output field
    if isvalid(settingsgui) == true
        output = settingsgui.(InputArgs.OutputFieldName);
    end

    % Delete GUI
    delete(settingsgui);

    % Parsing GUI output
    files = output.files;
    settings = output.options;

    %% Loading neurodata
    files{1}.filepath = '/home/stetor/neurodata/s1.20230201.112519.online.mi_bhbf.exponential_sym.gdf'; % TO BE REMOVED
    files{2}.filepath = '/home/stetor/neurodata/s1.20230201.120823.online.mi_bhbf.exponential_sym.gdf'; % TO BE REMOVED
    NumFiles = length(files);

    neurodataset = cell(NumFiles, 1);
    for f = 1:NumFiles
        neurodisp(['[neurotrain] Loading data from ', files{1}.filepath])
        neurodataset{f} = neurodata_load_data(settings, files{f}.filepath);
    end

    %% Compute SMR processing
    if settings.common.recompute_psd

        neurodataset = neurocompute_smr_processing(neurodataset, settings);

    else
        
        for f = 1:NumFiles
            smrfile = neuroio_gdf2mat(neurodataset{f}.info.filepath, 'smr');
            if isfile(smrfile) == false                
                neurodataset{f} = neurocompute_smr_processing(neurodataset{f}, settings);
            else
                neurodisp(['[neurotrain] Loading psd from ', smrfile])
                neurodataset{f} = load(smrfile);
            end

        end

    end

    % Compute log spectrum
    for f = 1:NumFiles
        neurodataset{f}.data = log(neurodataset{f}.data);
    end
    
    %% Compute feature selection
    if settings.selection.stability
        
        % Compute feature selection on each file
        for f = 1:NumFiles
            neurodataset{f} = neurocompute_smr_featureselection(neurodataset{f}, settings);
        end

    else
        
        % Merging neurodata of all files
        neurodataset = neurodata_merge_data(neurodataset);

        % Compute feature selection on all the dataset
        neurodataset = neurocompute_smr_featureselection(neurodataset, settings);

    end
    



end