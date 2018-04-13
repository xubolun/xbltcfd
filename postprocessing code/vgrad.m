function[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz]=vgrad(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1)
% calculate an arbitary vector gradient tensor in cylindrical coordinate in
% parallel

[dur,duphi,duz]=deri(u,r1,r2,meshr,meshphi,meshz,id0,id1);
[dvr,dvphi,dvz]=deri(v,r1,r2,meshr,meshphi,meshz,id0,id1);
[dwr,dwphi,dwz]=deri(w,r1,r2,meshr,meshphi,meshz,id0,id1);
grr = zeros(meshr,meshphi,meshz,id1-id0+1);
grp = zeros(meshr,meshphi,meshz,id1-id0+1);
grz = zeros(meshr,meshphi,meshz,id1-id0+1);
gpr = zeros(meshr,meshphi,meshz,id1-id0+1);
gpp = zeros(meshr,meshphi,meshz,id1-id0+1);
gpz = zeros(meshr,meshphi,meshz,id1-id0+1);
gzr = zeros(meshr,meshphi,meshz,id1-id0+1);
gzp = zeros(meshr,meshphi,meshz,id1-id0+1);
gzz = zeros(meshr,meshphi,meshz,id1-id0+1);

grr = dur;
grp = dvr;
grz = dwr;

gzr = duz;
gzp = dvz;
gzz = dwz;

if id0~=id1
for l = id0:id1
    
    for i = 1:meshr
        
        gpr(i,:,:,l-id0+1) = (duphi(i,:,:,l-id0+1) - v(i,:,:,l-id0+1))./r(i);
        gpp(i,:,:,l-id0+1) = (dvphi(i,:,:,l-id0+1) + u(i,:,:,l-id0+1))./r(i);
        gpz(i,:,:,l-id0+1) = dwphi(i,:,:,l-id0+1)./r(i);
        
    end
    
end
else
    for i = 1:meshr
        
        gpr(i,:,:) = (duphi(i,:,:) - v(i,:,:))./r(i);
        gpp(i,:,:) = (dvphi(i,:,:) + u(i,:,:))./r(i);
        gpz(i,:,:) = dwphi(i,:,:)./r(i);
        
    end
    
end
clear d* ; 
end
