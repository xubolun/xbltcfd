function[v_intg,vt,v_avg,V,Ac]=glsc3(A,r,r1,r2,meshr,meshphi,meshz)
meshz1=meshz -1;
meshr1=meshr -1;
Ac=zeros(meshr1,meshphi,meshz1);
V=zeros(meshr1,meshphi,meshz1);
v_intg=0;
vt=0;
v_avg=0;

for k=1:meshz1
    for j=1:meshphi
        for i=1:meshr1
            if j==meshphi 
                Ac(i,j,k) = 0.125 * (A(i,j,k)+A(i+1,j,k)+A(i,1,k)+A(i,j,k+1)+A(i+1,1,k)+A(i+1,j,k+1)+A(i,1,k+1)+A(i+1,1,k+1));
                V(i,j,k) = 1/meshz1 * 2*pi/meshphi *0.5*(r(i+1)+r(i))* (r2-r1)/meshr1;
                v_intg = v_intg +Ac(i,j,k)*V(i,j,k);
                vt=vt+V(i,j,k);
            else
                Ac(i,j,k) = 0.125 * (A(i,j,k)+A(i+1,j,k)+A(i,j+1,k)+A(i,j,k+1)+A(i+1,j+1,k)+A(i+1,j,k+1)+A(i,j+1,k+1)+A(i+1,j+1,k+1)); 
                V(i,j,k) = 1/meshz1 * 2*pi/meshphi *0.5*(r(i+1)+r(i))*(r2-r1)/meshr1;
                v_intg = v_intg +Ac(i,j,k)*V(i,j,k);
                vt=vt+V(i,j,k);
            end
        end
    end
end

v_avg=v_intg/vt;
end