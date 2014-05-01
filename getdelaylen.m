function [D, d] = getdelaylen(f, fs, dp_b, dp_a)
%GETDELAYLEN  Returns integer delay line length D and fractional delay 
%   line length d based on desired frequency f, sampling frequency
%   fs, and damping filter coefficients dp_b and dp_a. d should be within 
%   the range of [0.1, 1.1] for stability.
%
%   Ref: Smith, J. O. (2005). MUS420/EE367A Lecture 4A, Interpolated Delay 
%   Lines, Ideal Bandlimited Interpolation, and Fractional Delay Filter 
%   Design. Center for Computer Research in Music and Acoustics (CCRMA), 
%   Stanford University, Stanford, CA. Retrieved from 
%   https://ccrma.stanford.edu/~jos/Interpolation/Interpolation_4up.pdf

% Get phase delay produced by damping filter.
phi = phasedelay(dp_b, dp_a, [0 f], fs);
phi = phi(end) * fs / (2*pi);   % convert to samples

D = floor(fs/f - phi);
d = fs/f - phi - D;

% 0.1 < d < 1.1
if d < 0.1
    d = d + 1;
    D = D - 1;
end