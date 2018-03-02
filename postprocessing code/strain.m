function[Srr,Spp,Szz,Srp,Spz,Szr]=strain(u,v,w,r,r1,r2,meshr,meshphi,meshz)

[dur,duphi,duz]=deri(u,r,r1,r2,meshr,meshphi,meshz);
[dvr,dvphi,dvz]=deri(v,r,r1,r2,meshr,meshphi,meshz);
[dwr,dwphi,dwz]=deri(w,r,r1,r2,meshr,meshphi,meshz);

%strain rate tensor
for i =1:meshr
    for j=1:meshphi
        for k = 1:meshz
          Srr(i,j,k) = dur(i,j,k);
          Spp(i,j,k) = 1/r(i) * dvphi(i,j,k) + dur(i,j,k)/r(i);
          Szz(i,j,k) = dwz(i,j,k);
          
          Srp(i,j,k) = r(i)/2 *(1/r(i)*dvr(i,j,k) - v(i,j,k)/r(i)^2) + 1/2/r(i)*duphi(i,j,k);
          Spz(i,j,k) = 1/2/r(i)*dwphi(i,j,k) + 1/2*dvz(i,j,k);
          Szr(i,j,k) = 1/2*(duz(i,j,k)+dwr(i,j,k));
        end
    end
end
          
end