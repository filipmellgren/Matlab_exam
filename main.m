% 16 May 2019
%% 2 Calibration and steady state
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
w = (1-theta) * kdivy^(theta/(1-theta));

k = h / ((1/kdivy)^(1/(1-theta)));

v = tau*w*h;
c = (1-tau)*w*h + r*k + v - k + (1-delta)*k; % true in steady state

% alpha and beta
alpha2b = alpha(theta, h, kdivy, tau, c, cbar, gamma);
%alpha = ((1-tau)*w) / (h^(1/gamma)*(c - cbar)); % 13.34
beta = 1 / (theta*(1/kdivy) + (1 - delta)); % 0.9231

% c)
tauvec = (0.01:0.01:0.99)'; % 1% to 99% in steps of 1%
xi = 0; % this is assumed in the exercise. I need it to define cbar inside the function.
revenue2c = govrev(tauvec, w, c, xi, gamma, theta,r, alpha2b, kdivy, delta); 

%% 3 Subsistence consumption
% a
xi_vec = 0.1:0.01:0.9; % all xi values we care about
alpha3a = alpha_xi(theta, h, kdivy, tau, xi_vec); % Note that function accepts the vector value
plot(xi_vec, alpha3a)
xlabel('xi')
ylabel('alpha')
title('Disutility of labour explodes with higher subsistence consumption')

% b)
xi = 1/3; % New assumption
alpha3b = alpha_xi(theta, h, kdivy, tau, xi);
revenue3b = govrev(tauvec, w, c, xi, gamma, theta,r, alpha3b,  kdivy, delta);

%% 4
cbar = 0.2;
params4 = [gamma, theta, delta, cbar, beta];
 % Need to create an anonymous func so that I can provide it to fsolve.
fun = @(x) alpharoot(x, h, params4, tau);
% part a
alpha4a = fsolve(fun, alpha2b); % Gives me a calivrated alpha value

fun2 = @(x) alpharoot(alpha4a, x, params4, tauvec);
hguess = ones(length(tauvec),1);
% Part b, solve for h given alpha:
h4a = fsolve(fun2,hguess);
% part c, calculate tax revenue using a function. 
revenue4c = govrevroot(theta, h4a, r, tauvec);

%% 5 comparative statics
plot([revenue2c, revenue3b, revenue4c])
legend('revenue2c','revenue3b', 'revenue4c')
title( {'Laffer curves';'These plots display steady state revenue for a given tax rate'})
xlabel('Tax rate (percent of income)')
ylabel('Government revenue')

% Revenue for 2c and 3b have visibly similar revenue maximising tax rates.
% Check if they are the same:
max(revenue2c) - max(revenue3b); % Nope, difference of -0.042.