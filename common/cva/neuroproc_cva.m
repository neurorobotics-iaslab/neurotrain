function [dp, sm, g] = neuroproc_cva(data, labels)
    
    nsamples = size(data, 1);
    ndim = ndims(data);
    ncolons = repmat({':'},1,ndim-1);
    
    % Vectorize data if not a matrix
    data = reshape(data, [nsamples, prod(ndim(2:end))]);

    F = data(~isnan(labels), ncolons{:});
    Fk = labels(~isnan(labels));    
    
    if(isequal(length(unique(Fk)), 2) == false)
        error('[%s] - Only two class labels are allowed. %d class labels given', mfilename, num2str(length(unique(Fk))))
    end
    
    % Calculate CVA discriminability matrix
    [dp, sm, ~, g] = cva_tun_opt(F, Fk);
    
    dp = reshape(dp, [ndim(2:end)]);
    sm = reshape(sm, [ndim(2:end)]);
    g = reshape(g, [ndim(2:end)]);

end

