function[dar,daphi,daz]=deri(a,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the spacial derivative in cynlindrical coordinate in parallel
meshr1 = meshr -1;
meshz1 = meshz -1;


parfor l = id0:id1 %r- derivative

    for i = 1:meshr
        
        if i == 1
            
            dar(i,:,:,l) =  (a(i+1,:,:,l)-a(i,:,:,l))/((r2-r1)/meshr1);
            
        elseif i == meshr
            
            dar(i,:,:,l) =  (a(i,:,:,l)-a(i-1,:,:,l))/((r2-r1)/meshr1);
            
        else
        
            dar(i,:,:,l) = (a(i+1,:,:,l) - a(i-1,:,:,l))/(2*(r2-r1)/meshr1);
        end
        
    end
end  

parfor l = id0:id1 % phi- derivative
    
    for j = 1:meshphi
        
        if j == 1
            
            daphi(:,j,:,l) = (a(:,j+1,:,l)-a(:,meshphi,:,l))/(2*2*pi/meshphi);
            
        elseif j == meshphi
            
            daphi(:,j,:,l) = (a(:,1,:,l)-a(:,j-1,:,l))/(2*2*pi/meshphi);
            
        else
            
            daphi(:,j,:,l) = (a(:,j+1,:,l)-a(:,j-1,:,l))/(2*2*pi/meshphi);
            
        end
    end
    
end

parfor l = id0:id1 %z- derivative
    
    for k = 1:meshz
        
        if k == 1
           
            daz(:,:,k,l) =  (a(:,:,k+1,l)-a(:,:,k,l))/(1/(meshz1));
            
        elseif k == meshz
            
            daz(:,:,k,l) = (a(:,:,k,l)-a(:,:,k-1,l))/(1/(meshz1));
            
        else
            
            daz(:,:,k,l) = (a(:,:,k+1,l)-a(:,:,k-1,l))/(2*1/(meshz1));
            
        end       
        
    end
    
end


end