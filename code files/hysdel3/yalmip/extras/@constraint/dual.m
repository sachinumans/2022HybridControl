function sys = dual(X)
%DUAL Extract dual variable
%   
%   Z = DUAL(F)     Returns the dual variable for the constraint F
% 
%   See also SOLVESDP, DUALIZE
  
% Author Johan Löfberg
% $Id: dual.m,v 1.1 2009-05-04 09:15:22 joloef Exp $

sys = dual(set(X))
