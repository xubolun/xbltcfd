function[gar,gaphi,gaz]=grad(a,r,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the gradient of scalar "a" in cynlindrical coordinate in parallel

[dar,daphi,daz] = deri(a,r1,r2,meshr,meshphi,meshz,id0,id1); % calculate \partial{a}/\partial{r},\partial{a}/\partial{phi},
                                                         %\partial{a}/\partial{z}

gar = dar;

parfor l = id0 : id1
    
    for i = 1:meshr
    
    gaphi(i,:,:,l) = daphi(i,:,:,l) * 1/r(i);
    
    end
   
end

gaz = daz;


end