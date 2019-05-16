function [revenue] = govrev(tau, w, c, xi, gamma, theta,r, alphaval, kdivy, delta)
%govrev Tells how much revenue the government is making
%   tau can be a vector of taxes. Rest are parameter values.

% solve for optimal hours worked: 
hvec = hfromalpha(tau, w, xi, gamma, theta, alphaval, kdivy, delta); % This is a function call!
% solve for new capital stock using f.o.c w.r.t capital
kvec = (theta * (hvec.^(1-theta)) /r).^(1/(1-theta)); 
% solve for new wage. Knowing K and H, we can use the marginal product of labour
wvec = (1-theta)*(kvec./hvec).^theta;
% Government revenue:
revenue = tau.*wvec.*hvec;
end

