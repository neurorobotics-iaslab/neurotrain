function events = find_events(events,labelset)

idx = nan(length(events.TYP), length(labelset));
for l = 1:length(labelset)
    idx(:,l) = events.TYP == labelset(l);
end
tr_idx = any(idx,2);

e = struct2table(events);
e = e(tr_idx,:);
events = table2struct(e,'ToScalar',true);

end

