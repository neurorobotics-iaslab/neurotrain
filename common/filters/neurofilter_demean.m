function out = neurofilter_demean(in,dim)
% [signal_filt] = neurofilter_demean(signal, dim)
%
% The function removes the mean from the input signal along a given direction.
%
% Input arguments:
%   - in              Data matrix
%   - dim            Matrix dimension along which the filter is applied
%
% Output arguments:
%   - out          Output data matrix filtered over the desired direction
%                               of the same dimension as the input data matrix
%                              
%
% SEE ALSO: repmat
%
% Stefano Tortora, 2019, stefano.tortora@phd.unipd.it

if(nargin<2)
    dim = 1;
end

if dim > ndims(in)
    error('[%s] - Input dimension cannot be greater than data dimension', mfilename)
end

rep_size = ones(size(size(in)));
rep_size(dim) = size(in,dim);

out = signal - repmat(mean(in, dim), rep_size);

end

