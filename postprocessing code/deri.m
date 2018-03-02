function[dar,daphi,daz]=deri(a,r,r1,r2,meshr,meshphi,meshz)
%calculate the spacial derivative in cynlindrical coordinate
meshr1 = meshr -1;
meshz1 = meshz -1;

% r- :
% phi- : 
for i = 2: meshr1
    for j = 1:meshphi
        for k = 1: meshz
            if j==1
            
            dar(i,j,k) = (a(i+1,j,k)-a(i-1,j,k))/(2*(r2-r1)/meshr1);
            
            daphi(i,j,k) =(a(i,j+1,k)-a(i,meshphi,k))/(2*2*pi/meshphi);
          
          
            
            elseif j==meshphi
                
            dar(i,j,k) =(a(i+1,j,k)-a(i-1,j,k))/(2*(r2-r1)/meshr1);
            
            daphi(i,j,k) = (a(i,1,k)-a(i,j-1,k))/(2*2*pi/meshphi);
            
            
            else
            
            dar(i,j,k) = (a(i+1,j,k)-a(i-1,j,k))/(2*(r2-r1)/meshr1);
            
            daphi(i,j,k) =(a(i,j+1,k)-a(i,j-1,k))/(2*2*pi/meshphi);
            
            
            end
            
        end
    end
end

%boundary
for j=1:meshphi
    for k=1:meshz
            if j==1
            
            dar(1,j,k) = (a(2,j,k)-a(1,j,k))/((r2-r1)/meshr1);
            dar(meshr,j,k) = (a(meshr,j,k)-a(meshr1,j,k))/((r2-r1)/meshr1);
        
            daphi(1,j,k) = (a(1,j+1,k)-a(1,meshphi,k))/(2*2*pi/meshphi);
            daphi(meshr,j,k) = (a(meshr,j+1,k)-a(meshr,meshphi,k))/(2*2*pi/meshphi);
          
            
            elseif j==meshphi
                
            dar(1,j,k) = (a(2,j,k)-a(1,j,k))/((r2-r1)/meshr1);
            dar(meshr,j,k) = (a(meshr,j,k)-a(meshr1,j,k))/((r2-r1)/meshr1);
        
            daphi(1,j,k) = (a(1,1,k)-a(1,j-1,k))/(2*2*pi/meshphi);
            daphi(meshr,j,k) = (a(meshr,1,k)-a(meshr,j-1,k))/(2*2*pi/meshphi);
            
            
            else      
            dar(1,j,k) = (a(2,j,k)-a(1,j,k))/((r2-r1)/meshr1);
            dar(meshr,j,k) = (a(meshr,j,k)-a(meshr1,j,k))/((r2-r1)/meshr1);
        
            daphi(1,j,k) = (a(1,j+1,k)-a(1,j-1,k))/(2*2*pi/meshphi);
            daphi(meshr,j,k) = (a(meshr,j+1,k)-a(meshr,j-1,k))/(2*2*pi/meshphi);
            end
        
    end 
end

% z- :
for i = 1: meshr
    for j = 1:meshphi
        for k =2:meshz1
            
          daz(i,j,k) = (a(i,j,k+1)-a(i,j,k-1))/(2*1/(meshz1));
          
        end
    end
end

%boundary
for i = 1: meshr
    for j = 1:meshphi
        daz(i,j,1) = (a(i,j,2)-a(i,j,1))/(1/(meshz1));
        daz(i,j,meshz) = (a(i,j,meshz)-a(i,j,meshz1))/(1/(meshz1));
    end
end

end