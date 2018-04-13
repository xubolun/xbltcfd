function[v_intg,v_avg]=glsc3(A,r,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the voluem integal and volune average of "a" field in parallel
meshz1=meshz -1;
meshr1=meshr -1;
len = id1-id0+1;
Ac=zeros(meshr1,meshphi,meshz1,len);
volume=zeros(meshr1,meshphi,meshz1,len);
v_intg=zeros(len);
vt=zeros(len);

% parfor l = id0:id1
if id0~=id1
for l = id0:id1    
for k=1:meshz1
    for j=1:meshphi
        for i=1:meshr1
            if j==meshphi 
                Ac(i,j,k,l-id0+1) = 0.125 * (A(i,j,k,l-id0+1)+A(i+1,j,k,l-id0+1)+A(i,1,k,l-id0+1)+A(i,j,k+1,l-id0+1)+A(i+1,1,k,l-id0+1)+A(i+1,j,k+1,l-id0+1)+A(i,1,k+1,l-id0+1)+A(i+1,1,k+1,l-id0+1));
                volume(i,j,k,l-id0+1) = 1/meshz1 * 2*pi/meshphi *0.5*(r(i+1)+r(i))*(r2-r1)/meshr1;
                v_intg(l-id0+1) = v_intg(l-id0+1) +Ac(i,j,k,l-id0+1)*volume(i,j,k,l-id0+1);
                vt(l-id0+1)=vt(l-id0+1)+volume(i,j,k,l-id0+1);
            else
                Ac(i,j,k,l-id0+1) = 0.125 * (A(i,j,k,l-id0+1)+A(i+1,j,k,l-id0+1)+A(i,j+1,k,l-id0+1)+A(i,j,k+1,l-id0+1)+A(i+1,j+1,k,l-id0+1)+A(i+1,j,k+1,l-id0+1)+A(i,j+1,k+1,l-id0+1)+A(i+1,j+1,k+1,l-id0+1)); 
                volume(i,j,k,l-id0+1) = 1/meshz1 * 2*pi/meshphi *0.5*(r(i+1)+r(i))*(r2-r1)/meshr1;
                v_intg(l-id0+1) = v_intg(l-id0+1) +Ac(i,j,k,l-id0+1)*volume(i,j,k,l-id0+1);
                vt(l-id0+1)=vt(l-id0+1)+volume(i,j,k,l-id0+1);
            end
        end
    end
end

v_avg(l-id0+1)=v_intg(l-id0+1)/vt(l-id0+1);

end

else
  for k=1:meshz1
    for j=1:meshphi
        for i=1:meshr1
            if j==meshphi 
                Ac(i,j,k) = 0.125 * (A(i,j,k)+A(i+1,j,k)+A(i,1,k)+A(i,j,k+1)+A(i+1,1,k)+A(i+1,j,k+1)+A(i,1,k+1)+A(i+1,1,k+1));
                volume(i,j,k) = 1/meshz1 * 2*pi/meshphi *0.5*(r(i+1)+r(i))*(r2-r1)/meshr1;
                v_intg = v_intg +Ac(i,j,k)*volume(i,j,k);
                vt=vt+volume(i,j,k);
            else
                Ac(i,j,k) = 0.125 * (A(i,j,k)+A(i+1,j,k)+A(i,j+1,k)+A(i,j,k+1)+A(i+1,j+1,k)+A(i+1,j,k+1)+A(i,j+1,k+1)+A(i+1,j+1,k+1)); 
                volume(i,j,k) = 1/meshz1 * 2*pi/meshphi *0.5*(r(i+1)+r(i))*(r2-r1)/meshr1;
                v_intg = v_intg +Ac(i,j,k)*volume(i,j,k);
                vt=vt+volume(i,j,k);
            end
        end
    end
end

v_avg=v_intg/vt;  
end
end