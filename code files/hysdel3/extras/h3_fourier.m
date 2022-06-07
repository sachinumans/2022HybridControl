function [A, B] = h3_fourier(A, B, project_onto, isbinary)
% H3_FOURIER Fourier-Motzkin elimination
%
%   Projection of a system of linear inequalities A*x<=b onto
%   x(project_onto), i.e. eliminate the remaining x's from the system.
%
%   Input:
%     A, B: Matrices of the polyhedron A*x<=B
%     project_onto: indices of variables to project onto
%     isbinary: true/false whether all variables are binary. If so, we can
%               some heuristics to quickly remove some redundant
%               inequalities
%
%   Output:
%      A, B: Matrices of the projected polyhedron

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


if nargin < 4
    isbinary = false;
end

nx = size(A, 2);
dim = setdiff(1:nx, project_onto);

for i=dim  
    positive=find(A(:,i) > 0);
    negative=find(A(:,i) < 0);
    null=find(A(:,i) == 0);
    
    nr = length(null) + length(positive)*length(negative);
    nc = size(A, 1);
    C = sparse(zeros(nr,nc));
    
    % Matrix C for all combinations of inequalities
    % Find a matrix C so that A = C*A and A(:,i)=[]
    H=A(:,i);
    row=1;
    for j=(positive)'
        for k=(negative)'       
            C(row,j)=-H(k);
            C(row,k)=H(j);
            row=row+1;            
        end
    end 
    
    for j=(null)'    
        C(row,j)=1;
        row=row+1;
    end
    
    % Compute new Matrix A and B
    A=C*A;
    B=C*B;

    % remove redundant rows using heuristics
    [A, B] = sub_reduce_rows(A, B, isbinary);
    
end
A = A(:, project_onto);
% remove redundant rows using heuristics
[A, B] = sub_reduce_rows(A, B, isbinary);

% remove redundant rows by solving linear programs (requires an LP solver)
% [A, B] = sub_reduce_rows_LP(A, B, combs);

%--------------------------------------------------------------------
function [A, B] = sub_reduce_rows_LP(A, B, combinations)

Q = [A B];
[AB, idx] = unique(Q, 'rows');
AB = Q(sort(idx), :);
A = AB(:, 1:end-1);
B = AB(:, end);

if false
    % normalize the polytope such that all rows have ||a_i||_2 = 1 (should give
    % better numerical robustness)
    norm_A = sqrt(diag(A*A'));
    for i = 1:size(A, 1)
        A(i, :) = A(i, :)./norm_A(i);
        B(i) = B(i)./norm_A(i);
    end
end

[nr, nc] = size(A);
remove = zeros(nr, 1);

% kick out zero rows
remove(find(max(abs(A), [], 2) == 0)) = 1;
zero_tol = 1e-6;

% remove redundant rows by solving series of linear programs
x = sdpvar(nc, 1);
for r = 1:nr
    if remove(r)
        continue
    end
    H = A;
    K = B;
    K(r) = B(r) + 1;
    % maximize in the direction of A(r, :)
    obj = A(r, :)*x;
    solvesdp([H*x <= K], -obj);
    
    if double(obj) <= B(r) + zero_tol
        remove(r) = 1;
    end
end

toremove = find(remove);
A(toremove, :) = [];
B(toremove, :) = [];



%--------------------------------------------------------------------
function [A, B] = sub_reduce_rows(A, B, isbinary)

Q = [A B];
Q = flipud(Q);
[AB, idx] = unique(Q, 'rows');
AB = Q(sort(idx), :);
AB = flipud(AB);
A = AB(:, 1:end-1);
B = AB(:, end);

% normalize the polytope such that all rows have ||a_i||_2 = 1 (should give
% better numerical robustness)
if false
    norm_A = sqrt(diag(A*A'));
    for i = 1:size(A, 1)
        A(i, :) = A(i, :)./norm_A(i);
        B(i) = B(i)./norm_A(i);
    end
end

[nr, nc] = size(A);
remove = zeros(nr, 1);

% kick out zero rows
remove(find(max(abs(A), [], 2) == 0)) = 1;

zero_tol = 1e-3;

if isbinary
    for r = 1:nr
        nonzero_cols = find(A(r, :) ~= 0);
        positive_cols = find(A(r, :) > 0);
        negative_cols = find(A(r, :) < 0);
        if length(nonzero_cols) == 1
            if A(r, nonzero_cols) >= zero_tol && B(r)/A(r, nonzero_cols) >= 1
                % redundant inequality x_i <= 1
                remove(r) = 1;
            elseif A(r, nonzero_cols) <= -zero_tol && B(r) >= 0
                % redundant inequality x_i >= 0
                remove(r) = 1;
            end
        elseif all(A(r, :) <= 0) && B(r) >= 0
            % redundant inequality "x1 + x2 >= 0"
            remove(r) = 1;
        elseif all(A(r, :) >= 0) && B(r) >= sum(A(r, :))
            % redundant inequality "x1 + x2 <= 2"
            remove(r) = 1;
        elseif sum(A(r, :)) == 0 && B(r) >= sum(A(r, positive_cols))
            % redundant inequality "x1 - x2 <= 1"
            remove(r) = 1;
        elseif sum(A(r, positive_cols)) <= B(r)
            % redundant inequality "x1 - x2 - x3 <= 1"
            % redundant inequality "-x1 + x2 + x3 <= 2"
            remove(r) = 1;
        end
    end
end
toremove = find(remove);
A(toremove, :) = [];
B(toremove, :) = [];
