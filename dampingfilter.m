function [b, a] = dampingfilter()
%DAMPINGFILTER  Returns filter vectors B and A, where Hd(z) = B(z)/A(z),
%   where A = [1, a1] and B = g * A. g controls the overall gain, whereas
%   a1 controls frequency-dependent gain. For stability, g < 1;
%   for lowpass response (and stability), -1 < a1 < 0.
% 
%   Ref: V?lim?ki, V., Huopaniemi, J., & Karjalainen, M. (1996). Physical 
%   modelling of plucked string instruments with application to real-time 
%   sound synthesis. J. Audio Eng. Soc, 44(5), 331-353. Retrieved from 
%   http://www.aes.org/e-lib/browse.cfm?elib=7810

% Acoustic guitar
a = [1 -0.3];
g = .995;

% Muted acoustic guitar
% a = [1 -0.8];
% g = .95;

% Harpsichord
% a = [1 -0.01];
% g = .99;

b = g * sum(a);