function F = ne(X,Y)
%NE (overloaded)
%
%    F = set(ne(x,y))
%
%   See also SDPVAR/AND, SDPVAR/OR, BINVAR, BINARY

% Author Johan L?fberg
% $Id: ne.m,v 1.4 2009-02-25 12:29:25 joloef Exp $

% Models NE using logic constraints

% bin1 = isa(X,'sdpvar') | isa(X,'double');
% bin2 = isa(Y,'sdpvar') | isa(Y,'double');
%
% if ~(bin1 & bin2)
%     error('Not equal can only be applied to integer data')
% end

% class(X)
% if isequal(class(X), 'char')
%     z = varargin{2};
%     x = varargin{3};
%     y = varargin{4};
%     
%     varargout{1} = set(sum(xy) > z) + set(z > xy) +set(binary(z)) ;
%     varargout{2} = struct('convexity','none','monotonicity','none','definiteness','none','model','integer');
%     varargout{3} = xy;
% end
% 
do_binary = false;
if nargin == 2 && isa(Y, 'sdpvar') && isa(X, 'sdpvar')
    if is(X, 'binary') && is(Y, 'binary') && ...
            ~is(X, 'compound') && ~is(Y, 'compound') && ...
            length(getvariables(X)) == 1 && length(getvariables(Y)) == 1
        do_binary = true;
    end
end

if do_binary
    try
        %         F = yalmip('define','equivalence',X,Y);
        %         F = or(and(1-X, 1-Y), and(X, Y));
        %         F = and(X, 1-Y);
        %         x = and(X, Y);
        %         y = and(1-X, 1-Y);
        %         h3_register_binary('add', x);
        %         h3_register_binary('add', y);
        %         F = or(x, y);
        %         h3_register_binary('add', F);
%         F = constraint(X, '==', Y);
        F = or(and(X, Y), and(1-X, 1-Y));
        h3_register_binary('add', F);
    catch
        error(lasterr);
    end
    return
end

if isa(X,'sdpvar') & isa(Y,'sdpvar') & is(X,'binary') & is(Y,'binary')
    F = set(X + Y == 1);
elseif isa(X,'sdpvar') & is(X,'binary') &  isa(Y,'double') &  ismember(Y,[0 1])
    zv = find((Y == 0));
    ov = find((Y == 1));
    lhs = 0;
    if ~isempty(zv)
        lhs = lhs + sum(extsubsref(X,zv));
    end
    if ~isempty(ov)
        lhs = lhs + sum(1-extsubsref(X,ov));
    end
    F = set(lhs >=1);
else
    F = set((X<=Y-0.5) | (X>=Y+0.5));
end
