function [alphaxi] = alpha_xi(theta, h, kdivy, tau, xi)
%alpha_xi calculates alpha
%   Uses some previously derived relationships to help me avoid algevraic
%   error. xi can be a vector.

% Interpret these as global variables:
% TODO: double check if this is ok
gamma = 0.5;
theta = 0.4;
delta = 0.05;

r = theta * 1/kdivy;
k = (theta * (h^(1-theta)/r))^(1/(1-theta));
c = k*(kdivy^(theta - 1)-delta);
cbar = c*xi;

alphaxi = alpha(theta, h, kdivy, tau, c, k, cbar, gamma);
end

