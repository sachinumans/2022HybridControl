function varargout = norm(varargin)
%NORM (overloaded)
%
% t = NORM(x,P)
%
% The variable t can only be used in convexity preserving
% operations such as t<0, max(t,y)<1, minimize t etc.
%
%    For matrices...
%      NORM(X) models the largest singular value of X, max(svd(X)).
%      NORM(X,2) is the same as NORM(X).
%      NORM(X,1) models the 1-norm of X, the largest column sum, max(sum(abs(X))).
%      NORM(X,inf) models the infinity norm of X, the largest row sum, max(sum(abs(X'))).
%      NORM(X,'fro') models the Frobenius norm, sqrt(sum(diag(X'*X))).
%    For vectors...
%      NORM(V) = norm(V,2) = standard Euclidean norm.
%      NORM(V,inf) = max(abs(V)).
%      NORM(V,1) = sum(abs(V))
%
% SEE ALSO SUMK, SUMABSK

% Author Johan L?fberg
% $Id: norm.m,v 1.43 2008-12-11 12:02:41 joloef Exp $


%% ***************************************************
% This file defines a nonlinear operator for YALMIP
%
% It can take three different inputs
% For DOUBLE inputs, it returns standard double values
% For SDPVAR inputs, it generates an internal variable
%
% When first input is 'model' it returns the graph
% in the first output and structure describing some
% properties of the operator.

%% ***************************************************
switch class(varargin{1})

    case 'double' % What is the numerical value of this argument (needed for displays etc)
        % SHOULD NEVER HAPPEN, THIS SHOULD BE CAUGHT BY BUILT-IN
        error('Overloaded SDPVAR/NORM CALLED WITH DOUBLE. Report error')

    case 'sdpvar' % Overloaded operator for SDPVAR objects. Pass on args and save them.
        if nargin == 1
            varargout{1} = yalmip('define',mfilename,varargin{1},2);
        else
            switch varargin{2}
                case {1,2,inf,'inf','fro'}
                    varargout{1} = yalmip('define',mfilename,varargin{:});
                otherwise
                    error('norm(x,P) only supported for P = 1, 2, inf and ''fro''');
            end
        end

    case 'char' % YALMIP sends 'model' when it wants the epigraph or hypograph
        switch varargin{1}
            case 'graph'
                t = varargin{2};
                X = varargin{3};
                p = varargin{4};

                % Code below complicated by two things
                % 1: Absolute value for complex data -> cone constraints on
                %    elements
                % 2: SUBSREF does not call SDPVAR subsref -> use extsubsref.m

                % FIX : Exploit symmetry to create smaller problem
                switch p
                    case 1
                        z = sdpvar(size(X,1),size(X,2),'full');
                        if min(size(X))>1
                            if isreal(X)
                                F = set(-z < X < z);
                            else
                                F = set([]);
                                for i = 1:size(X,1)
                                    for j = 1:size(X,2)
                                        xi = extsubsref(X,i,j);
                                        zi = extsubsref(z,i,j);
                                        F = F + set(cone([real(xi);imag(xi)],zi));
                                    end
                                end
                            end
                            F = F + set(sum(z,1) < t);
                        else
                            if isreal(X)
                                % Standard definition
                                F = set(-z < X < z) + set(sum(z) < t);
                                % Added to improve MILP models
                                F = F + set(z > 0) + set(t > 0);
                                [M,m] = derivebounds(X);
                                bounds(z,0,max(abs([M -m]),[],2));
                                bounds(t,0,sum(max(abs([M -m]),[],2)));
                            else
                                F = set([]);
                                for i = 1:length(X)
                                    xi = extsubsref(X,i);
                                    zi = extsubsref(z,i);
                                    F = F + set(cone([real(xi);imag(xi)],zi));
                                end
                                F = F + set(sum(z) < t);
                            end
                        end
                    case 2
                        z = sdpvar(size(X,1),size(X,2));
                        if min(size(X))>1
                            F = set([t*eye(size(X,1)) X;X' t*eye(size(X,2))]);
                        else
                            F = set(cone(X(:),t));
                        end
                    case {inf,'inf'}
                        if min(size(X))>1
                            z = sdpvar(size(X,1),size(X,2),'full');
                            if isreal(X)
                                F = set(-z < X < z);
                            else
                                F = set([]);
                                for i = 1:size(X,1)
                                    for j = 1:size(X,2)
                                        xi = extsubsref(X,i,j);
                                        zi = extsubsref(z,i,j);
                                        F = F + set(cone([real(xi);imag(xi)],zi));
                                    end
                                end
                            end
                            F = F + set(sum(z,2) < t);
                        else
                            if isreal(X)
                                F = set(-t < X < t);
                                [M,m,infbound] = derivebounds(X);
                                if ~infbound
                                    F = F + set(0< t < max(max(abs([m M]))));
                                end
                            else
                                F = set([]);
                                for i = 1:length(X)
                                    xi = extsubsref(X,i);
                                    F = F + set(cone([real(xi);imag(xi)],t));
                                end
                            end
                        end
                    case 'fro'
                        X.dim(1)=X.dim(1)*X.dim(2);
                        X.dim(2)=1;
                        F = set(cone(X,t));
                    otherwise
                end
                varargout{1} = F;
                varargout{2} = struct('convexity','convex','monotonicity','none','definiteness','positive','model','graph');
                varargout{3} = X;

            case 'exact'

                t = varargin{2};
                X = varargin{3};
                p = varargin{4};
                if ~isreal(X) | isequal(p,2) | isequal(p,'fro') | min(size(X))>1 % Complex valued data, matrices and 2-norm not supported
                    varargout{1} = [];
                    varargout{2} = [];
                    varargout{3} = [];
                else
                    if p==1
                        X     = reshape(X,length(X),1);
                        absX  = sdpvar(length(X),1);
                        d     = binvar(length(X),1);
                        [M,m] = derivebounds(X);

                        if all(abs(sign(m)-sign(M))<=1)
                            
                            % Silly convex case. Some coding to care of the
                            % case sign(0)=0...
                            d = ones(length(X),1);
                            d(m<0)=-1;
                            F = set(t - sum(absX) == 0) + set(absX == d.*X);
                        else
                            
                            F = set([]);
                            
                            
                            % Some fixes to remove trivial constraints 
                            % which caused problems in a user m
                            positive = find(m >= 0);
                            negative = find(M <= 0);
                            fixed = find(m==M);                            
                            if ~isempty(fixed)
                                positive = setdiff(positive,fixed);
                                negative = setdiff(negative,fixed);
                            end
                            if ~isempty(positive)
                                d = subsasgn(d,struct('type','()','subs',{{positive}}),1);
                            end
                            if ~isempty(negative)
                                d = subsasgn(d,struct('type','()','subs',{{negative}}),0);
                            end
                            if ~isempty(fixed)
                                notfixed = setdiff(1:length(m),fixed);
                                addsum = sum(abs(m(fixed)));
                                m = m(notfixed);
                                M = M(notfixed);
                                X = extsubsref(X,notfixed);
                                absX = extsubsref(absX,notfixed);
                                d = extsubsref(d,notfixed);
                            else
                                addsum = 0;
                            end

                            maxABSX = max([abs(m) abs(M)],[],2);
                            % d==0  ---> X<0 and absX = -X
                            F = F + set(X <= M.*d)     + set(0 <= absX+X <= 2*maxABSX.*d);
                            % d==1  ---> X>0 and absX = X
                            F = F + set(X >= m.*(1-d)) + set(0 <= absX-X <= 2*maxABSX.*(1-d));

                            F = F + set(t - sum(absX)-addsum == 0);
                        end

                    else
                        n = length(X);
                        X     = reshape(X,n,1);
                        absX  = sdpvar(n,1);
                        d     = binvar(n,1);
                        [M,m] = derivebounds(X);
                        maxABSX = max([abs(m) abs(M)],[],2);
                        % big-M to generate the absolute values
                        F = set([]);
                        F = F + set(X <= M.*d)     + set(0 <= absX+X <= 2*maxABSX.*d); 
                        F = F + set(X >= m.*(1-d)) + set(0 <= absX-X <= 2*maxABSX.*(1-d));
                        % Let t be larger than all absolute values, and
                        % equal to one, thus equal to the largest
                        d = binvar(n,1);
                        F = F + set(sum(d)==1);
                        F = F + set(absX <= t <= absX + maxABSX.*(1-d));
                    end
                    varargout{1} = F;
                    varargout{2} = struct('convexity','convex','monotonicity','milp','definiteness','positive','model','integer');
                    varargout{3} = X;
                end
            otherwise
                error('SDPVAR/NORM called with CHAR argument?');
        end
    otherwise
        error('Strange type on first argument in SDPVAR/NORM');
end