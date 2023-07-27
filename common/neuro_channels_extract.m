function [out, labels] = neuro_channels_extract(in, labels, selected)

    if(ismatrix(in) == false)
        error('[%s] - Input data must have 2 dimensions: samples x channels', mfilename)
    end


    if( iscellstr(selected) || isstring(selected) || ischar(selected))
        selectedIdx = label2index(labels, selected);
    else
        selectedIdx = selected;
    end

    warning('off','backtrace');
    for eId = 1:length(selectedIdx)
        chIdx = selectedIdx(eId);
        chLbl = labels{chIdx};
        warning('[%s] - Channel %d (label: ''%s'') has been selected', mfilename, chIdx, chLbl);
    end
    warning('on','backtrace');

    out = in(:, selectedIdx);
    labels = labels(selectedIdx);

end


function index = label2index(labels, selected)

    selected = lower(selected);
    labels   = lower(labels);
    
    if(isstring(selected))
        selected = {convertStringsToChars(lower(selected))};
    elseif (ischar(selected))
        selected = {selected};
    end

    index = [];
    for eId = 1:length(selected)
        index = cat(1, index, find(contains(labels,selected{eId})));
    end
    
end