function neurodata = neurocompute_spectrogram(neurodata, settings)

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

    s = neurodata.data;
    wlength = settings.window_length;
    wshift = settings.window_shift;
    pshift = settings.inner_overlap;
    mlength = settings.average;
    SampleRate = neurodata.SampleRate;

    [psd, freqgrid] = neuroproc_spectrogram(s, wlength, wshift, pshift, SampleRate, mlength);
    
    neurodata.data = psd;
    neurodata.samples = size(psd,1);
    neurodata.freqgrid = freqgrid;
    neurodata.SampleRate = 1/wshift;
    
    neurodata.events.POS = proc_pos2win(neurodata.events.POS, wshift*SampleRate, 'backward', mlength*SampleRate);
    neurodata.events.DUR = floor(neurodata.events.DUR/(wshift*SampleRate)) + 1;

end

