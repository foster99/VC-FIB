function [kernel, s, d] = sobelkernel(size, varargin)

% Parameter checking.
if ~isempty(varargin) && strcmp(varargin(1), 'normalise')
    normalisation = 1/8;
else
    normalisation = 1;
end
% The dafault 3x3 Sobel kernel.
s = normalisation * [1 2 1];
d = [1 0 -1];
% Convolve the default 3x3 kernel to the desired size.
for i=1:size-3
    s = normalisation * conv([1 2 1], s);
    d = conv([1 2 1], d);
end
% Output the kernel.
kernel = s'*d;
kernel = kernel;
end