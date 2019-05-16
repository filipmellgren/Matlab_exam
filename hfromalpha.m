function [h] = hfromalpha(tau, w, xi, gamma, theta, alphaval, kdivy, delta)
%hfrom alpha is the alpha function solved for h.
%   As solved for in exercise 2c, presented in the pdf.
% Assumes w is exogenous to households and that kdivy is constant.
% it's a long expression but it can be tested by giving this function the
% argument tau = 0.3 and checking that hvec = 0.333 – which is true.

ydivk = 1/kdivy; % Actually, this also happen to equal psi

 % Want to avoid lengthy algebra in one expression. So I break it into
 % parts:

frac1 = ((1-tau)*w) ./ (alphaval * (1-xi));
frac2 = 1/(ydivk^(1/(theta -1)) * (ydivk - delta));

h = (frac1 .* frac2).^(1/(1+1/gamma));

%{
For the record, I came up with another expression I want sure about, both
yield the same result:
h = ( (1/kdivy)^(1/(1-theta)) * (1-tau)*w / (( (1-xi)*alphaval*(1/kdivy-delta))) ).^(gamma/(1+gamma));
%}
end

