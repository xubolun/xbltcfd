function [Q] = Q3d(U,V,W,meshr,meshphi,meshz,id0,id1)
%calculate the vortex defined by Q-criterion (Hunt et al., 1988) in
%parallel
% strain rate tensor
[Srr,Spp,Szz,Srp,Spz,Srz]=strain(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1)

[Rrp,Rpr,Rrz,Rzr,Rpz,Rzp] = rotation(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1); % rotation tensor

% calculate the square of L2 normal of S and R tensors first and then
% calculate Q value

parfor l = id0:id1
    
        normS2(:,:,:,l) = Srr(:,:,:,l).^2 + Spp(:,:,:,l).^2 + Szz(:,:,:,l).^2 ...
                       + Srp(:,:,:,l).^2.*2 + Spz(:,:,:,l).^2.*2 + Srz(:,:,:,l).^2.*2;
                   
           
        normR2(:,:,:,l) = Rrp(:,:,:,l).^2 + Rpr(:,:,:,l).^2 + Rrz(:,:,:,l).^2 ...
                       + Rzr(:,:,:,l).^2 + Rpz(:,:,:,l).^2 + Rzp(:,:,:,l).^2;
                   
                   Q(:,:,:,l) = 0.5*(normR2(:,:,:,l) - normS2(:,:,:,l));
end

end
