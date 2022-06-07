function h3_print_symb_matrix(M, fid, xml, rowname, colname)

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

if nargin < 3
    xml = false;
end

if xml
    fprintf(fid, '<sparseMatrix>\n');
    [s1, s2] = size(M);
else
    s1 = length(M);
end
if s1 == 0
    if xml
        fprintf(fid, '</sparseMatrix>\n');
    end
    return
end
if ~xml
    s2 = length(M{1});
end
for i = 1:s1
    for j = 1:s2
        iszero = 0;
        if xml
            a = M{i, j};
        else
            a = M{i}{j};
        end
        if isa(a, 'double')
            if issparse(a)
                a = full(a);
            end
            iszero = (a == 0);
            if iszero
                a = '0';
            else
                %             a = mat2str(a);
                a = sprintf('%.15g', a);
            end
        elseif isa(a, 'char')
            a = strtrim(a);
            if isequal(a, '0') || isequal(a, '-(0)') || isequal(a, '-(-(0))')
                iszero = 1;
            end
        else
            error('Wrong input type.');
        end
        if xml && ~iszero
            fprintf(fid, '<el>\n');
            if isa(rowname{i}, 'double')
                fprintf(fid, '<rowIndex>%d</rowIndex>\n', rowname{i});
            else
                fprintf(fid, '<rowName>%s</rowName>\n', rowname{i});
            end
            if isa(colname{j}, 'double')
                fprintf(fid, '<colIndex>%d</colIndex>\n', colname{j});
            else
                fprintf(fid, '<colName>%s</colName>\n', colname{j});
            end
            a = strrep(a, 'h3_power_internal(', 'System.Math.Pow(');
            a = ['<value>' h3_xml_value(a) '</value>'];
            fprintf(fid, '%s\n</el>\n', a);
        elseif ~xml
            if ~isempty(findstr(a, 'System.Math'))
                a = strrep(a, 'System.Math.Max', 'max');
                a = strrep(a, 'System.Math.Min', 'min');
                a = strrep(a, 'System.Math.Sqrt', 'sqrt');
                a = strrep(a, 'System.Math.Sinh', 'sinh');
                a = strrep(a, 'System.Math.Sin', 'sin');
                a = strrep(a, 'System.Math.Cosh', 'cosh');
                a = strrep(a, 'System.Math.Cos', 'cos');
                a = strrep(a, 'System.Math.Abs', 'abs');
                a = strrep(a, 'System.Math.Acosh', 'acosh');
                a = strrep(a, 'System.Math.Acos', 'acos');
                a = strrep(a, 'System.Math.Asinh', 'asinh');
                a = strrep(a, 'System.Math.Asin', 'asin');
                a = strrep(a, 'System.Math.Acot', 'acot');
                a = strrep(a, 'System.Math.Atan', 'atan');
                a = strrep(a, 'System.Math.Exp', 'exp');
                a = strrep(a, 'System.Math.Xor', 'xor');
                a = strrep(a, 'System.Math.Or', 'or');
                a = strrep(a, 'System.Math.And', 'and');
                a = strrep(a, 'System.Math.Round', 'round');
                a = strrep(a, 'System.Math.Ceil', 'ceil');
                a = strrep(a, 'System.Math.Floor', 'floor');
                a = strrep(a, 'System.Math.Sign', 'sign');
                a = strrep(a, 'System.Math.Tanh', 'tanh');
                a = strrep(a, 'System.Math.Tan', 'tan');
            end
            if j < s2
                fprintf(fid, '%s, ', a);
            else
                fprintf(fid, '%s', a);
            end
        end
%         if ~xml && j < s2
%             fprintf(fid, ', ');
%         end
%         if xml && ~iszero
%             fprintf(fid, '\n</el>\n');
%         end
    end
    if ~xml
        if s2==0
            fprintf(fid, ' zeros(1, 0)');
        end
        fprintf(fid, ';\n');
    end
end
if xml
    fprintf(fid, '</sparseMatrix>\n');
end

