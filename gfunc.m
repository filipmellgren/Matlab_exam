function [zero, k, r, w, c, y, v] = gfunc(kold,h, params)
%gfunc takes a value of vector h and returns a competitive equilibrium
%   Using the arguments, we can solve for the economy's transition using
%   the law of motion for capital and conditions that must hold in
%   equilibrium. The idea is to return zero imposed by the Euler equaiton
%   so that fsolve can help me with finding the correct input of h.
%   Section 6.2 in the pdf shows how I reduced the dimensionality to make
%   this function dependent on only a startin gvalue of k and the vector h.

theta = params(1);
gamma = params(2);
tau = params(3);
delta = params(4);
S = params(5);
alpha = params(6);
beta = params(7);

% Let period 1 denote period T.
% That makes period T + 100 indexed by 101, hence S+1 below:
k = zeros(S+1,1); 
k(1) = kold; % The capital in period T, as the transition begins.
r = zeros(S+1,1);
w = zeros(S+1,1);
c = zeros(S+1,1);
y = zeros(S+1,1);
v = zeros(S+1,1);

for t = 1:(S+1) % From T to T + 100
    r(t) = theta*(h(t)./k(t)).^(1-theta);
    w(t) = (1-theta).*(k(t)./h(t)).^theta;
    v(t) = tau*w(t)*h(t);
    c(t) = ((1-tau)*w(t) )  ./ (alpha * h(t).^(1/gamma)); % expression for c I derived in Eq (20). (1-tau)w < w = MPL <=> distortionary
    y(t) = (k(t)^(theta))*(h(t)^(1-theta));
    k(t+1) = ((1- delta)*k(t) + w(t)*h(t) + r(t)*k(t)) - c(t); % Gov balances budget at each period, so transfers enter indirectly here.
end


clead = c(2:end);
ct = c(1:end-1);
rlead = r(2:end);

% The Euler equation must hold in each period:
zero = clead./ct - beta.*(rlead + 1 - delta); 
% Impose steady state condition in T + S <=> 1 + S. No growth in steady
% state means clead./ct = 1.
zero(S+1) = 1 - beta.*(r(S+1) + 1 - delta); 

end