function[datax,datay,dataz,meshr,meshphi,meshz,nel,np,Ra,Pr,Gr2,Ro1,r1,r2] = preset(otname)
% pre-set necessary matrices and parameters before every istp-loop

fname = sprintf('%s%s%s','results/para_',otname,'.in');

[vname,val]=textread(fname,'%s %f',10) ;

meshr = val(6);
meshphi = val(7);
meshz = val(8);

nel =val(9);
np = val(10);

cornamex = sprintf('%s%s%s','results/x_',otname,'.mat');
cornamey = sprintf('%s%s%s','results/y_',otname,'.mat');
cornamez = sprintf('%s%s%s','results/z_',otname,'.mat');

datax = importdata(cornamex);
datay = importdata(cornamey);
dataz = importdata(cornamez);

Ra = val(1);
Pr = val(2);
Gr2 = sqrt(Pr/Ra);
Ro1 = val(3);

r1 = val(4);
r2 = val(5);

end