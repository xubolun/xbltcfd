function [aTaver] = averT(a,time0,meshr,meshphi,meshz,id0,id1)
%calculate the time average of time-dependent field a(t), need fixed time
%step input

aTaver = [];
atot(1:meshr,1:meshphi,1:meshz) = 0;

for l = id0:id1-1
    
    atot(:,:,:) = atot(:,:,:) + 1/2*( a(1:meshr,1:meshphi,1:meshz,l) + a(1:meshr,1:meshphi,1:meshz,l+1) ).* (time0(l+1) - time0(l));
    
    
end

aTaver(:,:,:) = atot(:,:,:)./(time0(id1) - time0(id0));
   
end