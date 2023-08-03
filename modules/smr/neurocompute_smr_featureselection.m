function neurodata = neurocompute_smr_featureselection(neurodata, settings)
    

    settings.taskset.cfeedback = 781; % TO BE REMOVED AND SET IN THE GUI

    if iscell(neurodata)

        for i = 1:length(neurodata)
            neurodata{i} = compute(neurodata{i}, settings);
        end

    else

        neurodata = compute(neurodata, settings);

    end
    
    

end

%% Compute function
function neurodata = compute(neurodata, settings)

    % Concatenate cue and continuous feedback events
    events = neurodata.events;
    cfeed_idx = find(neurodata.events.TYP == settings.taskset.cfeedback);
    cue_idx = cfeed_idx - 1;
    events.DUR(cue_idx) = events.DUR(cue_idx) + events.DUR(cfeed_idx);
    events = find_events(events, settings.taskset.events);
    
    % Extract  vector of class labels (nan otherwise)
    [Ck, Tk] = extract_labels( events, neurodata.samples, settings.taskset.events );
    neurodata.labels = Ck;
    neurodata.trials = Tk;
    
    % Compute CVA feature selection
    [dp, sm, g] = neuroproc_cva(neurodata.data, neurodata.labels);
    neurodata.cva.dp = dp;
    neurodata.cva.struct_mat = sm;
    neurodata.cva.gamma = g;

end





