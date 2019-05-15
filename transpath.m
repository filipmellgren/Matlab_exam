%% Transition paths
clear
% Parameters
cbar = 0;
tau0 = 0.3;
taubar = 0.31;
gamma = 0.5;
theta = 0.4;
delta = 0.05;
kdivy = 3; % k/y
h = 1/3; % Can we still assume that this holds?

%% a) Solve for new steady state
% TODO: donät thiunk this can be correct

r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta)); 
k = h / ((1/kdivy)^(1/(1-theta)));
v = taubar*w*h;
c = (1-taubar)*w*h + r*k + v - k + (1-delta)*k; % true in steady state

% alpha and beta
alpha6 = alpha(theta, h, kdivy, taubar, c, cbar, gamma);
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

%% b c
S = 100;
params = [theta, gamma,taubar, delta, S, alpha6, beta];
kold = k; % Or whatever TODO
transfun = @(x) gfunc(kold, x, params); % Provide a vector of h, evaluated at the parameters
guess = ones(S,1) * 1/3;
transfun(guess)


hvec = fsolve(transfun, guess);

[zero, k, r, w, c] = gfunc(kold, hvec, params);
y = k(1:end-1).^(theta).*hvec.^(1-theta);
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
plot(k)
title('Capital')

subplot(3,2,6);
plot(v)
title('Tax revenue')

plot([y, c, w, r, hvec, k(1:end-1), v])
