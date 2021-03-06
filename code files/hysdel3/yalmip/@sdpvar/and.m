function varargout = and(varargin)
%ANd (overloaded)
%   
%    z = and(x,y)
%    z = x & y
%
% The AND operator is implemented using the concept of nonlinear operators
% in YALMIP. X|Y defines a new so called derived variable that can be
% treated as any other variable in YALMIP. When SOLVESDP is issued,
% constraints are added to the problem to model the AND operator. The new
% constraints add constraints to ensure that z, x and y satisfy the
% truth-table for AND.
%
% The model for ARE is set(z<=x)+set(z<=y)+set(1+z>=x+y)+set(binary(z))
%
% It is assumed that x and y are binary variables (either explicitely
% declared using BINVAR, or constrained using BINARY.)
%
%   See also SDPVAR/AND, BINVAR, BINARY

% Author Johan L?fberg 
% $Id: and.m,v 1.14 2007-08-02 19:17:36 joloef Exp $   

% global H3_AND_LHS_VAR
% 
% if ~isempty(H3_AND_LHS_VAR)
%     z = H3_AND_LHS_VAR;
%     x = varargin{1};
%     y = varargin{2};
%     varargout{1} = set(x >= z) + set(y >= z) + set(length(x)+length(y)-1+z >= sum(x)+sum(y));
%     H3_AND_LHS_VAR = [];
%     return
% end

switch class(varargin{1})
    case 'char'
        z = varargin{2};
        x = varargin{3};
        y = varargin{4};
    
%         % *******************************************************
%         % For *some* efficiency,we merge expressions like A&B&C&D
%         xvars = getvariables(x);
%         yvars = getvariables(y);
%         allextvars = yalmip('extvariables');
%         
%         if (length(xvars)==1) & ismembc(xvars,allextvars)
%             s = yalmip('extstruct', xvars);
%             if isequal(s.fcn, 'and')
%                 x = expandand(x,allextvars);
%             end
%         end
%         
%         if (length(yvars)==1) & ismembc(yvars,allextvars)
%             s = yalmip('extstruct', yvars);
%             if isequal(s.fcn, 'and')
%                 y = expandand(y,allextvars);
%             end
%         end
        % *******************************************************
                
        varargout{1} = set(x >= z) + set(y >= z) + set(length(x)+length(y)-1+z >= sum(x)+sum(y)) + set(binary(z));
%         varargout{1} = set(x >= z) + set(length(x)+length(y)-1+z >= sum(x)+sum(y)) + set(y >= z) + set(binary(z));
        % was 'monotoncity'
        varargout{2} = struct('convexity','none','monotonicity','none','definiteness','none','model','integer');
        % was varargout{3} = [];
        varargout{3} = [x y];

    case 'sdpvar'
        x = varargin{1};
        y = varargin{2};

        varargout{1} = yalmip('define','and',varargin{:});

    otherwise
end

function x = expandand(x,allextvars)

xmodel = yalmip('extstruct',getvariables(x));

if isequal(xmodel.fcn,'and')
    x1 = xmodel.arg{1};
    x2 = xmodel.arg{2};
    if  ismembc(getvariables(xmodel.arg{1}),allextvars)
        x1 = expandand(xmodel.arg{1},allextvars);     
    end
    if  ismembc(getvariables(xmodel.arg{2}),allextvars)
        x2 = expandand(xmodel.arg{2},allextvars);     
    end
    x = [x1 x2];
end
