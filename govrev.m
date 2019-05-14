function [revenue] = govrev(tau, w, c, xi, gamma, theta,r)
%govrev Tells you how much revenue the government is making
%   tau can be a vector of taxes. Rest are parameter values.

cbar = xi*c;
% solve for optimal hours worked
% TODO : Double check that w
hvec = ((1-tau)*w/(c - cbar)).^(gamma); % optimal hours worked, given tau and the others. 
% solve for new capital stock using f.o.c w.r.t capital
kvec = (theta * (hvec.^(1-theta)) /r).^(1/(1-theta));
% solve for new wage, simply marginal product of labour
wvec = (1-theta)*(kvec./hvec).^theta; % constant
% Government revenue:
revenue = tau.*wvec.*hvec;
end

