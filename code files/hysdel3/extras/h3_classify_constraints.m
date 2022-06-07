function [Flinear, Fimplies, Fiff, Fife] = h3_classify_constraints(F)

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


keep_lin = zeros(length(F), 1);
keep_imp = keep_lin;
keep_iff = keep_lin;
keep_ife = keep_lin;

for i = 1:length(F)
    s = yalmip('extstruct', getvariables(F(i)));
    if ~isempty(s)
        if ~iscell(s)
            
            if strcmpi(s.fcn, 'implies')
                keep_imp(i) = 1;
            elseif strcmpi(s.fcn, 'iff')
                keep_iff(i) = 1;
            elseif strcmpi(s.fcn, 'h3_ifthenelse')
                keep_ife(i) = 1;
            elseif strcmpi(s.fcn, 'h3_upperbound')
                keep_lin(i) = 1;
            elseif strcmpi(s.fcn, 'h3_lowerbound')
                keep_lin(i) = 1;
            elseif strcmpi(s.fcn, 'h3_logic_item')
                keep_lin(i) = 1;
%             elseif strcmpi(s.fcn, 'and')
%                 keep_lin(i) = 1;
%             elseif strcmpi(s.fcn, 'or')
%                 keep_lin(i) = 1;
            else
                error('Unknown constraint, report this case to michal.kvasnica@stuba.sk.');
            end
        else
            keep_lin(i) = 1;
        end
    else
        keep_lin(i) = 1;
    end
end
Flinear = F(find(keep_lin));
Fimplies = F(find(keep_imp));
Fiff = F(find(keep_iff));
Fife = F(find(keep_ife));
