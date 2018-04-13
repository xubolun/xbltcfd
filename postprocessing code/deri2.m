function[ddar,ddap,ddaz]=deri2(a,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the 2nd order spacial derivative in cynlindrical coordinate in
%parallel

meshr1 = meshr - 1;
meshphi1 = meshphi - 1;
meshz1 = meshz - 1;

[dar,daphi,daz] = deri(a,r1,r2,meshr,meshphi,meshz,id0,id1); % 1st order derivative

[ddar,ddarp,ddarz] = deri(dar,r1,r2,meshr,meshphi,meshz,id0,id1);


if id0 ~= id1
for l = id0:id1 % phi- derivative
    
    for j = 1:meshphi
        
        if j == 1
            
%            ddap(:,j,:) = (a(:,j+1,:)-2*a(:,j,:)+a(:,meshphi1,:))/(2*pi/meshphi)^2;
        ddap(:,j,:,l) =(-a(:,j+2,:,l)+16*a(:,j+1,:,l)-30*a(:,j,:,l)+16*a(:,meshphi1,:,l)-a(:,meshphi1-1,:,l))/(12*(2*pi/meshphi)^2); % 4-order 
        
        elseif j == 2
            
        ddap(:,j,:,l) =(-a(:,j+2,:,l)+16*a(:,j+1,:,l)-30*a(:,j,:,l)+16*a(:,j-1,:,l)-a(:,meshphi1,:,l))/(12*(2*pi/meshphi)^2); % 4-order  
            
        elseif j == meshphi
            
        ddap(:,j,:,l) = ddap(:,1,:,l);
        
        elseif j == meshphi1
            
        ddap(:,j,:,l) =(-a(:,2,:,l)+16*a(:,1,:,l)-30*a(:,j,:,l)+16*a(:,j-1,:,l)-a(:,j-2,:,l))/(12*(2*pi/meshphi)^2); % 4-order  
        
        elseif j == meshphi1-1
            
        ddap(:,j,:,l) =(-a(:,1,:,l)+16*a(:,meshphi1,:,l)-30*a(:,j,:,l)+16*a(:,j-1,:,l)-a(:,j-2,:,l))/(12*(2*pi/meshphi)^2); % 4-order      
            
        else
            
%             ddap(:,j,:) = (a(:,j+1,:)-2*a(:,j,:)+a(:,j-1,:))/(2*pi/meshphi)^2;

        ddap(:,j,:,l) = (-a(:,j+2,:,l)+16*a(:,j+1,:,l)-30*a(:,j,:,l)+16*a(:,j-1,:,l)-a(:,j-2,:,l))/(12*(2*pi/meshphi)^2);
            
        end
    end
    
end

else
    
    for j = 1:meshphi
        
        if j == 1
            
%            ddap(:,j,:) = (a(:,j+1,:)-2*a(:,j,:)+a(:,meshphi1,:))/(2*pi/meshphi)^2;
        ddap(:,j,:) =(-a(:,j+2,:)+16*a(:,j+1,:)-30*a(:,j,:)+16*a(:,meshphi1,:)-a(:,meshphi1-1,:))/(12*(2*pi/meshphi)^2); % 4-order 
        
        elseif j == 2
            
        ddap(:,j,:) =(-a(:,j+2,:)+16*a(:,j+1,:)-30*a(:,j,:)+16*a(:,j-1,:)-a(:,meshphi1,:))/(12*(2*pi/meshphi)^2); % 4-order  
            
        elseif j == meshphi
            
        ddap(:,j,:) = ddap(:,1,:);
        
        elseif j == meshphi1
            
        ddap(:,j,:) =(-a(:,2,:)+16*a(:,1,:)-30*a(:,j,:)+16*a(:,j-1,:)-a(:,j-2,:))/(12*(2*pi/meshphi)^2); % 4-order  
        
        elseif j == meshphi1-1
            
        ddap(:,j,:) =(-a(:,1,:)+16*a(:,meshphi1,:)-30*a(:,j,:)+16*a(:,j-1,:)-a(:,j-2,:))/(12*(2*pi/meshphi)^2); % 4-order      
            
        else
            
%             ddap(:,j,:) = (a(:,j+1,:)-2*a(:,j,:)+a(:,j-1,:))/(2*pi/meshphi)^2;

        ddap(:,j,:) = (-a(:,j+2,:)+16*a(:,j+1,:)-30*a(:,j,:)+16*a(:,j-1,:)-a(:,j-2,:))/(12*(2*pi/meshphi)^2);
            
        end
    end   
    
end


[ddazr,ddazp,ddaz] = deri(daz,r1,r2,meshr,meshphi,meshz,id0,id1);

end