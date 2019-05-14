% 16 May 2019
%% Calibration and steady state
% b) 
% Values provided to us in the exercise:
gamma = 0.5;
theta = 0.4;
delta = 0.05;
h = 1/3;
ky = 3; % k/y

% Values I solved for
r = theta/ky;
w = (1-theta) * ky^(theta/(1-theta));

v = tau*w*h;
c = (1-tau)*w*h + r*k + v - k - (1-delta)*k; % true in steady state

% Values provided by part b
tau = 0.3;
cbar = 0;

% alpha and beta
alpha = ((1-tau)*(1-theta)*ky^(theta/(1-theta))) / (h*(c - cbar));
beta = 1 / (theta*(1/ky) + (1 - delta));