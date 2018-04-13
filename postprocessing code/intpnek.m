function[U,V,W,T,Xm,Ym,Zm,r] = intpnek(datax,datay,dataz,datau,datav,dataw,datat,r1,r2,meshr,meshphi,meshz)
U = zeros(meshr,meshphi,meshz);
V = zeros(meshr,meshphi,meshz);
W = zeros(meshr,meshphi,meshz);
T = zeros(meshr,meshphi,meshz);

%---------------------------------------------------
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
%----------------------------------------------------
%linearly interpolate flow field onto new homogeneous annular mesh

    U = griddata(datax,datay,dataz,datau,Xm,Ym,Zm);
    V = griddata(datax,datay,dataz,datav,Xm,Ym,Zm);
    W = griddata(datax,datay,dataz,dataw,Xm,Ym,Zm);
    T = griddata(datax,datay,dataz,datat,Xm,Ym,Zm);
    U(meshr,:,:)=U(meshr-1,:,:);
    U(:,meshphi,:)=U(:,1,:);
    V(meshr,:,:)=V(meshr-1,:,:);
    V(:,meshphi,:)=V(:,1,:);
    W(meshr,:,:) = W(meshr-1,:,:);
    W(:,meshphi,:) = W(:,1,:);
    T(meshr,:,:)=T(meshr-1,:,:);
    T(:,meshphi,:) = T(:,1,:);

%----------------------------------------------------
end
