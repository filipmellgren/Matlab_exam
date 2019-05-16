%% Transition paths
clear
%% Parametrization
% We want some value from the old steady state to help us calibrate this
% transition. Specifically, alpha will be used to backward engineer a
% new steady state value for h. We will also need a starting point for k,
% here I call it kold.

gamma = 0.5;
theta = 0.4;
delta = 0.05;
h = 1/3; % This used to be true – but is likely to change under the transition.
kdivy = 3; % k/y
tau0 = 0.3;
cbar = 0;
r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta));
kold = h / ((1/kdivy)^(1/(1-theta))); % starting point for transition of k that leads to everything else. 
v = tau0*w*h; % 0.1248. Note this is the same as revenue2c(30)
c = (1-tau0)*w*h + r*kold + v - kold + (1-delta)*kold;
alpha6 = alpha(theta, h, kdivy, tau0, c, cbar, gamma); % 13.34 - what we need most of all
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

%% a) Solve for new steady state
taubar = 0.31;
xi = 0; % for function compatibility
% The function assumes w as an exogenous variable in equilibrium.
% This time, it's unecessary restrictive:
w = (1-theta)*kdivy^(theta/(1-theta)); % By doing this, it's enough to assume that k/y is still 3 in equilibrium
% The equations above were taken from the pdf, when I solved for a steady
% state in Q2.

h = hfromalpha(taubar, w, xi, gamma, theta, alpha6, kdivy, delta);

%{
% The following holds in steady state. Can be used as checks so everything
% is consistent, but not strictly necessary for the analysis.
r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta)); 
k = h / ((1/kdivy)^(1/(1-theta)));
v = taubar*w*h; %0.1283. Note this is the same as revenue2c(31)
c = (1-taubar)*w*h + r*k + v - k + (1-delta)*k; % true in steady state
%}
%% b c
S = 100;
params = [theta, gamma,taubar, delta, S, alpha6, beta];
transfun = @(x) gfunc(kold, x, params); % Provide a vector of h, evaluated at the parameters
guess = ones(S+1,1) * 1/3; % A good guess is the previous value. Note that we need to add one for period T = index 1.

hvec = fsolve(transfun, guess); % Obtain the h that solves the transition

[zero, k, r, w, c, y, v] = gfunc(kold, hvec, params); % Everything follows as we plug h into the system

subplot(3,2,1);
plot(y)
title('Production')

subplot(3,2,2);
plot(c)
title('Consumption')

subplot(3,2,3);
plot(w)
title('Wages')

subplot(3,2,4);
plot(r)
title('Rents')

subplot(3,2,5);
plot(hvec)
title('Hours')

subplot(3,2,6);
plot(k(1:end-1))
title('Capital')

% Plot the six above jointly. Then plot the following:

plot(v)
title( {'Tax revenue';'Between the steady states, taxes increase, this plot shows evolution from T'})
xlabel('Periods after T')
ylabel('Revenue per wage unit earned in a time period')