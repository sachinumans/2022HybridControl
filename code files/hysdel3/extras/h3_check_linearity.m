function h3_check_linearity(variables, varargin)

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

global H3_SOURCE_LINE

for i = 1:length(varargin)
    v = varargin{i};
    if isa(v, 'double') || isa(v, 'char') || isa(v, 'logical')
        continue
        
    elseif isa(v, 'constraint')
        v = sdpvar(v);
        
    end

    %     if is(v, 'binary') & ~is(v, 'sigmonial')
    %         L = islinear(v);
    %     elseif is(v, 'binary')
    if is(v, 'binary')
        L = true;
    else
        L = h3_check_linearity_sym(v, variables);
    end
    if ~L
        fprintf('Error on line:\n');
        fprintf('%s\n\n', H3_SOURCE_LINE);
        error('Nonlinear terms not allowed.');
    end
    
end

% h3_define_symbol('advance');
