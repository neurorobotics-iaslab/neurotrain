function [out, labels] = neuro_channels_exclude(in, labels, excluded)

    if(ismatrix(in) == false)
        error('[%s] - Input data must have 2 dimensions: samples x channels', mfilename)
    end


    if( iscellstr(excluded) || isstring(excluded) || ischar(excluded))
        excludedIdx = label2index(labels, excluded);
    else
        excludedIdx = excluded;
    end

    warning('off','backtrace');
    for eId = 1:length(excludedIdx)
        chIdx = excludedIdx(eId);
        chLbl = labels{chIdx};
        warning('[%s] - Channel %d (label: ''%s'') has been excluded', mfilename, chIdx, chLbl);
    end
    warning('on','backtrace');

    labelIdx = 1:length(labels);
    index = setdiff(labelIdx, excludedIdx, 'stable');
    out = in(:, index);
    labels = labels(index);

end


function index = label2index(labels, excluded)

    excluded = lower(excluded);
    labels   = lower(labels);
    
    if(isstring(excluded))
        excluded = {convertStringsToChars(lower(excluded))};
    elseif (ischar(excluded))
        excluded = {excluded};
    end

    index = [];
    for eId = 1:length(excluded)
        index = cat(1, index, find(contains(labels,excluded{eId})));
    end
    
end