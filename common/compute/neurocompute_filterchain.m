function neurodata = neurocompute_filterchain(neurodata, settings)

    filterchain = settings.filterchain;
    numFilters = length(filterchain);
    for i = 1:numFilters
        filter = filterchain{i};
        switch filter
            case 'dc'
                neurodata = neuroapply_dc(neurodata);
            case 'butter'
                neurodata = neuroapply_butter(neurodata, settings.butter);
            case 'car'
                neurodata = neuroapply_car(neurodata);
            case 'laplacian'
                neurodata = neuroapply_laplacian(neurodata);
            otherwise
                error('[%s] - The filter %s is not available in the filterchain', mfilename, filter)
        end
        
    end

end

%% Applying functions
function neurodata = neuroapply_dc(neurodata)

    neurodisp('Applying DC filter to the data');
    neurodata.data = neurofilter_dc(neurodata.data);

end

function neurodata = neuroapply_butter(neurodata, settings)

    neurodisp('Applying Butterworth filter to the data');
    neurodata.data = neurofilter_butter(neurodata.data, neurodata.SampleRate, settings.order, settings.fcutoff, settings.type);

end

function neurodata = neuroapply_car(neurodata)

    neurodisp('Applying CAR filter to the data');
    neurodata.data = neurofilter_car(neurodata.data);

end

function neurodata = neuroapply_laplacian(neurodata)

    neurodisp('Applying Laplacian filter to the data');
    neurodata.data = neurofilter_laplacian(neurodata.data);

end


