function[U,V,W,T,Xm,Ym,Zm] = serialintp(r1,r2,meshr,meshphi,meshz,datax0,datay0,dataz0,datau,datav,dataw,datat,id0,id1)

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
    
    datax(:,:,i) = datax0(:,:);
    datay(:,:,i) = datay0(:,:);
    dataz(:,:,i) = dataz0(:,:);
    Xm(:,:,:,i) = Xm0(:,:,:);
    Ym(:,:,:,i) = Ym0(:,:,:);
    Zm(:,:,:,i) = Zm0(:,:,:);
    
end

tic;
%interpolation in parallel
 parfor i=id0:id1
    
    U(:,:,:,i) = griddata(datax(:,:,i),datay(:,:,i),dataz(:,:,i),datau(:,:,i),Xm(:,:,:,i),Ym(:,:,:,i),Zm(:,:,:,i));
    V(:,:,:,i) = griddata(datax(:,:,i),datay(:,:,i),dataz(:,:,i),datav(:,:,i),Xm(:,:,:,i),Ym(:,:,:,i),Zm(:,:,:,i));
    W(:,:,:,i) = griddata(datax(:,:,i),datay(:,:,i),dataz(:,:,i),dataw(:,:,i),Xm(:,:,:,i),Ym(:,:,:,i),Zm(:,:,:,i));
    T(:,:,:,i) = griddata(datax(:,:,i),datay(:,:,i),dataz(:,:,i),datat(:,:,i),Xm(:,:,:,i),Ym(:,:,:,i),Zm(:,:,:,i));
    
end
toc;

for i=id0:id1
U(meshr,:,:,i) = U(meshr-1,:,:,i);
V(meshr,:,:,i) = V(meshr-1,:,:,i);
W(meshr,:,:,i) = W(meshr-1,:,:,i);
T(meshr,:,:,i) = T(meshr-1,:,:,i);
end

end