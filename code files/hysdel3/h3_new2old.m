function MLDold = h3_new2old(MLD)
% HYSDEL3-to-HYSDEL2 conversion of the MLD structure

MLDold.A = MLD.A;
MLDold.B1 = MLD.Bu;
MLDold.B2 = MLD.Baux(:,MLD.j.d);
MLDold.B3 = MLD.Baux(:,MLD.j.z);
MLDold.B5 = MLD.Baff;
MLDold.C = MLD.C;
MLDold.D1 = MLD.Du;
MLDold.D2 = MLD.Daux(:,MLD.j.d);
MLDold.D3 = MLD.Daux(:,MLD.j.z);
MLDold.D5 = MLD.Daff;
MLDold.E1 = -MLD.Eu;
MLDold.E2 = MLD.Eaux(:,MLD.j.d);
MLDold.E3 = MLD.Eaux(:,MLD.j.z);
MLDold.E4 = -MLD.Ex;
MLDold.E5 = MLD.Eaff;
% dimensions
MLDold.nx = MLD.nx;
MLDold.nxr = length(MLD.j.xr);
MLDold.nxb = length(MLD.j.xb);
MLDold.nu = MLD.nu;
MLDold.nur = length(MLD.j.ur);
MLDold.nub = length(MLD.j.ub);
MLDold.ny = MLD.ny;
MLDold.nyr = length(MLD.j.yr);
MLDold.nyb = length(MLD.j.yb);
MLDold.nd = length(MLD.j.d);
MLDold.nz = length(MLD.j.z);
MLDold.ne = size(MLD.Ex, 1);
% upper/lower bounds
MLDold.xl = MLD.xl;
MLDold.xu = MLD.xu;
MLDold.ul = MLD.ul;
MLDold.uu = MLD.uu;
MLDold.yl = MLD.yl;
MLDold.yu = MLD.yu;
MLDold.dl = MLD.wl(MLD.j.d);
MLDold.du = MLD.wu(MLD.j.d);
MLDold.zl = MLD.wl(MLD.j.z);
MLDold.zu = MLD.wu(MLD.j.z);
MLDold.symtable = [];
MLDold.MLDisvalid = 1;

end
