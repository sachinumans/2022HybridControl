function symb_pvec = h3_sdisplay(p,names)

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

% TODO: sdpvar a b
%       x = (a+b)^0.3        -- writes "mpower_internal"
%
% TODO: sdpvar h x k
%       sdisplay2(h*x - k)   -- misses the minus in front of "k"
%                               this appears to be solved

if nargin < 2
    LinearVariables = 1:yalmip('nvars');
    x = recover(LinearVariables);
    names = cell(length(x),1);

    W = evalin('caller','whos');
    for i = 1:size(W,1)
        if strcmp(W(i).class,'sdpvar') | strcmp(W(i).class,'ncvar')
            % Get the SDPVAR variable
            thevars = evalin('caller',W(i).name);

            % Distinguish 4 cases
            % 1: Sclalar varible x
            % 2: Vector variable x(i)
            % 3: Matrix variable x(i,j)
            % 4: Variable not really defined
            if is(thevars,'scalar') & is(thevars,'linear') & length(getvariables(thevars))==1 & isequal(getbase(thevars),[0 1])
                index_in_p = find(ismember(LinearVariables,getvariables(thevars)));

                if ~isempty(index_in_p)
                    already = ~isempty(names{index_in_p});
                    if already
                        already = ~strfind(names{index_in_p},'internal');
                        if isempty(already)
                            already = 0;
                        end
                    end
                else
                    already = 0;
                end

                if ~isempty(index_in_p) & ~already
                    % Case 1
                    names{index_in_p}=W(i).name;
                end
            elseif is(thevars,'lpcone')

                if size(thevars,1)==size(thevars,2)
                    % Case 2
                    vars = getvariables(thevars);
                    indicies = find(ismember(vars,LinearVariables));
                    for ii = indicies
                        index_in_p = find(ismember(LinearVariables,vars(ii)));

                        if ~isempty(index_in_p)
                            already = ~isempty(names{index_in_p});
                            if already
                                already = ~strfind(names{index_in_p},'internal');
                                if isempty(already)
                                    already = 0;
                                end
                            end
                        else
                            already = 0;
                        end

                        if ~isempty(index_in_p) & ~already
                            B = reshape(getbasematrix(thevars,vars(ii)),size(thevars,1),size(thevars,2));
                            [ix,jx,kx] = find(B);
                            ix=ix(1);
                            jx=jx(1);
                            names{index_in_p}=[W(i).name '(' sub_mat2str(ix) ',' sub_mat2str(jx) ')'];
                        end
                    end

                else
                    % Case 3
                    vars = getvariables(thevars);
                    indicies = find(ismember(vars,LinearVariables));
                    for ii = indicies
                        index_in_p = find(ismember(LinearVariables,vars(ii)));

                        if ~isempty(index_in_p)
                            already = ~isempty(names{index_in_p});
                            if already
                                already = ~strfind(names{index_in_p},'internal');
                                if isempty(already)
                                    already = 0;
                                end
                            end
                        else
                            already = 0;
                        end

                        if ~isempty(index_in_p) & ~already
                            names{index_in_p}=[W(i).name '(' sub_mat2str(ii) ')'];
                        end
                    end
                end

            elseif is(thevars,'sdpcone')
                % Case 3
                vars = getvariables(thevars);
                indicies = find(ismember(vars,LinearVariables));
                for ii = indicies
                    index_in_p = find(ismember(LinearVariables,vars(ii)));
                    if ~isempty(index_in_p)
                        already = ~isempty(names{index_in_p});
                        if already
                            already = ~strfind(names{index_in_p},'internal');
                        end
                    else
                        already = 0;
                    end

                    if ~isempty(index_in_p) & ~already
                        B = reshape(getbasematrix(thevars,vars(ii)),size(thevars,1),size(thevars,2));
                        [ix,jx,kx] = find(B);
                        ix=ix(1);
                        jx=jx(1);
                        names{index_in_p}=[W(i).name '(' sub_mat2str(ix) ',' sub_mat2str(jx) ')'];
                    end
                end

            else
                % Case 4
                vars = getvariables(thevars);
                indicies = find(ismember(vars,LinearVariables));

                for i = indicies
                    index_in_p = find(ismember(LinearVariables,vars(i)));
                    if ~isempty(index_in_p) & isempty(names{index_in_p})
                        names{index_in_p}=['internal(' sub_mat2str(vars(i)) ')'];
                    end
                end

            end
        end
    end
end

[mt,vt] = yalmip('monomtable');
ev = yalmip('extvariables');

for i = 1:size(p, 1)
    for j = 1:size(p, 2)
        symb_pvec{i, j} = symbolicdisplay(p(i, j), names, vt, ev, mt);
%         if isa(symb_pvec{i, j}, 'char')
%             symb_pvec{i, j} = strrep(symb_pvec{i, j}, sub_mat2str(eps), '0');
%         end
    end
end


%------------------------------------------------------------------------
function expression = symbolicdisplay(p,names,vt,ev,mt)

vectorfunction = false;

if isstruct(p)
    p = p.subs{1};
end
sp = size(p);
if any(sp > 1)
    if vectorfunction
        out = '[';
    else
        out = ' ';
    end
else
    out = '';
end
p_orig = p;
for i1 = 1:sp(1)
    for i2 = 1:sp(2)
        p = p_orig(i1, i2);
        basis = full(getbase(p));
        if any(sp > 1) || basis(1)~=0
            expression = [sub_mat2str(basis(1)) '+'];
        else
            expression = [''];
        end

        [dummy, variables, coeffs] = find(basis(2:end));
        variables = getvariables(p);
        for i = 1:length(coeffs)
            if coeffs(i)==1
                expression = [expression symbolicmonomial(variables(i), ...
                    names,vt,ev,mt) '+'];
            else
                expression = [expression sub_mat2str(coeffs(i)) '*' ...
                    symbolicmonomial(variables(i),names,vt,ev,mt) '+'];
            end
        end
        if ~isempty(expression)
            expression(end) = [];
            out = [out expression ','];
        end
    end
    if ~isempty(out)
        if vectorfunction
            out(end) = ';';
        else
            out(end) = ',';
        end
    else
        out;
    end
end
if ~isempty(out)
    out(end) = [];
end
if any(sp > 1)
    if vectorfunction
        out = [out ']'];
    else
        out = [out ' '];
    end
end
if isempty(out)
    out = '0';
end
expression = out;

%------------------------------------------------------------------------
function s = symbolicmonomial(variable,names,vt,ev,mt)

terms = find(mt(variable,:));
if ismember(variable,ev)
    q = yalmip('extstruct',variable);
    fcn = q.fcn;
    fcn = strrep(fcn, 'mpower_internal', '');
    fcn = strrep(fcn, '_internal', '');
    if length(fcn) > 1
        fcn = ['System.Math.' upper(fcn(1)) fcn(2:end)];
    end
    s = [fcn '(' symbolicdisplay(q.arg{1},names,vt,ev,mt)];
    for i = 2:length(q.arg)-1
        s = [s ',' symbolicdisplay(q.arg{i}, names, vt, ev, mt)];
    end
    s = [s ')'];

elseif ~vt(variable)
    % Linear expression
    if variable > length(names)
        warning('Variable name unknown');
        s = sprintf('internal(%d)', variable);
    else
        s = names{variable};
    end
else
    % Fancy display of a monomial
    s = [''];
    for i = 1:length(terms)
        if mt(variable,terms(i)) == 1
            s = [s symbolicmonomial(terms(i),names,vt,ev,mt) '*'];
%             exponent = '';
        else
            exponent = sub_mat2str(mt(variable,terms(i)));
            s = [s 'h3_power_internal(' symbolicmonomial(terms(i),names,vt,ev,mt) ...
                ', ' exponent ')*'];
            %             exponent = ['^' sub_mat2str(mt(variable,terms(i)))];
        end
%         s = [s symbolicmonomial(terms(i),names,vt,ev,mt) exponent '*'];
    end
    s(end)=[];
end
% s = strrep(s,'^1+','+');
% s = strrep(s,'^1*','*');


%----------------------------------------------
function y = sub_mat2str(x)

y = mat2str(full(x));
