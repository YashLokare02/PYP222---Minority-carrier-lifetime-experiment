% Linear fitting function
function [minority_lifetime, para_vals] = linear_fit(data1, data2, guess_1, guess_2, T, e, kB)

% Initial guesses
beta0 = [guess_1; guess_2]; % guess_1 -- for slope; guess_2 -- for y-intercept

% Defining a linear model
f = @(b, data1) b(1).*data1 + b(2);
 
% Linear fitting using fminsearch()
para_vals = fminsearch(@(b) norm(data2 - f(b, data1)), beta0); % Estimating fitting parameters

minority_lifetime = (2*kB*T)/(e*abs(para_vals(1))); % estimated minority carrier lifetime

end

