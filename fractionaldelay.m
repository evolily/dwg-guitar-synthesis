function [b, a] = fractionaldelay(d)
%FRACTIONALDELAY  Returns 1st-order allpass interpolator vector B and A,
%   where fractional delay filter F(z) = B(z)/A(z). 
%
%   Ref: Smith, J. O. (2005). MUS420/EE367A Lecture 4A, Interpolated Delay 
%   Lines, Ideal Bandlimited Interpolation, and Fractional Delay Filter 
%   Design. Center for Computer Research in Music and Acoustics (CCRMA), 
%   Stanford University, Stanford, CA. Retrieved from 
%   https://ccrma.stanford.edu/~jos/Interpolation/Interpolation_4up.pdf

eta = (1-d) / (1+d);
b = [eta 1];
a = [1 eta];