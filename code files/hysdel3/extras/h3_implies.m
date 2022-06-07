function y = h3_implies(X, Y)

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

% % if nargin < 3
% %     tag = '';
% % end
% % 
% % nd = size(d, 1);
% % nr = size(real_cond, 1);
% % 
% % F = set([]);
% % 
% % if isa(d, 'constraint')
% %     if isa(real_cond, 'sdpvar')
% %         for i = 1:nr
% %             F = F + set( implies(real_cond(i, :), d), tag);
% %         end
% % 
% %     elseif isa(real_cond, 'constraint')
% %         F = F + set( implies(real_cond, d), tag);
% %         
% %     end
% % 
% % else
% %     for i = 1:nd
% %         F = F + set( implies(real_cond, d(i, :)), tag);
% %     end
% % end
