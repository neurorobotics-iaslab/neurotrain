function out = neurofilter_butter(in, sr, ord, fcutoff, type)

    if(ismatrix(in) == false)
        error('[%s] - Input data must have 2 dimensions: samples x channels', mfilename)
    end
    
    if nargin < 5
        type = 'low';
    end

    [b,a] = butter(ord, fcutoff.*2/sr, type);
    out = filtfilt(b,a,in);

end