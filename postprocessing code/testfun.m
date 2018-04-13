function[fr,fphi,fz,ref1,ref2,ref3] = testfun(meshr,meshphi,meshz,r,phi,z,flag)
% design an analytical test vector function 
% flag = 1 : fphi(r, phi, z) = r* cos(phi)+z
% flag = 2 : fr(r, phi, z) = r*z*sin(phi) ; fphi(r, phi, z) = r^2*
% cos(phi)+z^2 ; fz(r, phi, z) = r*z*cos(phi)
fr = zeros(meshr,meshphi,meshz);

fphi = zeros(meshr,meshphi,meshz);

fz = zeros(meshr,meshphi,meshz);


for k =1:meshz
    for j =1: meshphi
        for i = 1:meshr
            
            if flag ==1
                
            fphi(i,j,k) = r(i)*cos(phi(j))+z(k);
            
            ref1(i,j,k) = -1/r(i)^2*(r(i)*cos(phi(j))+z(k))^2;
            
            ref2(i,j,k) = 0.5*(2+2*cos(phi(j))^2+(2*cos(phi(j))*(z(k)+r(i)*cos(phi(j))))/r(i)+(-2*r(i)*cos(phi(j))*(z(k)+r(i)*cos(phi(j)))+2*r(i)^2*sin(phi(j))^2)/r(i)^2);
            
            ref3(i,j,k) = 2+1/r(i)^2*(r(i)*cos(phi(j))+z(k))^2;
            
            elseif flag ==2      
                
            fr(i,j,k) = r(i) * z(k) * sin(phi(j));
            
            fphi(i,j,k) = 
            
            end
 
        end
    end
end

    
    


end