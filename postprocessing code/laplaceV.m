function[Lar,Lap,Laz]=laplaceV(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the Laplacian of a vector (U,V,W) in parallel

LaU = laplaceS(U,r,r1,r2,meshr,meshphi,meshz,id0,id1);

LaV = laplaceS(V,r,r1,r2,meshr,meshphi,meshz,id0,id1);

LaW = laplaceS(W,r,r1,r2,meshr,meshphi,meshz,id0,id1);

[dur,dup,duz]=deri(U,r1,r2,meshr,meshphi,meshz,id0,id1);

[dvr,dvp,dvz]=deri(V,r1,r2,meshr,meshphi,meshz,id0,id1);

if id0~=id1
parfor l = id0:id1
    
    for i = 1:meshr
        
        Lar(i,:,:,l) = LaU(i,:,:,l) - U(i,:,:,l)./r(i)^2 - 2/r(i)^2.*dvp(i,:,:,l);
        
        Lap(i,:,:,l) = LaV(i,:,:,l) + 2/r(i)^2.*dup(i,:,:,l) - V(i,:,:,l)./r(i)^2;
        
        Laz(i,:,:,l) = LaW(i,:,:,l);
        
    end
    
end
else
    for i = 1:meshr
        
        Lar(i,:,:) = LaU(i,:,:) - U(i,:,:)./r(i)^2 - 2/r(i)^2.*dvp(i,:,:);
        
        Lap(i,:,:) = LaV(i,:,:) + 2/r(i)^2.*dup(i,:,:) - V(i,:,:)./r(i)^2;
        
        Laz(i,:,:) = LaW(i,:,:);
        
    end
    
    
end
end
