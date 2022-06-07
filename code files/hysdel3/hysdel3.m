function hysdel3(arg1, varargin)
% HYSDEL3 Main HYSDEL 3 function
%
%  HYSDEL3(HYSDELNAME) compiles the hysdel source model HYSDELNAME and
%  generates the m-file HYSDELNAME.M which, when executed, generates the
%  variable MLD structure "S" in the current workspace. 
%
%  HYSDEL3(HYSDELNAME, 'simulator', SIMULATORNAME) in addition to the
%  model generates also the standalone simulator SIMULATORNAME
%
%  Various options can be provided where running the compilation:
%    HYSDEL3(HYSDELNAME, OPTIONS)
%
%  Here, Options is a set of property-value pairs, e.g.
%    HYSDEL3(HYSDELNAME, '--like_hysdel2=false', '--check_linearity=true')
%    HYSDEL3(HYSDELNAME, 'like_hysdel2', false, 'check_linearity', true)
%    HYSDEL3(HYSDELNAME, 'like_hysdel2', 0, 'check_linearity', 1)
%
%  'simulator'             Specifies the name of the standalone simulator
%
%  'remove_binaries'       Eliminate any binary variables automatically
%                          introduced by YALMIP
%                          Default: TRUE
%
%  'expand_bounds_first'   Calculates symbolic bounds on auxiliary
%                          variables before it starts to construct
%                          mixed-integer models in AD and DA items
%                          Default: TRUE
%
%  'remove_var_bounds'     Removes user-defined bounds on state and input
%                          variables from the MLD constraints
%                          Default: TRUE
% 
%  'remove_aux_bounds'     Remove automatically generated bounds on real
%                          auxiliary variables from  the MLD constraints
%                          Default: FALSE
% 
%  'optimize_aux_bounds'   Calculates symbolic lower/upper bounds on real
%                          auxiliaries in LINEAR and/or DA items
%                          (e.g. for DA { z = {IF d THEN x ELSE y}; } it
%                          calculates the symbolic minimum/maximum of
%                          functions "x" and "y" and adds constraints
%                          "z >= min(min(x), min(y))" and "z >= max(max(x),
%                          max(y))"
%                          Default: TRUE
%                     
%  'use_symbolic_bounds'   Keeps a list of symbolic bounds and exploits them 
%                          e.g. in AD { d = z <= 0; } LINEAR { z = x; }
%                          the bounds of the big-M conversion of the AD
%                          statement will be deduced from the LINEAR
%                          section
%                          Default: TRUE
%
%  'check_linearity'       Enables checking linearity in semantic checks.
%                          e.g. LINEAR { z = x^2; } would be rejected if
%                          this flag is true, but will pass if it's false.
%                          the non-linearity will be catched later on when
%                          translating from YALMIP to MLD. Disabling this
%                          option reduces the compilation runtime
%                          Default: TRUE
%
%  'MLD_epsilon'           Zero-crossing tolerance
%                          Default: 1e-6
%
%  'MLD_bigMbound'         Big-M bound used for unbounded variables
%                          Default: 1e4

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

% default values for some options
defaults = { ...
    { 'remove_binaries',     true }, ...
    { 'expand_bounds_first', true }, ...
    { 'remove_var_bounds',   true }, ...
    { 'remove_aux_bounds',  false }, ...
    { 'optimize_aux_bounds', true }, ...
    { 'use_symbolic_bounds', true }, ...
    { 'check_linearity',     true }, ...
    { 'MLD_epsilon',         1e-6 }, ...
    { 'MLD_bigMbound',        1e4 }, ...
    { 'simulator',             '' }, ...
    { 'xml',                false }, ...
    { 'debug',              false }, ...
    { 'yalmip_output',         '' }, ...
    };

if nargin == 0
    help(mfilename);
    return
end
if ~isa(arg1, 'char')
    error('First argument must be a file name.');
end

% parse user-provided options               
options = h3_parse_options(defaults, varargin{:});
if ~options.xml
    if length(arg1) > 4
        options.xml = isequal(lower(arg1(end-3:end)), '.xml');
    end
end

if options.debug
    sub_process_file(arg1, options)
else
    try
        sub_process_file(arg1, options);
    catch
        error(lasterror);
    end
end

%----------------------------------------------------------------
function sub_process_file(arg1, options)

% prepare output filename
fname = arg1;
[p, n, e] = fileparts(fname);
if isempty(p)
    p = '.';
end
hysname = [p filesep n];
outname = [n e];

if ~isempty(options.simulator)
    h3_compile(hysname, options.simulator, options);
end
h3_fprintf('reset');
% now create the MLD model
h3_compile(hysname, '', options);

if ~isempty(options.yalmip_output)
    % write the intermediate YALMIP formulation to a file
    S = h3_fprintf('write', options, options.yalmip_output);
end
S = h3_fprintf('evaluate', options);
S.name = n;
h3_export(S, outname, options.xml);
