function[gar,gaphi,gaz]=grad(a,r,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the gradient of scalar "a" in cynlindrical coordinate in parallel

[dar,daphi,daz] = deri(a,r1,r2,meshr,meshphi,meshz,id0,id1); % calculate \partial{a}/\partial{r},\partial{a}/\partial{phi},
                                                         %\partial{a}/\partial{z}
gar = zeros(meshr,meshphi,meshz,id1-id0+1);
gaphi = zeros(meshr,meshphi,meshz,id1-id0+1);
gaz = zeros(meshr,meshphi,meshz,id1-id0+1);
 
gar = dar;

if id0~=id1
parfor l = id0 : id1
    
    for i = 1:meshr
    
    gaphi(i,:,:,l) = daphi(i,:,:,l) ./r(i);
    
    end
   
end
else
    
    for i = 1:meshr
    
    gaphi(i,:,:) = daphi(i,:,:) ./r(i);
    
    end
   
end
gaz = daz;

clear da*;
end
