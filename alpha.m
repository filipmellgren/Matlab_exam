function [alpha] = alpha(theta, h, kdivy, tau, c, cbar, gamma)
%alpha for question 2
%   takes the parameters and gives you alpha

r = theta * 1/kdivy;
w = (1-theta) * kdivy^(theta/(1-theta));

alpha = ((1-tau)*w) ./ (h.^(1/gamma).*(c - cbar));

end

