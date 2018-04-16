function[flow,ord,r,phi,z] = serialintp1(r1,r2,meshr,meshphi,meshz,datax0,datay0,dataz0,dataa0,id0,id1)
%interpolate a field with only ONE variable "a"
%create an annular cylinder domain for interpolation
r = linspace(r1,r2,meshr);
phi = linspace(0,2*pi,meshphi);
z = linspace(0,1,meshz);
X1=r'*cos(phi);
Y1=r'*sin(phi);
for i=1:meshz
    Xm(:,:,i)=X1(:,:);
    Ym(:,:,i)=Y1(:,:);
end

for i=1:meshr
    for j=1:meshphi
        for k=1:meshz
            Zm(i,j,k)=z(k);
        end
    end
end

ord.Xm(:,:,:) = Xm(:,:,:);
ord.Ym(:,:,:) = Ym(:,:,:);
ord.Zm(:,:,:) = Zm(:,:,:);

%----------------------------------------------------
parfor i=id0:id1
    %interpolation in parallel
    
%     dataa(:,:,:) = dataa0(:,:,:,i);
   
    flow(i).A = griddata(datax0,datay0,dataz0,dataa0(:,:,i),Xm,Ym,Zm);
    fprintf('interpolation complete...\n');  
end

for i=id0:id1
    
flow(i).A(meshr,:,:)= flow(i).A(meshr-1,:,:);

end
%dump the interpolated field into .mat files for subsequent processing

fnameh = char(who('dataa0'));

fname1 = sprintf('%s%s','results/flow_',fnameh);
save(fname1,'flow');

fname2 = sprintf('%s%s','results/ord_',fnameh);
save(fname2,'ord');

fname3 = sprintf('%s%s','results/cylord_',fnameh);
save(fname3,'r','phi','z');

end