function neurodata = neurocompute_smr_processing(neurodata, settings)

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

    neurodisp('     - Computing preprocessing');
    % Apply DC filter
    if settings.preprocessing.dc.enable
        neurodata.data = neurofilter_dc(neurodata.data);
    end

    % Apply CAR filter
    if settings.preprocessing.car.enable
        neurodata.data = neurofilter_car(neurodata.data);
    end

    % Apply Laplacian filter
    if settings.preprocessing.laplacian.enable
        neurodata.data = neurofilter_laplacian(neurodata.data, lapmask);  % LAPMASK TO BE DEFINED
    end

    % Apply PSD
    neurodisp('     - Computing spectrogram');
    neurodata = neurocompute_spectrogram(neurodata, settings.spectrogram);


    % Save the data
    if settings.common.save_psd
        filesave = neuroio_gdf2mat(neurodata.info.filepath, 'smr');
        neurodisp(['[neuroprocessing] Saving psd to ', filesave])
        save(filesave, 'neurodata');
    end

end