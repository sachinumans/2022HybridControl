hysname_LIST={'test040a','test040b','test040c'};

for nmidx=1:length(hysname_LIST)
  hysname=hysname_LIST{nmidx},

  clear(hysname);
  clear pars;
  pars.nu=2;
  hysdel3(hysname,pars);

  clear S;
  clear(hysname);
  syms c;
  run(hysname);

  info={'x','u','w','aff'},
  xnext=[S.A,NaN(S.nx,1), S.Bu, NaN(S.nx,1), S.Baux, NaN(S.nx,1), S.Baff],
  y=[S.C,NaN(S.ny,1), S.Du, NaN(S.ny,1), S.Daux, NaN(S.ny,1), S.Daff],
  boundsY=[S.yl,S.yu],
  eqs=zeros(S.nc,1); eqs(S.j.eq)=1; % 1 means eq, 0 ineq
  constr=[S.Ex,NaN(S.nc,1), S.Eu, NaN(S.nc,1), S.Eaux, NaN(S.nc,1), S.Eaff, eqs],
  boundsXUW=[[S.xu';S.xl'],NaN(2,1),[S.uu';S.ul'],NaN(2,1), [S.wu';S.wl']],

end

%% test040a
% ok

%% test040b
% in CONTINUOUS: 
%  /* ## (in comparison to test040a) interchanged the 1 and the 2, but matrices remain the same! -> wrong*/
% (cf file)

%% test040c
% CONTONUOUS-Part; the same as test040a, but written inanother way
% -->error:
% % Parameter "c" considered as symbolic...
% % ??? Undefined function or method 'is' for input arguments of type 'double'.
% % 
% % Error in ==> h3_check_linearity_sym at 16
% %     if is(p(j), 'sigmonial')
% % 
% % Error in ==> h3_check_linearity at 31
% %         L = h3_check_linearity_sym(v, variables);
% % 
% % Error in ==> h3_fprintf at 31
% %         eval(cmd_line);
% % 
% % Error in ==> hysdel3 at 83
% %         S = h3_fprintf('evaluate', parameters);
% % 
% % Error in ==> starttest040 at 11
% %   hysdel3(hysname,pars);




