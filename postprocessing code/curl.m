function[vtr,vtp,vtz]=curl(U,V,W,meshr,meshphi,meshz,r,r1,r2,id0,id1)
% calculate the curl of vector (U,V,W) in parallel
[gur,guphi,guz]=grad(U,r,r1,r2,meshr,meshphi,meshz,id0,id1);

[gvr,gvphi,gvz]=grad(V,r,r1,r2,meshr,meshphi,meshz,id0,id1);

[gwr,gwphi,gwz]=grad(W,r,r1,r2,meshr,meshphi,meshz,id0,id1);

parfor l = id0:id1 % r-/phi-/z- vorticity
    
    vtr(:,:,:,l) = gwphi(:,:,:,l) - gvz(:,:,:,l);
    
    vtp(:,:,:,l) = guz(:,:,:,l) - gwr(:,:,:,l);   
    
    for i = 1:meshr 
        
        vtz(i,:,:,l) = 1/r(i)*V(i,:,:,l) + gvr(i,:,:,l) - guphi(i,:,:,l);
        
    end
     
end

end