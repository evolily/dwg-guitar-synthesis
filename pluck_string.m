close all; clear all; clc

%% Constant
LEN = 3;    % length of note (sec)
FREQ = 261.626; % frequency of note (Hz)

%% Read Body Response File
[ex, fs] = wavread('gtrbody.wav');  % excitation signal

%% Design Damping Filter Hd(z)
% Use a one-pole IIR to simulate damping filter.
[dp_b, dp_a] = dampingfilter;

%% Get Delay Line Length
% D is for integer delay line z^(-D).
% d is for fractional delay F(z).
[D, d] = getdelaylen(FREQ, fs, dp_b, dp_a);

%% Design Fractional Delay F(z)
% Use 1st-order allpass as fractional delay.
[fr_b, fr_a] = fractionaldelay(d);

%% Build String Filter S(z) by Consolidating Filters into B(z)/A(z) Form
% Consolidate damping filter and fractional delay.
num = conv(dp_b, fr_b);
den = conv(dp_a, fr_a);

% S(z) = 1 / (1 - Hd(z)F(z)z^(-D))
%      = 1 / (1 - NUM(z)/DEN(z)*z(-D))
%      = DEN(z) / (DEN(z) - NUM(z)*z^(-D))
%      = B(z) / A(z)
% Hence, B(z) = DEN(z)
%        A(z) = DEN(z) - NUM(z)*z^(-D)
b = den;                                % B(z)
a = [den zeros(1, D-length(den)) -num]; % A(z)

%% Synthesis Plucked String Sound
x = [ex; zeros(LEN*fs-length(ex), 1)];
y = filter(b, a, x);

% Normalize y
y = y/(max(abs(y))+.1);

%% Plot Magnitude Spectrum
nfft = 8 * LEN * fs;
Y = fft(y, nfft)/(LEN*fs);
Ymag = 20*log10(abs(Y(1:nfft/2+1)));
F = fs/2 * linspace(0, 1, nfft/2+1);

figure; plot(F, Ymag)
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
datacursormode on

%% Save Synthetic File
wavwrite(y, fs, 'synthetic.wav')

%% Playback
soundsc(y, fs)