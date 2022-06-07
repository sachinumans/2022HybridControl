clear;
clc;

hysname_LIST={'test045a', 'test045b'};

for nmidx=1:length(hysname_LIST)
  hysname=hysname_LIST{nmidx};
  disp([num2str(nmidx),'-',hysname]);

    clear(hysname);
    hysdel3(hysname);
    pause(0.1);
    rehash toolbox;
    rehash;
    clear(hysname);
    run(hysname);

  info={'x','u','w','aff'},
  if nmidx==1 
    nx=S.nx;
    ny=S.ny
  elseif nmidx==2;
    nx=2;
    ny=2;
  end
  xnext=[S.A,NaN(nx,1), S.Bu, NaN(nx,1), S.Baux, NaN(nx,1), S.Baff],
  y=[S.C,NaN(ny,1), S.Du, NaN(ny,1), S.Daux, NaN(ny,1), S.Daff],
  boundsY=[S.yl,S.yu],
  eqs=zeros(S.nc,1); eqs(S.j.eq)=1; % 1 means eq, 0 ineq
  constr=[S.Ex,NaN(S.nc,1), S.Eu, NaN(S.nc,1), S.Eaux, NaN(S.nc,1), S.Eaff, eqs],
  boundsXUW=[[S.xu';S.xl'],NaN(2,1),[S.uu';S.ul'],NaN(2,1), [S.wu';S.wl']],

end


% PROBLEM
% if a variable is declared as scalar (e.g. state X, output Y, aux Z)
% and then one tries (by mistake) to assign a vector to it, that will not cause an compileerror.
% instead the following strange thing happens:
%
% -test045a (no parameters declared):
%   -X+ is last element of vector
%   -Y is last element of vector
%   -for Z there are in in E* two different equality constraints
%
% -test045b (symbolic parameters declared, not assinged during compilation, but also not used)
%   -the input and output matrices have now too much rows.
%   -Z, as above
