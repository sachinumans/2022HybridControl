function y = eq(X,Y)
%EQ (overloaded)

% Author Johan L?fberg
% $Id: eq.m,v 1.5 2006-05-17 13:22:51 joloef Exp $

if isa(X,'blkvar')
    X = sdpvar(X);
end

if isa(Y,'blkvar')
    Y = sdpvar(Y);
end

% do_binary = false;
% if nargin == 2 && isa(Y, 'sdpvar') && isa(X, 'sdpvar')
%     if is(X, 'binary') && is(Y, 'binary') && ...
%             ~is(X, 'compound') && ~is(Y, 'compound') && ...
%             length(getvariables(X)) == 1 && length(getvariables(Y)) == 1
%         do_binary = true;
%     end
% end
% 
% if do_binary
%     try
%         y = or(and(X, Y), and(1-X, 1-Y));
%     catch
%         error(lasterr);
%     end
%     return
% end

% if isa(X, 'sdpvar') && isa(Y, 'sdpvar')
%     if is(X, 'binary') && is(Y, 'binary')
%         if ~is(X, 'compound') && is(Y, 'compound')
%             if ~isempty(Y.extra.opname)
%                 X = Y;
%                 y = constraint(Y, '<=', 10);
%                 return
%             end
%         end
%     end
% end

try
    y = constraint(X,'==',Y);
catch
    error(lasterr)
end


