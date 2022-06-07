function out = h3_xmltag(tag, content, varargin)
% Construct an XML tag
%
% htmltag('td', 'hello'):
%   <td>hello</td>
%
% htmltag('a', 'My site', 'href', 'http://www.example.com'):
%   <a href="http://www.example.com">My site</a>
%
% htmltag('span', 'text', 'class', 'myclass', 'id', 'myid'):
%   <span class="myclass" id="myid">text</span>


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

error(nargchk(1, Inf, nargin));
if nargin < 2,
    content = '';
end

if nargin>2,
    noptargs = length(varargin);
    if rem(noptargs, 2)~=0,
        error('Options must be specified in pairs.');
    end
    options = sub_parseoptions(varargin);
    
else
    options = '';
    
end

if isnumeric(content),
    content = num2str(content);
elseif ~ischar(content),
    error('Only string or numeric values are allowed.');
end
    
out = sprintf('<%s%s>%s</%s>', tag, options, content, tag);



%----------------------------------------------------------------
function options = sub_parseoptions(opt)

options = '';
for i = 1:2:length(opt),
    field = opt{i};
    value = opt{i+1};
    if isnumeric(value),
        value = num2str(value);
    elseif ~ischar(value),
        error('Only string or numeric values are allowed.');
    end
    options = [options sprintf(' %s="%s"', field, value)];
end
