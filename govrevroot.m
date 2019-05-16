function [revenue] = govrevroot(theta,hvec, r, tau)
%govrevroot Is used for question 4 to calculate the government's revenue
%   Takes different arguments so decided to make it a separate function
%   from the other govrev function.
%   The logic is similar. Given h, we find k, then w and the revenue.

kvec = (theta * (hvec.^(1-theta)) /r).^(1/(1-theta)); % same as in govrev.m
% solve for new wage, simply marginal product of labour
wvec = (1-theta)*(kvec./hvec).^theta; 
% Government revenue:
revenue = tau.*wvec.*hvec;
end

