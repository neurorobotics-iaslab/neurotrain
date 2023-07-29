function output = neurotrain_smr_launcher(InputArgs)
    arguments
        InputArgs.WaitForField char    = 'action'
        InputArgs.WaitForValue logical = true;
        InputArgs.OutputFieldName char = 'settings'
    end
    
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

end