function[La]=laplaceS(a,r,r1,r2,meshr,meshphi,meshz,id0,id1)
% calculate the Laplacian of a scalar "a" :=  $\nabla^2 a$ in parallel

[dar,dap,daz]=deri(a,r1,r2,meshr,meshphi,meshz,id0,id1); % 1st order derivative

[ddar,ddap,ddaz]=deri2(a,r1,r2,meshr,meshphi,meshz,id0,id1); %2nd order derivative

if id0 ~= id1
parfor l = id0:id1
    
    for i = 1:meshr
        
        La(i,:,:,l) = 1/r(i).*dar(i,:,:,l) + ddar(i,:,:,l) + 1/r(i)^2.*ddap(i,:,:,l) + ddaz(i,:,:,l);
        
    end
      
end
else
    for i = 1:meshr
        
        La(i,:,:) = 1/r(i).*dar(i,:,:) + ddar(i,:,:) + 1/r(i)^2.*ddap(i,:,:) + ddaz(i,:,:);
        
    end
    
end
end
