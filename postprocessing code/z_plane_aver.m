function[a_plane_aver,a_plane,k]=z_plane_aver(a,meshr,meshphi,meshz,Zm,z0,r,r1,r2)

meshz1=meshz -1;
meshr1=meshr -1;
ac = [];
a_plane = [];
area = [];
zz = [];
%--------------------------------------------------
% calculate z- planar average of flow properties
%--------------------------------------------------

% linear interpolate value onto a specific z0 plane
for i=1:meshr
    for j=1:meshphi
        for k=1:meshz
           zz(k)= Zm(i,j,k);
        end
    end
end

for k = 1:meshz1
    
    if (z0>=zz(k)) & (z0<=zz(k+1))
        z_start = zz(k);
        z_end = zz(k+1);
        break;
    end
end

alpha = (z0-z_start)/(z_end-z_start);

fprintf(' k= %d, alpha = %d\n',k,alpha);

for i=1:meshr
    for j=1:meshphi
       a_plane(i,j) = a(i,j,k) + alpha * (a(i,j,k+1) - a(i,j,k));  
    end
end

% planar average

a_intg = 0;

area_t = 0;

for i = 1:meshr1
    for j = 1:meshphi
        
        if j == meshphi
            
            ac(i,j) = 0.25 * (a_plane(i,j) + a_plane(i+1,j) + a_plane(i,1) + a_plane(i+1,1));
            
            area(i,j) = 0.5 * 2*pi/meshphi * (r(i+1) + r(i))*(r2-r1)/meshr1;
            
            a_intg = a_intg + ac(i,j) * area(i,j); 
            
            area_t = area_t + area(i,j);
            
        else
            
            ac(i,j) = 0.25 * (a_plane(i,j) + a_plane(i+1,j) + a_plane(i,j+1) + a_plane(i+1,j+1));
            
            area(i,j) = 0.5 * 2*pi/meshphi * (r(i+1) + r(i))*(r2-r1)/meshr1;
            
            a_intg = a_intg + ac(i,j) * area(i,j); 
            
            area_t = area_t + area(i,j);    
            
        end
    end
end

a_plane_aver = a_intg/area_t;            
           
end