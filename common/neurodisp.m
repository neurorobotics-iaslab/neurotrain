function neurodisp(s)

    stack = dbstack('-completenames');

    if length(stack) == 1
        caller = 'neurodisp';
    else
        caller = stack(2).name;
    end

    fprintf('[%s] - %s\n', caller, s);


end