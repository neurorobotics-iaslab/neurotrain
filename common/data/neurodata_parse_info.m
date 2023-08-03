function neurodata = neurodata_parse_info(neurodata,filepath)

    [~,filename,~] = fileparts(filepath);
    
    parts = strsplit(filename, '.');
    if length(parts) < 5
        
        neurodata.info.filepath = filepath;
        
    elseif length(parts) == 5
        
        neurodata.info.subject = parts{1};
        neurodata.info.date = parts{2};
        neurodata.info.time = parts{3};
        neurodata.info.modality = parts{4};
        neurodata.info.task = parts{5};
        neurodata.info.filepath = filepath;
        
    elseif length(parts) > 5
        
        neurodata.info.subject = parts{1};
        neurodata.info.date = parts{2};
        neurodata.info.time = parts{3};
        neurodata.info.modality = parts{4};
        neurodata.info.task = parts{5};     
        neurodata.info.extra = strjoin(parts(6:end),'.');
        neurodata.info.filepath = filepath;
        
    end
     

end
