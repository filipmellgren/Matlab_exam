function [zero] = alpharoot(alpha,hours, params, tau)
%alpharoot Uses relationship provided, but having zero on the rhs
%   This means a routine like fsolve can be used to solve for the value of
%   alpha

gamma = params(1);
theta = params(2);
delta = params(3);
cbar = params(4);
beta = params(5);
h = hours;

psi = (1-beta*(1-delta))/(beta * theta);

zero = alpha.*h.^(1/gamma + 1)*psi^(1/(theta - 1))*(psi - delta) - alpha.*h.^(1/gamma)*cbar ... % this was the previous lhs
    -(1-tau).*(1-theta).*psi.^(theta/(theta - 1)); % this row used to be on the rhs

end