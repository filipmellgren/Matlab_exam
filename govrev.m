function revenue = govrev(tau, w, xi, gamma, theta,r, alphaval, kdivy, delta)
%govrev Tells how much revenue the government is making
%   tau can be a vector of taxes. Rest are parameter values.
%   The function operates in the order presented in the pdf file in section
%   2.3.

% solve for optimal hours worked using a function: 
hvec = hfromalpha(tau, w, xi, gamma, theta, alphaval, kdivy, delta);
% Knowing how much the represenattive agent will choose to work, we can
% solve for a new capital stock using f.o.c w.r.t capital
kvec = (theta * (hvec.^(1-theta)) /r).^(1/(1-theta)); 
% Now that we have h and k, it makes sense to introduce the notion of a
% marginal product of labour, which we sue to solve for wages:
wvec = (1-theta)*(kvec./hvec).^theta;
% The government's revenue follow:
revenue = tau.*wvec.*hvec;
end

