function options = h3_parse_options(defaults, varargin)

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

options = [];

i = 0;
while i < length(varargin)
    i = i + 1;
    arg = varargin{i};
    if ~ischar(arg)
        error('Options must be provided as property/value pairs.');
    end        
    if length(arg) > 2 && isequal(arg(1:2), '--')
        eq_pos = findstr(arg, '=');
        if length(eq_pos) ~= 1
            error('Options must be provided as property/value pairs.');
        end
        field = arg(3:eq_pos-1);
        value = arg(eq_pos+1:end);
    else
        field = arg;
        if i == length(varargin)
            error('Options must be provided as property/value pairs.');
        end
        value = varargin{i+1};
        i = i + 1;
    end
    if isa(value, 'char') && ~isequal(field, 'simulator') && ~isequal(field, 'yalmip_output')
        try
            value = eval(value);
        catch
            error('Unrecognized value "%s".', value);
        end
    end
    options = setfield(options, field, value);
end

for i = 1:length(defaults)
    if ~isfield(options, defaults{i}{1})
        options = setfield(options, defaults{i}{1}, defaults{i}{2});
    end
end
