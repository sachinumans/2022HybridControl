function islinear = h3_check_linearity_sym(p, vars)

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


for j = 1:length(p)
    if isa(p(j), 'double')
        continue
    elseif is(p(j), 'sigmonial')
        % sigmonial terms like A/B are treated later
        continue
    elseif is(p(j), 'binary')
        continue
    else
%         if ~isa(p, 'sdpvar')
%             p = sdpvar(p);
%         end
        [c, v] = coefficients(p(j), vars);
        if isa(v, 'sdpvar')
            if is(v, 'nonlinear')
                islinear = 0;
                return
            end
        end
        for i = 1:length(c)
            c_disp = h3_sdisplay(c(i));
            for j = 1:1 % length(c_disp)
                if ~isempty(findstr(c_disp{j}, 'vars('))
                    % the multiplicator contains a variable -> nonlinear term
                    islinear = 0;
                    return
                end
            end
        end
    end
end
islinear = 1;
return

[mt, vt] = yalmip('monomtable');
if any(ismember(getvariables(p), yalmip('extvariables')))
    islinear = 0;
    return
end

F = full(mt(getvariables(p),getvariables(vars)));
islinear = 1;
for i = 1:size(F, 1)
%     if all(F(i, :))
%         islinear = 0;
%         return
%     end
    [i,j,v] = find(F(i, :));
    if ~isempty(i)
        if any(v~=1)
            islinear = 0;
            return;
        end
    end
end
% islinear = isempty(setdiff(1:size(F, 1), ...
%     [find(sum(abs(F), 2)==0), find(sum(abs(F), 2)==1)])) & ...
%     length(find(sum(abs(F), 2)==1))>=1
% 
