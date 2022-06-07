function F = h3_equivalence(X, Y)

% Copyright is with the following author(s):
%
% (C) 2008-2010 Michal Kvasnica, Slovak University of Technology
%               michal.kvasnica@stuba.sk

% ------------------------------------------------------------------------
% Legal note:
%       This program is free software; you can redistribute it and/or
%       modify it under the terms of the GNU General Public
%       License as published by the Free Software Foundation; either
%       version 2.1 of the License, or (at your option) any later version.
%
%       This program is distributed in the hope that it will be useful,
%       but WITHOUT ANY WARRANTY; without even the implied warranty of
%       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%       General Public License for more details.
%
%       You should have received a copy of the GNU General Public
%       License along with this library; if not, write to the
%       Free Software Foundation, Inc.,
%       59 Temple Place, Suite 330,
%       Boston, MA  02111-1307  USA
%
% ------------------------------------------------------------------------

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

end
