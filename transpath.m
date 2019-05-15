%% Transition paths
clear
% Next: compute a value of alpha in the old steady state (might already
% have this). Back out a value of h using this. Compute a new steady state.
% This should be same as last period of what gfunc gives me.
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
v = tau0*w*h;
c = (1-tau0)*w*h + r*kold + v - kold + (1-delta)*kold;
% alpha and beta
alpha6 = alpha(theta, h, kdivy, tau0, c, cbar, gamma);
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

%% a) Solve for new steady state
taubar = 0.31;
xi = 0; % for function compatibility
% The function assumes w as an exogenous variable in equilibrium.
% This time, it's too restrictive:
w = (1-theta)*kdivy^(theta/(1-theta)); % By doing this, it's enough to assume that k/y is still 3 in equilibrium
% The equations above were taken from the pdf, when I solved for a steady
% state in Q2.

h = hfromalpha(taubar, w, xi, gamma, theta, alpha6, kdivy, delta);

% TODO: how is the following useful?
r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta)); 
k = h / ((1/kdivy)^(1/(1-theta)));
v = taubar*w*h;
c = (1-taubar)*w*h + r*k + v - k + (1-delta)*k; % true in steady state

%% b c
S = 100;
params = [theta, gamma,taubar, delta, S, alpha6, beta];
transfun = @(x) gfunc(kold, x, params); % Provide a vector of h, evaluated at the parameters
guess = ones(S,1) * 1/3;
transfun(guess)


hvec = fsolve(transfun, guess);

[zero, k, r, w, c, y] = gfunc(kold, hvec, params);
v = taubar*w.*hvec;

subplot(3,2,1);
plot([y, c])
legend('Production', 'Consumption')
title('Production & consumption')

subplot(3,2,2);
plot(w)
title('Wages')

subplot(3,2,3);
plot(r)
title('Rents')

subplot(3,2,4);
plot(hvec)
title('Hours')

subplot(3,2,5);
plot(k(1:end-1))
title('Capital')

subplot(3,2,6);
plot(v)
title('Tax revenue')