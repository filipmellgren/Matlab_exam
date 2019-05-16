%% Transition paths. Main file for question 6. 
clear
%% Parametrization
% We want some value from the old steady state to help us calibrate this
% transition. Specifically, alpha will be used to backward engineer a
% new steady state value for h. We will also need a starting point for k,
% here I call it kold. Notice that k in T-1 = k in T = kold because of the
% law of motion of assets (and thereby capital).

gamma = 0.5;
theta = 0.4;
delta = 0.05;
h = 1/3; % This used to held true – but is likely to change under the transition.
kdivy = 3; % k/y
tau0 = 0.3;
cbar = 0;
r = theta * 1/kdivy; % as derived in 2a.
w = (1-theta) * kdivy^(theta/(1-theta)); % also as in 2a.
kold = h / ((1/kdivy)^(1/(1-theta))); % From Eqn 12. It's the starting point for transition of k that leads to everything else. 
v = tau0*w*h; % 0.1248. Note this is the same as revenue2c(30) – Good!
c = (1-tau0)*w*h + r*kold + v - kold + (1-delta)*kold;
alpha6 = alpha(theta, h, kdivy, tau0, c, cbar, gamma); % 13.34 - what we need most of all
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

%% a) Solve for new steady state. Most of this is somewhat redundant.
taubar = 0.31; % Except for this. This is the tax under the new policy regime!
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
%{
For this part, the function gfunc.m is crucial. The present file is the principal
one that drives the logic forward, but everything is determined inside
gfunc.m.
%}
% Parameterize
S = 100; 
params = [theta, gamma,taubar, delta, S, alpha6, beta];

% Provide a vector of h ("x"), evaluated at the parameters
transfun = @(x) gfunc(kold, x, params); 
guess = ones(S+1,1) * 1/3; % A good guess is the previous value. Note that we need to add one for period T, which has index=1.

% Obtain the h that solves the transition.
hvec = fsolve(transfun, guess); 

% Everything follows as we plug h into the system:
[zero, k, r, w, c, y, v] = gfunc(kold, hvec, params); 
% I think it's good practice to double check that zero is a vector of zeros. 
% This was indeed true.

% Now, we're good to plot what followed from what fsolve found:
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

%% Plot the six above jointly. Then plot the following:
% Having to plot seven things made me prefer a 3x2 + 1 layout.
plot(v)
title( {'Tax revenue';'Between the steady states, taxes increase, this plot shows evolution from T'})
xlabel('Periods after T')
ylabel('Revenue per wage unit earned in a time period')