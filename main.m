% 16 May 2019
%% Calibration and steady state
% b) 
% Values provided to us in the exercise:
gamma = 0.5;
theta = 0.4;
delta = 0.05;
h = 1/3;
kdivy = 3; % k/y

% Values provided by part b
tau = 0.3;
cbar = 0;

% Values I solved for
r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta)); % must be wrong

k = h / ((1/kdivy)^(1/(1-theta)));

v = tau*w*h;
c = (1-tau)*w*h + r*k + v - k + (1-delta)*k; % true in steady state

% alpha and beta
alpha = ((1-tau)*w) / (h^(1/gamma)*(c - cbar)); % 13.34
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

% c)
tauvec = (0.01:0.01:0.99)'; % 1% to 99% in steps of 1%
% solve for optimal hours worked
hvec = ((1-tauvec)*w/(c - cbar)).^(gamma); % optimal hours worked, given tau and the others
% solve for new capital stock using f.o.c w.r.t capital
kvec = (theta * (hvec.^(1-theta)) /r).^(1/(1-theta));
% solve for new wage, simply marginal product of labour
wvec = (1-theta)*(kvec./hvec).^theta; % constant
% Government revenue:
tauvec.*wvec.*hvec;

