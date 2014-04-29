function [D, d] = getdelaylen(f, fs)
%GETDELAYLEN  Returns integer delay line length `D` and fractional delay 
%   line length `d` based on desired frequency `f` and sampling frequency
%   `fs`. `d` should be within the range of [0.1, 1.1] for stability.
%
%   Ref: Smith, J. O. (2005). MUS420/EE367A Lecture 4A, Interpolated Delay 
%   Lines, Ideal Bandlimited Interpolation, and Fractional Delay Filter 
%   Design. Center for Computer Research in Music and Acoustics (CCRMA), 
%   Stanford University, Stanford, CA. Retrieved from 
%   https://ccrma.stanford.edu/~jos/Interpolation/Interpolation_4up.pdf

D = floor(fs/f);
d = fs/f - D;

if d < 0.1
    d = d + 1;
    D = D - 1;
end