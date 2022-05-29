function [P] = fricApprox(v, vars)
%FRICAPPROX Approximates the friction force
%   Symbol in report is P(v)

P = zeros(size(v));

boundaryIdx = find(v<vars.alpha, 1, 'last' ); % Get switching point between functions
if all(v>vars.alpha) % or if every speed is above alpha
    boundaryIdx = 0;
end


P(1:boundaryIdx) = vars.beta/vars.alpha .* v(1:boundaryIdx);

P(boundaryIdx+1:end) = (vars.c*vars.v_max^2 - vars.beta)/(vars.v_max - vars.alpha)...
    .* v(boundaryIdx+1:end) + vars.v_max/(vars.v_max-vars.alpha)*vars.beta ...
    - vars.c*vars.v_max^2/(vars.v_max-vars.alpha)*vars.alpha;

end

