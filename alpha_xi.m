function [alphaxi] = alpha_xi(theta, h, kdivy, tau, xi)
%alpha_xi calculates alpha 
%   It only takes allowed arguments (plus gamma and delta that I think can't be avoided)
%   The function then calls the principal alpha function after having
%   redefined the variables that alpha needs as inputs.

gamma = 0.5;
delta = 0.05;

r = theta * 1/kdivy;
k = (theta * (h^(1-theta)/r))^(1/(1-theta));
c = k*(1/kdivy -delta); % from consuemr's budget constraints and the government's budget condition. Will be constant!
cbar = c*xi;

alphaxi = alpha(theta, h, kdivy, tau, c,  cbar, gamma);
end

