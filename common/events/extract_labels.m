function [Ck, Tk, TrialStart, TrialDur, CueLb, ntrials] = extract_labels( events, nsamples, labelset )
% This function returns a vector of labels Ck with size [nsamples, 1]
% from a given struct of events with the following fields (3 arrays with the same length):
%       events.TYP -> event type identifiers, contains the id number or name of each event in the order they occur
%       events.POS -> position in time of each event in terms of number of samples from the beginning of the recording
%       events.DUR -> duration of each event in terms of number of samples from its beginning (events.POS).
% In case of consecutive events, events.POS(i+1) = events.POS(i) + events.DUR(i) + 1
% labelset contains the set of labels included in events.TYP to be considered for trial extraction

if nargin < 3
    idx = 1:length(events.TYP);
else
    idx = [];
    for l = labelset
        tmp = find(events.TYP == l);
        if isempty(tmp)
            error('[extract_labels] A label in labelset is not included in the events type!');
        else
            idx = cat(1, idx, tmp);
        end
    end
    idx = sort(idx, 'ascend');
end

TrialStart = events.POS(idx);
TrialDur = events.DUR(idx);
TrialStop  = TrialStart + TrialDur;
CueLb      = events.TYP(idx);
ntrials = length(TrialStart);

% Creating trial labels vector and trial number vector
Ck = nan(nsamples, 1);
Tk = nan(nsamples, 1);
for trId = 1:ntrials
    cstart = TrialStart(trId);
    cstop  = TrialStop(trId);
    ccue   = CueLb(trId);
    
    Ck(cstart:cstop) = ccue; % vector of labels id
    Tk(cstart:cstop) = trId; % vector of trials id
end

if length(Ck) ~= nsamples
    error('[extract_labels] Inconsistent length of labels vector!');
end

end