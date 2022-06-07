function h3_xmlformatter(fname)

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


fid = fopen([fname '__temp.xml']);
fid2 = fopen([fname '_f.xml'], 'w');
level = 0;
mult = 2;
s = '';
ctr = 0;
while 1
    t = fgetl(fid);
    if ~ischar(t)
        break
    end
    if length(t) > 2
        % skip xml declarations
        if isequal(t(1:2), '<?'),
            ctr = ctr + 1;
        end
    end
    if ctr == 2,
        t = fread(fid);
        t = char(t)';
        t = strrep(t, 'yaxx:', '');
        t = strrep(t, '&amp;&amp;', '&amp;');
        t = strrep(t, '||', '|');
        t = strrep(t, '!', '~');
%         t = strrep(t, '<->', '==');
%         t = strrep(t, '->', '<=');
%         t = strrep(t, '<-', '>=');
        t = strrep(t, 'TRUE', 'true');
        t = strrep(t, 'FALSE', 'false');
        fprintf(fid2, '%s', t);
        break
    end
end
fclose(fid);
fclose(fid2);
