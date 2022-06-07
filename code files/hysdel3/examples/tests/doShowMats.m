function doShowMats(hysname,symsparams)
%doshowMats(hysname,symsparams)
%e.g. symsparams='p1 p2'

%delete([hysname,'.m']);
clear(hysname);
hysdel3(hysname);
clear(hysname);

eval(['syms ',symsparams]);

clear S;
pause(0.1);
rehash;
eval(hysname);

info={'x','u','w','aff'},
xnext=[S.A,NaN(S.nx,1), S.Bu, NaN(S.nx,1), S.Baux, NaN(S.nx,1), S.Baff],
y=[S.C,NaN(S.ny,1), S.Du, NaN(S.ny,1), S.Daux, NaN(S.ny,1), S.Daff],
boundsY=[S.yl,S.yu],
eqs=zeros(S.nc,1); eqs(S.j.eq)=1; % 1 means eq, 0 ineq
constr=[S.Ex,NaN(S.nc,1), S.Eu, NaN(S.nc,1), S.Eaux, NaN(S.nc,1), S.Eaff, eqs],
boundsXUW=[[S.xu';S.xl'],NaN(2,1),[S.uu';S.ul'],NaN(2,1), [S.wu';S.wl']],

end
