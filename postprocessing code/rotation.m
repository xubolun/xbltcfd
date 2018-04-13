function[Rrp,Rpr,Rrz,Rzr,Rpz,Rzp]=rotation(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1)

% calculate the rotation rate tensor in parallel

% velocity gradient tensor
[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz] = vgrad(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1);

Rrp = zeros(meshr,meshphi,meshz,id1-id0+1);
Rpr = zeros(meshr,meshphi,meshz,id1-id0+1);
Rrz = zeros(meshr,meshphi,meshz,id1-id0+1);
Rzr = zeros(meshr,meshphi,meshz,id1-id0+1);
Rpz = zeros(meshr,meshphi,meshz,id1-id0+1);
Rzp = zeros(meshr,meshphi,meshz,id1-id0+1);

%rotation rate tensor

Rrp = 0.5*(grp - gpr);
Rpr = 0.5*(gpr - grp);
Rrz = 0.5*(grz - gzr);
Rzr = 0.5*(gzr - grz);
Rpz = 0.5*(gpz - gzp);
Rzp = 0.5*(gzp - gpz);

clear g* ;
end
