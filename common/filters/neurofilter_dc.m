function out = neurofilter_dc(in)

    if(ismatrix(in) == false)
        error('[%s] - Input data must have 2 dimensions: samples x channels', mfilename)
    end

    out = in - mean(in, 1);

end