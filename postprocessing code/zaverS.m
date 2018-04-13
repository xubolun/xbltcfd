function[a_avg] = zaverS(A,r,r1,r2,meshr,meshphi,meshz,id0,id1)
%z-plane average of ONE flow property
len = id1 - id0 + 1;

meshr1 = meshr - 1;

a_avg = zeros(meshz,len);

a_intg = zeros(meshz,len);

at = zeros(meshz,len);

if id0 ~= id1
    
else

for k = 1: meshz
    
for j = 1 : meshphi
    
    if j == meshphi 
        for i = 1 : meshr1
            
            Ac(i,j,k) = 0.25 *( A(i,j,k) + A(i+1,j,k) + A(i,1,k) + A(i+1,1,k));
            
            area(i,j,k) = 2*pi/meshphi * 0.5 *(r(i+1)+r(i))*(r2-r1)/meshr1;
            
            a_intg(k) = a_intg(k) + Ac(i,j,k) .* area(i,j,k);
            
            at(k) = at(k) + area(i,j,k);
            
        end
    else
        
        for i = 1 : meshr1
            
            Ac(i,j,k) = 0.25 *( A(i,j,k) + A(i+1,j,k) + A(i,j+1,k) + A(i+1,j+1,k));
            
            area(i,j,k) = 2*pi/meshphi * 0.5 *(r(i+1)+r(i))*(r2-r1)/meshr1;
            
            a_intg(k) = a_intg(k) + Ac(i,j,k) .* area(i,j,k);
            
            at(k) = at(k) + area(i,j,k);
            
        end
        
    end
    
end

a_avg(k) = a_intg(k)/at(k);    

end

end

end
