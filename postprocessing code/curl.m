function[vtr,vtp,vtz]=curl(U,V,W,meshr,meshphi,meshz,r,r1,r2,id0,id1)
% calculate the curl of vector (U,V,W) in parallel

[gur,guphi,guz,gvr,gvphi,gvz,gwr,gwphi,gwz]=vgrad(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1);

vtr = zeros(meshr,meshphi,meshz,id1-id0+1);
vtp = zeros(meshr,meshphi,meshz,id1-id0+1);
vtz = zeros(meshr,meshphi,meshz,id1-id0+1);

if id0~=id1
for l = id0:id1 % r-/phi-/z- vorticity
    
    vtr(:,:,:,l-id0+1) = gwphi(:,:,:,l-id0+1) - gvz(:,:,:,l-id0+1);
    
    vtp(:,:,:,l-id0+1) = guz(:,:,:,l-id0+1) - gwr(:,:,:,l-id0+1);   
         
    vtz(:,:,:,l-id0+1) = guphi(:,:,:,l-id0+1) - gvr(:,:,:,l-id0+1) ;
        
    
    
end
else
    
    vtr = gwphi - gvz;
    
    vtp = guz - gwr;   
        
    vtz = guphi - gvr;
    
    
end
clear g* ;
end
