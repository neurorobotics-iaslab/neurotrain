function neurodata = neurocompute_spectrogram(neurodata, settings)

    s = neurodata.data;
    wlength = settings.wlength;
    wshift = settings.wshift;
    pshift = settings.pshift;
    mlength = settings.mlength;
    SampleRate = neurodata.SampleRate;

    [psd, freqgrid] = neuroproc_spectrogram(s, wlength, wshift, pshift, SampleRate, mlength);
    
    neurodata.data = psd;
    neurodata.freqgrid = freqgrid;
    neurodata.SampleRate = 1/wshift;
    
    neurodata.events.POS = proc_pos2win(neurodata.events.POS, wshift*SampleRate, settings.winconv, mlength*SampleRate);
    neurodata.events.DUR = floor(neurodata.events.DUR/(wshift*SampleRate)) + 1;

end

