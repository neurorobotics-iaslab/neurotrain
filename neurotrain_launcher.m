function output = neurotrain_launcher(type)

    switch(lower(type))
        case 'smr'
            output = neurotrain_smr_launcher();
        otherwise
            error(['[neurotrain_launcher] - ''' type ''' not yet implemented']);
    end

end