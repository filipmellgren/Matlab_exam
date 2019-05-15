function [revenue] = govrev(tau, w, c, xi, gamma, theta,r, alphaval, kdivy, delta)
%govrev Tells you how much revenue the government is making
%   tau can be a vector of taxes. Rest are parameter values.

cbar = xi*c;
% solve for optimal hours worked. 
%hvec = ( (1/kdivy)^(1/(1-theta)) * (1-tau)*w / (( (1-xi)* alphaval*(1/kdivy-delta))) ).^(gamma/(1+gamma));
hvec = hfromalpha(tau, w, xi, gamma, theta, alphaval, kdivy, delta);
% solve for new capital stock using f.o.c w.r.t capital
kvec = (theta * (hvec.^(1-theta)) /r).^(1/(1-theta));
% solve for new wage, simply marginal product of labour
wvec = (1-theta)*(kvec./hvec).^theta; % constant
% Government revenue:
revenue = tau.*wvec.*hvec;
end

