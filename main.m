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
%TODO functions files for these guys
r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta)); % must be wrong

k = h / ((1/kdivy)^(1/(1-theta)));

v = tau*w*h;
c = (1-tau)*w*h + r*k + v - k + (1-delta)*k; % true in steady state

% alpha and beta
alpha2b = alpha(theta, h, kdivy, tau, c, k, cbar, gamma);
%alpha = ((1-tau)*w) / (h^(1/gamma)*(c - cbar)); % 13.34
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

% c)
tauvec = (0.01:0.01:0.99)'; % 1% to 99% in steps of 1%
xi = 0; % this is assumed in the exercise. I need it to define cbar inside the function.
revenue2c = govrev(tauvec, w, c, xi, gamma, theta,r); % does not depend on alpha – correct?

%% 3 Subsistence consumption
% a
i = 1;
xi_vec = 0.1:0.01:0.9;
alpha3a = alpha_xi(theta, h, kdivy, tau, xi_vec);
plot(xi_vec, alpha3a)

% b)
xi = 0.3;
alpha3b = alpha_xi(theta, h, kdivy, tau, xi);
revenue3a = govrev(tauvec, w, c, xi, gamma, theta,r);

%% 4
