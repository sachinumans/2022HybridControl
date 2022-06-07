function [lit1, lit2, clause] = h3_parse_logic_rhs(s)

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


lit1 = []; lit2 = []; clause = [];

% s = '~ b1.xb1& b1.d1';

s = strrep(s, '&&', '&');
s = strrep(s, '||', '|');
if ~isempty(findstr(s, '='))
    % implication or equivalence in the formula, exit
    return
end
if ~isempty(findstr(s, '(')) || ~isempty(findstr(s, ')'))
    % brackets not allowed
    %
    % two cases could happen:
    % 1) ~d1 | d2    -- fine
    %    d1 | ~d1    -- fine
    % 2) ~(d1 | d2)  -- don't know how to deal with this
    return
end

and_pos = findstr(s, '&');
or_pos = findstr(s, '|');

if length(and_pos) + length(or_pos) > 1
    % cannot deal with multiple 'or's or 'and's
    return
end

if length(and_pos) + length(or_pos) == 0
    % no logic expression here
    return
end

if length(and_pos) == 1
    clause = '&';
else
    clause = '|';
end
clause_pos = [and_pos or_pos];
lit1 = s(1:clause_pos-1);
lit2 = s(clause_pos+1:end);

neg_pos1 = findstr(lit1, '~');
lit1_negated = ~isempty(neg_pos1);
if lit1_negated
    lit1 = strrep(lit1, '~', '1-');
end

neg_pos2 = findstr(lit2, '~');
lit2_negated = ~isempty(neg_pos2);
if lit2_negated
    lit2 = strrep(lit2, '~', '1-');
end

