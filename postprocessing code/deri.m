function[dar,daphi,daz]=deri(a,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the spacial derivative in cynlindrical coordinate in parallel
meshr1 = meshr -1;
meshphi1 = meshphi - 1;
meshz1 = meshz -1;

dar = zeros(meshr,meshphi,meshz,id1-id0+1);
daphi = zeros(meshr,meshphi,meshz,id1-id0+1);
daz = zeros(meshr,meshphi,meshz,id1-id0+1);

if id0 ~= id1
for l = id0:id1 %r- derivative

    for i = 1:meshr
        
        if i == 1
            
%             dar(i,:,:,l) =  (a(i+1,:,:,l)-a(i,:,:,l))/((r2-r1)/meshr1); % 1-order

        dar(i,:,:,l-id0+1) = ( - a(i+2,:,:,l-id0+1) + 4*a(i+1,:,:,l-id0+1) - 3*a(i,:,:,l-id0+1))/(2*(r2-r1)/meshr1); % 2-order
            
        elseif i == meshr
                                           
%             dar(i,:,:,l) =  (a(i,:,:,l)-a(i-1,:,:,l))/((r2-r1)/meshr1); % 1-order
            
        dar(i,:,:,l-id0+1) = ( - a(i,:,:,l-id0+1) + 4*a(i-1,:,:,l-id0+1) - 3*a(i-2,:,:,l-id0+1))/(2*(r2-r1)/meshr1); % 2-order
            
        else
        
        dar(i,:,:,l-id0+1) = (a(i+1,:,:,l-id0+1) - a(i-1,:,:,l-id0+1))/(2*(r2-r1)/meshr1);
        end
        
    end
end  

for l = id0:id1 % phi- derivative
    
    for j = 1:meshphi
        
        if j == 1
            
            daphi(:,j,:,l-id0+1) = (a(:,j+1,:,l-id0+1)-a(:,meshphi1,:,l-id0+1))/(2*2*pi/meshphi);
            
        elseif j == meshphi
            
            daphi(:,j,:,l-id0+1) = daphi(:,1,:,l-id0+1);
            
        else
            
            daphi(:,j,:,l-id0+1) = (a(:,j+1,:,l-id0+1)-a(:,j-1,:,l-id0+1))/(2*2*pi/meshphi);
            
        end
    end
    
end

for l = id0:id1 % z- derivative
    
    for k = 1:meshz
        
        if k == 1
           
    %         daz(:,:,k,l) =  (a(:,:,k+1,l)-a(:,:,k,l))/(1/(meshz1)); % 1-order
    
        daz(:,:,k,l-id0+1) = ( - a(:,:,k+2,l-id0+1) + 4*a(:,:,k+1,l-id0+1) - 3*a(:,:,k,l-id0+1))/(2*1/meshz1);  % 2-order
            
        elseif k == meshz
            
    %         daz(:,:,k,l) = (a(:,:,k,l)-a(:,:,k-1,l))/(1/(meshz1)); % 1-order
            
        daz(:,:,k,l-id0+1) = ( - a(:,:,k,l-id0+1) + 4*a(:,:,k-1,l-id0+1) - 3*a(:,:,k-2,l-id0+1))/(2*1/meshz1);  % 2-order
    
        else
            
            daz(:,:,k,l-id0+1) = (a(:,:,k+1,l-id0+1)-a(:,:,k-1,l-id0+1))/(2*1/(meshz1));
            
        end       
        
    end
    
end
else
     for i = 1:meshr
        
        if i == 1
            
%             dar(i,:,:,l) =  (a(i+1,:,:,l)-a(i,:,:,l))/((r2-r1)/meshr1); % 1-order

        dar(i,:,:) = ( - a(i+2,:,:) + 4*a(i+1,:,:) - 3*a(i,:,:))/(2*(r2-r1)/meshr1); % 2-order
            
        elseif i == meshr
                                           
%             dar(i,:,:,l) =  (a(i,:,:,l)-a(i-1,:,:,l))/((r2-r1)/meshr1); % 1-order
            
        dar(i,:,:) = ( - a(i,:,:) + 4*a(i-1,:,:) - 3*a(i-2,:,:))/(2*(r2-r1)/meshr1); % 2-order
            
        else
        
            dar(i,:,:) = (a(i+1,:,:) - a(i-1,:,:))/(2*(r2-r1)/meshr1);
        end
        
     end
     for j = 1:meshphi
        
        if j == 1
            
            daphi(:,j,:) = (a(:,j+1,:)-a(:,meshphi1,:))/(2*2*pi/meshphi);
            
        elseif j == meshphi
            
            daphi(:,j,:) =daphi(:,1,:); 
            
        else
            
            daphi(:,j,:) = (a(:,j+1,:)-a(:,j-1,:))/(2*2*pi/meshphi);
            
        end
    end
    for k = 1:meshz
        
        if k == 1
           
    %         daz(:,:,k,l) =  (a(:,:,k+1,l)-a(:,:,k,l))/(1/(meshz1)); % 1-order
    
        daz(:,:,k) = ( - a(:,:,k+2) + 4*a(:,:,k+1) - 3*a(:,:,k))/(2*1/meshz1);  % 2-order
            
        elseif k == meshz
            
    %         daz(:,:,k,l) = (a(:,:,k,l)-a(:,:,k-1,l))/(1/(meshz1)); % 1-order
            
        daz(:,:,k) = ( - a(:,:,k) + 4*a(:,:,k-1) - 3*a(:,:,k-2))/(2*1/meshz1);  % 2-order
    
        else
            
            daz(:,:,k) = (a(:,:,k+1)-a(:,:,k-1))/(2*1/(meshz1));
            
        end       
        
    end
     
end
clear a;
end
