function [int_s, imp_s, pos_imp, int_b, imp_b] = h3_split_tree(tree)
% splits the TREE object into the INTERFACE and IMPLEMENTATION parts

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

int_b = branch(tree, '//interface');
imp_b = branch(tree, '//implementation_t');

int_s = sub_split_int(int_b);
[imp_s, pos_imp] = sub_split_imp(imp_b);


%-------------------------------------------------------------------------
function sections_struct = sub_split_int(INT)

sec{1}.var = 'state';
sec{1}.path = '//state_interface_t';

sec{2}.var = 'input';
sec{2}.path = '//input_interface_t';

sec{3}.var = 'output';
sec{3}.path = '//output_interface_t';

sec{4}.var = 'parameter';
sec{4}.path = '//parameter_interface_t';

sec{5}.var = 'module';
sec{5}.path = '//module_interface_t';

sections_struct = [];
for isec = 1:length(sec),
    position = xpath(INT, sec{isec}.path);
    if ~isempty(position),
        if length(position) > 1,
            error(sprintf('More than one INTERFACE/%s section not supported!', upper(sec{isec}.var)));
        end
        section_tree = branch(INT, position);
        sections_struct = setfield(sections_struct, sec{isec}.var, section_tree);
    else
        sections_struct = setfield(sections_struct, sec{isec}.var, []);
    end
end


%--------------------------------------------------------------------------
function [sections_struct, POS] = sub_split_imp(IMP)

sec{1}.var = 'aux';
sec{1}.path = '//aux_impl_t';

sec{2}.var = 'AD';
sec{2}.path = '//AD_section_t';

sec{3}.var = 'logic';
sec{3}.path = '//logic_section_t';

sec{4}.var = 'linear';
sec{4}.path = '//linear_section_t';

sec{5}.var = 'DA';
sec{5}.path = '//DA_section_t';

sec{6}.var = 'continuous';
sec{6}.path = '//continuous_section_t';

sec{7}.var = 'must';
sec{7}.path = '//must_section_t';

sec{8}.var = 'automata';
sec{8}.path = '//automata_section_t';

sec{9}.var = 'output';
sec{9}.path = '//output_section_t';


POS = [];
sections_struct = [];
for isec = 1:length(sec),
    position = xpath(IMP, sec{isec}.path);
    if ~isempty(position),
        stack = {};
        for ii = 1:length(position),
            section_tree = branch(IMP, position(ii));
            stack{end+1} = section_tree;
            POS = [POS; isec position(ii)];
        end
        sect = stack;
    else
        sect = [];
    end
    sections_struct = setfield(sections_struct, sec{isec}.var, sect);
end

% sort according to position of respective section in the XML tree
POS = sortrows(POS, 2);
% POS = [a(:, 1) b];
% return

A = POS(:,1);
B = zeros(length(A), 1);
for ii = 1:9,
    B(find(A==ii)) = 1:length(find(A==ii));
end
POS = [A B];
