function [isdefined, type, kind] = h3_is_a(var, v_type, v_kind)

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


if nargin < 2
    v_type = 'variable';
    v_kind = 'all';
elseif nargin < 3
    v_kind = 'all';
end
if isequal(v_type, 'variable')
    v_type = {'state', 'input', 'output', 'aux'};
end
if isequal(v_type, 'defined')
    v_type = {'state', 'input', 'output', 'aux', 'parameter', 'index'};
end
if isequal(v_kind, 'all')
    v_kind = {'real', 'bool', 'index'};
end
if ~iscell(v_type)
    v_type = { v_type };
end
if ~iscell(v_kind)
    v_kind = { v_kind };
end
if ~iscell(var)
    var = { var };
end

n_vars = length(var);
isdefined = zeros(1, n_vars);
type = cell(1, n_vars);
kind = cell(1, n_vars);

for i = 1:n_vars
    [isdefined(i), type{i}, kind{i}] = sub_is_a(var{i}, v_type, v_kind);
end


%------------------------------------------------------------------------
function [isdefined, type, kind] = sub_is_a(var, v_type, v_kind)

global H3_SYMTABLE


V = H3_SYMTABLE;
isdefined = 0; type = ''; kind = '';

if isa(var, 'xmltree')
    var = xslt(var);
end
var = strtrim(var);
v_type = lower(v_type);
v_kind = lower(v_kind);


for i = 1:length(V)
    Vi = V{i};

%     if isequal(Vi.name, var)
%         if any(ismember(Vi.type, v_type))
%             if any(ismember(Vi.kind, v_kind))
%                 isdefined = 1;
%                 type = V{i}.type;
%                 kind = V{i}.kind;
%                 return
%             end
%         end
%     end

    if isequal(Vi.name, var) && ...
            any(ismember(Vi.type, v_type)) && ...
            any(ismember(Vi.kind, v_kind))
        isdefined = 1;
        type = V{i}.type;
        kind = V{i}.kind;
        return
    end
end
