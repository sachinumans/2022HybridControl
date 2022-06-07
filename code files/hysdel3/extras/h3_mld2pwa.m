function Sout = h3_mld2pwa(S)
%
% converts MLD structure into PWA mpt_syStruct
%
% input:   hysdel3 MLD structure
% output:  MPT sysStruct (see help mpt_sysStruct)

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

if ~isfield(S, 'A')
    error('Malformed input.');
end
if iscell(S.A)
    error('Symbolic models can''t be converted.');
end
% checking for well-posedness of the MLD model
if ~h3_mldcheck(S)
   error('Well-posedness check of the MLD system failed. Please, check the MLD structure.');
end

% creating polytopes of allowable XU space
[XUaug, XU, Xbnd] = sub1_polytopes(S);
%   outputs:
%   XUaug - joint x-u space with replaced binary variables in range
%          {0,1} -> [-0.05 1.05]    
%   XU - joint x-u space with binary values ONLY in {0,1}
%   Xbnd - x space with binaries in {0,1}

% if the MLD model does contain auxiliary variables, there's no need to
% run mld2pwa algorithm, as the model is linear
if S.nw<1
    Sout.A = S.A;
    Sout.B = S.Bu;
    Sout.f = S.Baff;
    Sout.C = S.C;
    Sout.D = S.Du;
    Sout.g = S.Daff;
    Sout.Pbnd = Xbnd;
    % constraints
    Sout.xmin = S.xl;
    Sout.xmax = S.xu;
    Sout.umin = S.ul;
    Sout.umax = S.uu;
    % creating Uset
    if S.nub>=1
        for i=1:S.nu
            if ~isempty(find(i==S.j.ur))
                Sout.Uset{i} = [-Inf Inf];
            else
                Sout.Uset{i} = [S.ul(i) S.uu(i)];
            end
        end
    end
    return
end

  

% INITIALIZATION
%%%%%%%%%%%%%%%%%%%%
% current region
P = XUaug; %we start from augmented XU space
finish = 0;
Rest = P;
uniq_dyn = [];
xud_b = NaN*ones(S.nxb+S.nub+S.nd,1);
% iteration counter
ii = 0; 

% MLD2PWA algorithm
while ~finish 
  
  % 1)
  % Chebychev ball of the current region
  [xuc,Radius] = chebyball(P);
  if Radius<=0
    error(['H3_MLD2PWA: Did not find a center of a polytope in the joint XU space '...
           ' Please, check the state and input constraints of the MLD model.']);
  end

  % 2) 
  % find the best integer-feasible approximation which satisfies
  % MLD constraints
  % solve MILP only if number of combinations is less than limit
  % 2^(S.nxb+S.nub+S.nd)
  if size(xud_b,2)<2^(S.nxb+S.nub+S.nd)
      if ii<1
          % solve MILP without "no-good" constraint only for 1st iteration
          [val, sol] = sub2_solveMILP(S, P, xuc);
          if sol.problem~=0
              error(['H3_MLD2PWA: Feasibility check for given MLD model ' ...
                     'indicates a non-feasible solution. Please, check ' ...
                     'the structure of the MLD model.']);
          end
      else
          % solve MILP such that the previous combinations of binary
          % variables in "xud_b" vector does not repeat
          [val, sol] = sub2_solveMILP_constr(S, P, xuc, xud_b);
      end
      %  outputs: val - values at optimum
      %           sol - was the MILP feasible? 
  else
      fprintf(['Number of possible combinations %d between binary variables ' ...
              'has been reached. Skipping the feasibility MILP.\n'],2^(S.nxb+S.nub+S.nd));
      sol.problem = 0;
      val = sys.val{end};
  end

  % if the MILP is not feasible, remove current region, otherwise
  % generate local dynamics
  if sol.problem~=0
      %fprintf('No feasible MILP solution, removing current region.\n');
      % remove current polytope
      Rest(1) = [];
  else
      % counter update
      ii = ii + 1;
  
      xud_b(:,ii) = [val.xb; val.ub; val.d];
      
      % checking if there is already a combination of optimal values
      % in previously generated regions
      yes = 0; % no repetions of dynamics
      xud_current = [val.xb; val.ub; val.d];
      i_merge = [];
      if exist('sys','var')
          for im=1:length(sys.A)
              xud_prev = [sys.val{im}.xb; sys.val{im}.ub; sys.val{im}.d];
              if isequal(xud_current,xud_prev)
                  yes = 1; 
                  % indices of regions with the same dynamics
                  i_merge = [i_merge; im];
              end
          end
      end
      
   
      if yes
          %fprintf('Dynamics already exist, assigning current region to this dynamics.\n')
          
          % assigning current region to this dynamics
          sys.P(ii) = P;
          %sys.P(ii) = sys.P(i_merge(1)); 
          
          % discarding current region');
          Rest(1) = [];
          
          % assigning dynamics
          sys.A{ii} = sys.A{i_merge(1)};
          sys.B{ii} = sys.B{i_merge(1)};
          sys.f{ii} = sys.f{i_merge(1)};
          sys.C{ii} = sys.C{i_merge(1)};
          sys.D{ii} = sys.D{i_merge(1)};
          sys.g{ii} = sys.g{i_merge(1)};
          
          % assigning xb, ub, deltas
          sys.val{ii} = sys.val{i_merge(1)};
          
          % which polytopes to merge?
          sys.to_merge(ii) = i_merge(1);

      else
          % 3) 
          % compute local dynamics and region P in XU space 
          S3 = sub3_computePWA(S, val, XUaug);
          % outputs: S3 - system structure
          %          S3.P - current polytope in XU space
          
          % assigning dynamics
          sys.A{ii} = S3.A;
          sys.B{ii} = S3.B;
          sys.f{ii} = S3.f;
          sys.C{ii} = S3.C;
          sys.D{ii} = S3.D;
          sys.g{ii} = S3.g;

          % assuming that generated regions do not overlap
         %% check if the generated regions overlap
         % if ii>2
         %     R = intersect(S3.P,sys.P);
         %     if isfulldim(R)
         %         % if there is an overlap, remove it
         %         S3.P = S3.P\R;
         %         % if the set difference generated more than 1 region,
         %         % put the remaining regions in Rest array
         %         if length(S3.P)>1
         %             Rest = [Rest, S3.P(2:end)];
         %             S3.P = S3.P(1);
         %         end
         %     end
         % end
         
          % assigning regions to this dynamics
          sys.P(ii) = S3.P;
          
          % assigning xb, ub, deltas
          sys.val{ii} = val;
          
          % 4)
          % partition the rest of the space using the set difference operator
          Rest = Rest\S3.P;
          
          % unique dynamics
          uniq_dyn = [uniq_dyn ii];
          
          % which polytopes to merge?
          sys.to_merge(ii) = 0;
      end
  end
  
  %  if isinside(P,[zeros(S.nx,1); zeros(S.nu)])
  %    keyboard
  %  end
  
  fprintf('Regions to explore %d.\n',length(Rest));
  
  % 5)
  % repeat for new region
  P = Rest(1);
  
  finish=(length(Rest)<1);
  %keyboard

end

% shows the combinations of binary variables found through recursion
%xud = NaN*ones(S.nxb+S.nub+S.nd,length(sys.A));
%for i=1:length(sys.A)
%    xud(:,i) = [sys.val{i}.xb; sys.val{i}.ub; sys.val{i}.d];
%end
%xud
%keyboard

% 6) 
% merging regions with same dynamics

% unique dynamics
for j=1:length(uniq_dyn)
    % regions
    Sm.P(j) = sys.P(uniq_dyn(j));
    % find which regions to merge with this dynamics
    Sm.to_merge{j} = find(uniq_dyn(j)==sys.to_merge); 
    
    % merging polytopes of structures sys and Sm
    Pn = [Sm.P(j) sys.P(Sm.to_merge{j})];
    %   Pmerged{j} = merge(Pn);
    union_Pn = Pn(1);
    for i=2:length(Pn)
        union_Pn = union(union_Pn,Pn(i));
    end
    Pmerged{j} = union_Pn;
end

fprintf('Generated %d local dynamics. Merging to %d unique dynamics ...\n', length(sys.P),length(uniq_dyn));
% assigning unique dynamics
idyn = 1;
for j = 1:length(Pmerged)
    for i_un = 1:length(Pmerged{j})
        ind_dyn = uniq_dyn(j);
        
        % matrices for update
        Sout.A{idyn} = sys.A{ind_dyn};
        Sout.B{idyn} = sys.B{ind_dyn};
        Sout.f{idyn} = sys.f{ind_dyn};
        Sout.C{idyn} = sys.C{ind_dyn};
        Sout.D{idyn} = sys.D{ind_dyn};
        Sout.g{idyn} = sys.g{ind_dyn};
        
        % assigning xb, ub, deltas
        Sout.val{idyn} = sys.val{ind_dyn};
        
        % regions
        Pout = Pmerged{j};
        Sout.P(idyn) = Pout(i_un); 
        [H,K] = double(Pout(i_un));
        Sout.guardX{idyn} = H(:,1:S.nx);
        Sout.guardU{idyn} = H(:,S.nx+1:end);
        Sout.guardC{idyn} = K;
        
        idyn = idyn + 1;
    end
end
if length(uniq_dyn)<idyn-1
    fprintf('%d unique dynamics are displaced over \n regions.', length(uniq_dyn), idyn-1);
end

% constraints
Sout.Pbnd = Xbnd;
Sout.xmin = S.xl;
Sout.xmax = S.xu;
Sout.umin = S.ul;
Sout.umax = S.uu;
% creating Uset
if S.nub>=1
    for i=1:S.nu
        if ~isempty(find(i==S.j.ur))
            Sout.Uset{i} = [-Inf Inf];
        else
            Sout.Uset{i} = [S.ul(i) S.uu(i)];
        end
    end
end




  
  
%--------------------------------------------------------------
% SUBFUNCTIONS

function [XUaug, XU, XbBinary] = sub1_polytopes(S)
% 
%  subfunction which creates basic polytopes for next use in the
%  joint x-u space 
%
%   outputs:
%   XUaug - joint x-u space with replaced binary variables in range
%         {0,1} -> [-0.05 1.05]    
%   XU - joint x-u space with binary values ONLY in {0,1}

% contraints polytopes

% contraints on x
if S.nx>=1
    Hx = [eye(S.nx); -eye(S.nx)];
    Kx = [S.xu; -S.xl];
    XbBinary = polytope(Hx,Kx);
    if S.nxb>=1
        % replace binary bounds by real bounds
        Kx(S.j.xb,:) = 1.05; %ub
        Kx(S.nx+S.j.xb,:) = 0.05; %-lb
    end
    Xb = polytope(Hx,Kx);
end

% contraints on u
if S.nu>=1
    Hu = [eye(S.nu); -eye(S.nu)];
    Ku = [S.uu; -S.ul];
    UbBinary = polytope(Hu,Ku);
    if S.nub>=1
        % replace binary bounds by real bounds
        Ku(S.j.ub,:) = 1.05; %ub
        Ku(S.nu+S.j.ub,:) = 0.05; %-lb
    end
    Ub = polytope(Hu,Ku);
end

if S.nx>=1 && S.nu>=1
    % polytope in joint x-u space with binary constraints
    XU = XbBinary*UbBinary;
    % polytope in joint x-u space with replaced real bounds
    XUaug = Xb*Ub;
elseif S.nx<1 && S.nu>=1
    XU = UbBinary;
    XUaug = Ub;
else
    XU = XbBinary;
    XUaug = Xb;
end


function [val, sol] = sub2_solveMILP(S, P, xuc)
%  
% perform feasibility search to find integer feasible point via
% minimizing the infinity norm
%
%  inputs: input structure S
%          current polytope P
%          maximal allowable space
%          current value of Chebychev ball xuc       
%
%  outputs: val - values at optimum
%           sol - was the MILP feasible? 
%

yalmip('clear');

% define variables
xr = sdpvar(S.nxr,1);
xb = binvar(S.nxb,1);
ur = sdpvar(S.nur,1);
ub = binvar(S.nub,1);
delta = binvar(S.nd,1);
z = sdpvar(S.nz,1);
x = sdpvar(S.nx,1); x(S.j.xr) = xr; x(S.j.xb) = xb;
u = sdpvar(S.nu,1); u(S.j.ur) = ur; u(S.j.ub) = ub;
w = sdpvar(S.nw,1); w(S.j.d) = delta; w(S.j.z) = z; 
xuv = [x; u];

% constraints
[H, K] = double(P);
F = set( H*xuv <= K);
F = F + set( S.xl <= x <= S.xu);
F = F + set( S.ul <= u <= S.uu);
F = F + set( S.wl <= w <= S.wu);
F = F + set( S.Ex(S.j.eq,:)*x + S.Eu(S.j.eq,:)*u + S.Eaux(S.j.eq,:)*w == S.Eaff(S.j.eq) );
F = F + set( S.Ex(S.j.ineq,:)*x + S.Eu(S.j.ineq,:)*u + S.Eaux(S.j.ineq,:)*w <= S.Eaff(S.j.ineq) );

% solve via YALMIP
obj = norm( xuv - xuc, inf);
sol = solvesdp(F, obj , sdpsettings('verbose',0,'removeequalities',0));

% evaluate solution
val.xb = double(xb);
val.ub = double(ub);
val.d = double(delta);

val.xr = double(xr);
val.ur = double(ur);
val.z = double(z);

val.x = double(x);
val.u = double(u);
val.w = double(w);


function [val, sol] = sub2_solveMILP_constr(S, P, xuc, xud_b)
%  
% perform feasibility search to find integer feasible point via
% minimizing the infinity norm
%
% adding "no-good" constraint for avoiding repetitions of the binary
% variables xud_b in the previous iterations
%
%  inputs: input structure S
%          current polytope P
%          maximal allowable space
%          current value of Chebychev ball xuc       
%
%  outputs: val - structure of values at optimum
%           sol - was the MILP feasible? 
%

yalmip('clear');

% define variables
xr = sdpvar(S.nxr,1);
xb = binvar(S.nxb,1);
ur = sdpvar(S.nur,1);
ub = binvar(S.nub,1);
delta = binvar(S.nd,1);
z = sdpvar(S.nz,1);
x = sdpvar(S.nx,1); x(S.j.xr) = xr; x(S.j.xb) = xb;
u = sdpvar(S.nu,1); u(S.j.ur) = ur; u(S.j.ub) = ub;
w = sdpvar(S.nw,1); w(S.j.d) = delta; w(S.j.z) = z; 
xuv = [x; u];

% constraints
[H, K] = double(P);
F = set( H*xuv <= K);

% no-good constraint
xud = [xb; ub; delta];
rs = sum(xud_b,1);
for i=1:size(xud_b,2)
    ls = 0; 
    for j=1:size(xud_b,1)
        ls = ls + (2*xud_b(j,i)-1)*xud(j);  
    end
    F = F + set(ls <= rs(i)-1);
end

F = F + set( S.xl <= x <= S.xu);
F = F + set( S.ul <= u <= S.uu);
F = F + set( S.wl <= w <= S.wu);
F = F + set( S.Ex(S.j.eq,:)*x + S.Eu(S.j.eq,:)*u + S.Eaux(S.j.eq,:)*w == S.Eaff(S.j.eq) );
F = F + set( S.Ex(S.j.ineq,:)*x + S.Eu(S.j.ineq,:)*u + S.Eaux(S.j.ineq,:)*w <= S.Eaff(S.j.ineq) );


% solve via YALMIP
obj = norm( xuv - xuc, inf);
sol = solvesdp(F, obj , sdpsettings('verbose',0,'removeequalities',0));

% evaluate solution
val.xb = double(xb);
val.ub = double(ub);
val.d = double(delta);

val.xr = double(xr);
val.ur = double(ur);
val.z = double(z);

val.x = double(x);
val.u = double(u);
val.w = double(w);

function Sout = sub3_computePWA(S, val, XU)
%
% compute dynamics and region P in XU space 
%
% inputs: S - input structure
%         val - optimal values of MILP for given region
%         set_0 - set approximation of logic value 0 
%         set_1 - set approximation of logic value 1
% 
% outputs: Sout - system structure
%          Sout.P - polytope in XU space


% remove rows where all elements are zero
zero_rows = [];
for i=S.j.ineq
    if ~any(S.Eaux(i, S.j.z))
        zero_rows = [zero_rows i];
    end
end

% remove zero rows from index set
i_ineq = setdiff(S.j.ineq, zero_rows);
Ez = S.Eaux(i_ineq, S.j.z);
Ed = S.Eaux(i_ineq, S.j.d);
Ex = S.Ex(i_ineq, :);
Eu = S.Eu(i_ineq, :);
Eaff = S.Eaff(i_ineq);

% form equalities from double-sided inequalities
b = Eaff - Eu*val.u - Ex*val.x - Ed*val.d;
repeat = 1;
% due possible numeric problems repeat for different tolerances until
% full rank matrix is obtained
abs_tol = 1e-12;
while repeat
    [Ain, Bin, Aeq, Beq, i_eq1] = ineq2eq(Ez, b, abs_tol);
    
    % index set of equalities
    i_eq = i_ineq(i_eq1(:, 1));
    if isempty(i_eq) || abs_tol>1e-3
        error(['H3_MLD2PWA: Could not extract equalities for current partition.'...
               'Unable to determine the local dynamics and region.']);
    end
    % index set of inequalities
    %i_in = setdiff(i_ineq,i_ineq(i_eq1(:))); % without zero rows on variable z
    i_in = setdiff(S.j.ineq,i_ineq(i_eq1(:)));% with zero rows on z
    
    % equality matrices
    Ez_eq = S.Eaux(i_eq, S.j.z);
    Ed_eq = S.Eaux(i_eq, S.j.d);
    Ex_eq = S.Ex(i_eq, :);
    Eu_eq = S.Eu(i_eq, :);
    Eaff_eq = S.Eaff(i_eq, :);
    if rank(Ez_eq)<S.nz
        repeat = 1;
        abs_tol = abs_tol*10;
    else 
        repeat = 0;
    end
end

% equalities define the local dynamics
% Ez_eq*z = (Eaff_eq - Ed_eq*d) - Ex_eq*x - Eu_eq*u
% z =  Ez_eq\(Eaff_eq - Ed_eq*d) - (Ez_eq\Ex_eq)*x - (Ez_eq\Eu_eq)*u
% z = Kx*x + Ku*u + Kaff
%
% x+ = A*x + Bu*u + Bd*d + Bz*z + Baff
% x+ = (A-Bz*(Ez_eq\Ex_eq))*x + (Bu-Bz*(Ez_eq\Eu_eq))*u + (Baff+Bd*d+Bz*(Ez_eq\(Eaff_eq-Ed_eq*d)))
% y = C*x + Du*u + Daux*w + Daff
% y = (C-Dz*(Ez_eq\Ex_eq))*x + (Du-Dz*(Ez_eq\Eu_eq))*u + (Daff+Dd*d+Dz*(Ez_eq\(Eaff_eq-Ed_eq*d)))
Sout.A = S.A - S.Baux(:,S.j.z)*(Ez_eq\Ex_eq);
Sout.B = S.Bu - S.Baux(:,S.j.z)*(Ez_eq\Eu_eq);
Sout.f = S.Baff + S.Baux(:,S.j.d)*val.d + S.Baux(:,S.j.z)*(Ez_eq\(Eaff_eq-Ed_eq*val.d)); 
Sout.C = S.C - S.Daux(:,S.j.z)*(Ez_eq\Ex_eq);
Sout.D = S.Du - S.Daux(:,S.j.z)*(Ez_eq\Eu_eq);
Sout.g = S.Daff + S.Daux(:,S.j.d)*val.d + S.Daux(:,S.j.z)*(Ez_eq\(Eaff_eq-Ed_eq*val.d));

% inequality matrices
Ez_in = S.Eaux(i_in,S.j.z); 
Ed_in = S.Eaux(i_in,S.j.d);
Eaux_in = S.Eaux(i_in,:);
Ex_in = S.Ex(i_in,:); 
Eu_in = S.Eu(i_in,:); 
Eaff_in = S.Eaff(i_in,:); 

% inequalities define a partition in the x-u space
% (Ex-Ez*(Ez_eq\Ex_eq))*x + (Eu-Ez*(Ez_eq\Eu_eq))*u <= Eaff-Ed*d-Ez*(Ez_eq\(Eaff_eq-Ed_eq*d))
% Hx*x + Hu*u <= Kxu
Hxu = [Ex_in-Ez_in*(Ez_eq\Ex_eq) Eu_in-Ez_in*(Ez_eq\Eu_eq)];
Kxu = Eaff_in-Ed_in*val.d-Ez_in*(Ez_eq\(Eaff_eq-Ed_eq*val.d));

P = polytope(Hxu, Kxu);
[xu_c, xu_rad] = chebyball(P);

% if matrices defining polytope P contain additional equalities or
% polytope P is empty, try to find a non-empty polytope
abs_tol = 1e-12;
stop_iter = 0;
while xu_rad<=0
    if ~stop_iter && abs_tol>1e-3
        % if the tolerance has fairly increased and the polytope is still empty,
        % remove empty rows and increase tolerance
        empty_rows = [];
        for i=1:size(Hxu,1)
            if ~any(Hxu(i,:))
               empty_rows = [empty_rows; i];
            end
        end
        Hxu(empty_rows,:) = [];
        Kxu(empty_rows) = [];
        abs_tol = 1e-12;
        stop_iter = 1;
    elseif stop_iter && abs_tol>1e-3
        error(['H3_MLD2PWA: Could not determine a non-empty region for current dynamics.'...
              'Please, check the structure of the MLD model.']);
        break;
    else
        [Hxu, Kxu] = ineq2eq(Hxu, Kxu, abs_tol);
        P = polytope(Hxu, Kxu);
        [xu_c, xu_rad] = chebyball(P);
        abs_tol = abs_tol*10;
    end
end

if ~isbounded(P)
    Sout.P = intersect(XU,P);
else
    Sout.P = P;
end



function [A, B, Aeq, Beq, ind_eq] = ineq2eq(A, B, tol)
%
% this function attempts to find rows "i" from a set A*x <= B
% which form equalities Ai*x = Bi, but are written as double-sided
% inequalities  
%
% Copyright is with the following author(s):
%
% (C) 2006 Johan Loefberg, Automatic Control Laboratory, ETH Zurich,
%          loefberg@control.ee.ethz.ch
% (C) 2005 Michal Kvasnica, Automatic Control Laboratory, ETH Zurich,
%          kvasnica@control.ee.ethz.ch

[ne, nx] = size(A);
Aeq = [];
Beq = [];
ind_eq = [];
sumM = sum(A, 2) + B;
for ii = 1:ne-1,
    s = sumM(1);

    % get matrix which contains all rows starting from ii+1
    sumM = sumM(2:end,:);

    % possible candidates are those rows whose sum is equal to the sum of the
    % original row
    possible_eq = find(abs(sumM + s) < tol);
    if isempty(possible_eq),
        continue
    end
    possible_eq = possible_eq + ii;
    b1 = B(ii);
    a1 = A(ii, :);

    % now compare if the two inequalities (the second one with opposite
    % sign) are really equal (hence they form an equality constraint)
    for jj = possible_eq',
        % first compare the B part, this is very cheap
        if abs(b1 + B(jj)) < tol,
            % now compare the A parts as well
            if norm(a1 + A(jj, :), inf) < tol,
                % jj-th inequality together with ii-th inequality forms an equality
                % constraint
                ind_eq = [ind_eq; ii jj];
                break
            end
        end
    end
end

if isempty(ind_eq),
    % no equality constraints
    return
else
    % indices of remaining constraints which are inequalities
    ind_ineq = setdiff(1:ne, ind_eq(:));
    Aeq = A(ind_eq(:,1), :);
    Beq = B(ind_eq(:,1));
    A = A(ind_ineq, :);
    B = B(ind_ineq);
end
