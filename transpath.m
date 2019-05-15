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
h = 1/3; % is this still assumed?
%% a) Solve for steady state

r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta)); % dislike that I need the wage
k = h / ((1/kdivy)^(1/(1-theta)));
v = taubar*w*h;
c = (1-taubar)*w*h + r*k + v - k + (1-delta)*k; % true in steady state

% alpha and beta
alpha6 = alpha(theta, h, kdivy, taubar, c, cbar, gamma);
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

%% b 
% r and w. Why do I need this again?
rvec = theta * (h./k).^(1-theta);
rlead = rvec(2:end);
w = (1-theta)*(k/h)^(theta);

% From the hh's labour choice
cvec = ((1-taubar).*w)./(alpha .* hvec.^(1/gamma));
clead = cvec(2:end);

S = 100;% jumping forward a little by introducing S here
kvec = ones(S,1);  % preallocate. Actual values found slightly below
kvec(1) = kold; % What we need to get the chain started
s = w.*hvec + rvec.*kvec - cvec; % G's budget is in balance at each period
for i = 2:S
    kvec(i) = (1- delta) * kvec(i) + s(i);
end


% Rewrite the Euler equation
clead./cvec - beta*(rlead + 1 - delta);

