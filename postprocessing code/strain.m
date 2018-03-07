function[Srr,Spp,Szz,Srp,Spz,Szr]=strain(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1)
% calculate the strain rate tensor in parallel

[gur,guphi,guz] = grad(u,r,r1,r2,meshr,meshphi,meshz,id0,id1);
[gvr,gvphi,gvz] = grad(v,r,r1,r2,meshr,meshphi,meshz,id0,id1);
[gwr,gwphi,gwz] = grad(w,r,r1,r2,meshr,meshphi,meshz,id0,id1);

%strain rate tensor
parfor l = id0 : id1
    
for i =1:meshr
    
          Srr(i,:,:,l) = gur(i,:,:,l);
          Spp(i,:,:,l) = gvphi(i,:,:,l) + u(i,:,:,l)/r(i);
          Szz(i,:,:,l) = gwz(i,:,:,l);
          
          Srp(i,:,:,l) = r(i)/2 *(1/r(i)*gvr(i,:,:,l) - v(i,:,:,l)/r(i)^2) + 1/2*guphi(i,:,:,l);
          Spz(i,:,:,l) = 1/2*gwphi(i,:,:,l) + 1/2*gvz(i,:,:,l);
          Szr(i,:,:,l) = 1/2*(guz(i,:,:,l)+gwr(i,:,:,l));
   
end
  
end
end