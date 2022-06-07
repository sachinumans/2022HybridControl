function Y = uminus(Y)
%UMINUS (overloaded)

% Author Johan L�fberg 
% $Id: uminus.m,v 1.5 2008-05-02 08:20:59 joloef Exp $   

if isa(Y,'blkvar')
    Y = sdpvar(Y);
end
    
switch Y.typeflag
case {0,1,2,3,4}
	Y.basis = -Y.basis;	
    %case {1,3,4}
	%error('Relational objects canot be manipulated')
case 9
    Y.extra.M = -Y.extra.M;
    Y.extra.negated = ~Y.extra.negated;
case 5
	error('Cone object cannot be negated');
otherwise
end
% Reset info about conic terms
Y.conicinfo = [0 0];
Y.extra.opname='';


