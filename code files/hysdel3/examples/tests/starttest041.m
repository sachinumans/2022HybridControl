%% part 1
% parameters, value assigned before compilation: nx,nu,ny,A,C
% parameters, remaining symbolic: B,D 

clear;
hysname='test041',

clear(hysname);
clear pars;
pars.nx=4;
pars.nu=3;
pars.ny=2;
pars.A=rand(pars.nx);
pars.C=rand(pars.ny,pars.nx);
hysdel3(hysname,pars);

B=rand(pars.nx,pars.nu);
D=rand(pars.ny,pars.nu);
clear S;
clear(hysname);
run(hysname);

info={'x','u','w','aff'},
xnext=[S.A,NaN(S.nx,1), S.Bu, NaN(S.nx,1), S.Baux, NaN(S.nx,1), S.Baff],
y=[S.C,NaN(S.ny,1), S.Du, NaN(S.ny,1), S.Daux, NaN(S.ny,1), S.Daff],
boundsY=[S.yl,S.yu],
eqs=zeros(S.nc,1); eqs(S.j.eq)=1; % 1 means eq, 0 ineq
constr=[S.Ex,NaN(S.nc,1), S.Eu, NaN(S.nc,1), S.Eaux, NaN(S.nc,1), S.Eaff, eqs],
boundsXUW=[[S.xu';S.xl'],NaN(2,1),[S.uu';S.ul'],NaN(2,1), [S.wu';S.wl']],


%% part2, the same but parameter A everywhere renamed to BA
% parameters, value assigned before compilation: nx,nu,ny,BA,C
% parameters, remaining symbolic: B,D 
% ==> now error:
% % ??? Reference to non-existent field 'B'.
% % 
% % Error in ==> getfield at 38
% %     f = s.(deblank(strField)); % deblank field name        
% % 
% % Error in ==> h3_isfield at 34
% %     x = h3_isfield(getfield(s, first), last);
% % 
% % Error in ==> h3_fprintf at 31
% %         eval(cmd_line);
% % 
% % Error in ==> hysdel3 at 83
% %         S = h3_fprintf('evaluate', parameters);
% % 
% % Error in ==> starttest041 at 51
% % hysdel3(hysname,pars);


clear;
hysname='test041b',

clear(hysname);
clear pars;
pars.nx=4;
pars.nu=3;
pars.ny=2;
pars.BA=rand(pars.nx);
pars.C=rand(pars.ny,pars.nx);
hysdel3(hysname,pars);

B=rand(pars.nx,pars.nu);
D=rand(pars.ny,pars.nu);
clear S;
clear(hysname);
run(hysname);

info={'x','u','w','aff'},
xnext=[S.A,NaN(S.nx,1), S.Bu, NaN(S.nx,1), S.Baux, NaN(S.nx,1), S.Baff],
y=[S.C,NaN(S.ny,1), S.Du, NaN(S.ny,1), S.Daux, NaN(S.ny,1), S.Daff],
boundsY=[S.yl,S.yu],
eqs=zeros(S.nc,1); eqs(S.j.eq)=1; % 1 means eq, 0 ineq
constr=[S.Ex,NaN(S.nc,1), S.Eu, NaN(S.nc,1), S.Eaux, NaN(S.nc,1), S.Eaff, eqs],
boundsXUW=[[S.xu';S.xl'],NaN(2,1),[S.uu';S.ul'],NaN(2,1), [S.wu';S.wl']],
