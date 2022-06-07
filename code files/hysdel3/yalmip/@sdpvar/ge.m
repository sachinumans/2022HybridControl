function y = ge(X,Y)
%GE (overloaded)

% Author Johan L?fberg
% $Id: ge.m,v 1.3 2005-06-17 13:02:01 joloef Exp $

global H3_AVOID_BINARY_IMPLICATION

if isa(X,'blkvar')
    X = sdpvar(X);
end

if isa(Y,'blkvar')
    Y = sdpvar(Y);
end

try
    y = constraint(X,'>=',Y);
catch
    error(lasterr)
end
