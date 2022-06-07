clear;
clc;

hysname_LIST={'test043a','test043b','test043c','test043d'};

for nmidx=1:length(hysname_LIST)
  hysname=hysname_LIST{nmidx};
  disp([num2str(nmidx),'-',hysname]);

  clear n;
  if nmidx==3
    % assign parameter in compilation
    clear pars;
    pars.n=4;
    clear(hysname);
    hysdel3(hysname,pars);
    pause(0.1);
    rehash toolbox;
    rehash;
    clear S;
    clear(hysname);
    run(hysname);
  elseif nmidx==4
    % assign parameter before run
    clear(hysname);
    hysdel3(hysname);
    pause(0.1);
    rehash toolbox;
    rehash;
    n=3;
    clear S;
    clear(hysname);
    run(hysname);
  else
    clear(hysname);
    hysdel3(hysname);
    pause(0.1);
    rehash toolbox;
    rehash;
    clear(hysname);
    run(hysname);
  end

  %S,
  info={'x','u','w','aff'},
  xnext=[S.A,NaN(S.nx,1), S.Bu, NaN(S.nx,1), S.Baux, NaN(S.nx,1), S.Baff],
  y=[S.C,NaN(S.ny,1), S.Du, NaN(S.ny,1), S.Daux, NaN(S.ny,1), S.Daff],
  boundsY=[S.yl,S.yu],
  eqs=zeros(S.nc,1); eqs(S.j.eq)=1; % 1 means eq, 0 ineq
  constr=[S.Ex,NaN(S.nc,1), S.Eu, NaN(S.nc,1), S.Eaux, NaN(S.nc,1), S.Eaff, eqs],
  boundsXUW=[[S.xu';S.xl'],NaN(2,1),[S.uu';S.ul'],NaN(2,1), [S.wu';S.wl']],

end

% PROBLEM
% in test043d the resulting state update and output matrices are WRONG.
% --> as soon as there are symbolic parameters declared (and not assigned during compilation (i.e.
% remain symbolic til 'run')), the order of x+ and y (the rows in the matrices)
% will no be the right one anymore.
% It will be the order in which they are assigned in the CONTINUOUS section (resp. IMPLEMENTATION-
% OUPUT) instead of the order  in which they are declared in STATE (resp.
% INTERFACE-OUTPUT). That even holds for element of vectors!



