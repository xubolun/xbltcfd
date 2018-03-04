function[flow,ord] = serialintp(r1,r2,meshr,meshphi,meshz,datax0,datay0,dataz0,datau0,datav0,dataw0,datat0,id0,id1)

%create an annular cylinder domain for interpolation
r = linspace(r1,r2,meshr);
phi = linspace(0,2*pi,meshphi);
z = linspace(0,1,meshz);
X1=r'*cos(phi);
Y1=r'*sin(phi);
for i=1:meshz
    Xm0(:,:,i)=X1(:,:);
    Ym0(:,:,i)=Y1(:,:);
end

for i=1:meshr
    for j=1:meshphi
        for k=1:meshz
            Zm0(i,j,k)=z(k);
        end
    end
end
%----------------------------------------------------
for i=id0:id1

    ord(i).Xm(:,:,:) = Xm0(:,:,:);
    ord(i).Ym(:,:,:) = Ym0(:,:,:);
    ord(i).Zm(:,:,:) = Zm0(:,:,:);
    
end

tic;
%interpolation in parallel
 parfor i=id0:id1
    
    flow(i).U = griddata(datax0,datay0,dataz0,datau0,ord(i).Xm,ord(i).Ym,ord(i).Zm);
    flow(i).V = griddata(datax0,datay0,dataz0,datav0,ord(i).Xm,ord(i).Ym,ord(i).Zm);
    flow(i).W = griddata(datax0,datay0,dataz0,dataw0,ord(i).Xm,ord(i).Ym,ord(i).Zm);
    flow(i).T = griddata(datax0,datay0,dataz0,datat0,ord(i).Xm,ord(i).Ym,ord(i).Zm);
    
end
toc;

for i=id0:id1
flow(i).U(meshr,:,:)= flow(i).U(meshr-1,:,:);
flow(i).V(meshr,:,:)= flow(i).V(meshr-1,:,:);
flow(i).W(meshr,:,:)= flow(i).W(meshr-1,:,:);
flow(i).T(meshr,:,:)= flow(i).T(meshr-1,:,:);
end

end
