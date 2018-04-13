function[Srr,Spp,Szz,Srp,Spz,Srz]=strain(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1)
% calculate the strain rate tensor in parallel

% velocity gradient tensor
[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz] = vgrad(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1);

Srr = zeros(meshr,meshphi,meshz,id1-id0+1);
Spp = zeros(meshr,meshphi,meshz,id1-id0+1);
Szz = zeros(meshr,meshphi,meshz,id1-id0+1);
Srp = zeros(meshr,meshphi,meshz,id1-id0+1);
Spz = zeros(meshr,meshphi,meshz,id1-id0+1);
Srz = zeros(meshr,meshphi,meshz,id1-id0+1);

%strain rate tensor
Srr = grr;

Srp = 0.5*(grp + gpr);

Srz = 0.5*(grz + gzr);

Spp = gpp;

Spz = 0.5*(gpz + gzp);

Szz = gzz;
clear g* ;
end
