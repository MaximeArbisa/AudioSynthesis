%% Script for synthesis of a violin sound
clear all;
close all;
clc;

%% Read signal
[x, Fs] = audioread('Violin/Vibrato_G3.aif');
x = x(:,1); %(x(:,1)+x(:,2))/2; % Stereo --> Mono
%soundsc(x, Fs);
%N = length(x);

% Display original sound
figure();
plot(real(x));
title('Real sound');

%% HR Method on real sound x 
% Parameters
N = 2000; % Length of signal excerpted - Analysis window length
K = 200; % Signal space dimension
n = 1024; % Full space dimension (signal + noise)
         % Noise space dimension = n-K
l = N-n+1; % N = n+l-1, l completes n to get N

% Extraction of the signal
x = x(50000:50000+N); % Start at sample 100000

% Method ESPRIT + LeastSquares
[delta_e, f_e] = ESPRIT(x, n, K);
[a_e, phi_e] = LeastSquares(x, delta_e, f_e);

%% Re-synthesis of the signal
length = 50*N; % dur�e plus longue pour mettre en �vidence les r�sonances
s = Synthesis(length, delta_e, f_e, a_e, phi_e);

% Display results
figure();
plot(real(s));
title('Sound synthesised');

% Listen to result
soundsc(real(s), Fs);

figure();
plot(abs(f_e*Fs), a_e);

%% ESTER Method
bestK = ESTER(x, n, 1)

