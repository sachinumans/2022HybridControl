function y = lt(X,Y)
%LT (overloaded)

% Author Johan L?fberg
% $Id: lt.m,v 1.3 2005-06-17 13:02:01 joloef Exp $

if isa(X,'blkvar')
    X = sdpvar(X);
end

if isa(Y,'blkvar')
    Y = sdpvar(Y);
end


do_binary = false;
if nargin == 2 && isa(Y, 'sdpvar') && isa(X, 'sdpvar')
    if is(X, 'binary') && is(Y, 'binary') && ...
            ~is(X, 'compound') && ~is(Y, 'compound') && ...
            length(getvariables(X)) == 1 && length(getvariables(Y)) == 1
        do_binary = true;
    end
end

% if ~isempty(H3_AVOID_BINARY_IMPLICATION)
%     do_binary = false;
% end

if do_binary
    try
        y = or(not(X), Y);
    catch
        error(lasterr);
    end
    return
end

try
    y = constraint(X,'<',Y);
catch
    error(lasterr)
end
