function events = extract_events( labels, nsamples )
% This function returns a struct of events from a vector of labels with size [nsamples, 1]
% events contains the following fields (3 arrays with the same length):
%       events.TYP -> event type identifiers, contains the id number or name of each event in the order they occur
%       events.POS -> position in time of each event in terms of number of samples from the beginning of the recording
%       events.DUR -> duration of each event in terms of number of samples from its beginning (events.POS).
% The function assumes the events to be consecutive, thus events.POS(i+1) = events.POS(i) + events.DUR(i) + 1

if nsamples ~= length(labels)
    error('[extract_events] Inconsistent labels dimension with nsamples!')
end

events.POS = find([1; diff(labels)]);
events.DUR = [diff(events.POS) - 1; nsamples - events.POS(end)];
events.TYP = labels(events.POS);

end