function[flow,ord,r,phi,z] = serialintp(r1,r2,meshr,meshphi,meshz,datax0,datay0,dataz0,datau0,datav0,dataw0,datat0,id0,id1)
% interpolate a flow fields with U, V, W, T
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
if id0~=id1
parfor i=id0:id1

    %interpolation in parallel

    flow(i).U = griddata(datax0,datay0,dataz0,datau0(:,:,i),Xm,Ym,Zm);
    flow(i).V = griddata(datax0,datay0,dataz0,datav0(:,:,i),Xm,Ym,Zm);
    flow(i).W = griddata(datax0,datay0,dataz0,dataw0(:,:,i),Xm,Ym,Zm);
    flow(i).T = griddata(datax0,datay0,dataz0,datat0(:,:,i),Xm,Ym,Zm);
      
end


for i=id0:id1
%---------Dirichlet bc-------------
flow(i).U(:,:,1) = 0;
flow(i).V(:,:,1) = 0;
flow(i).W(:,:,1) = 0;
flow(i).T(:,:,1) = 0.5;

flow(i).U(:,:,meshz) = 0;
flow(i).V(:,:,meshz) = 0;
flow(i).W(:,:,meshz) = 0;
flow(i).T(:,:,meshz) = -0.5;
%-----------end--------------------
flow(i).U(meshr,:,:)= flow(i).U(meshr-1,:,:);
flow(i).V(meshr,:,:)= flow(i).V(meshr-1,:,:);
flow(i).W(meshr,:,:)= flow(i).W(meshr-1,:,:);
flow(i).T(meshr,:,:)= flow(i).T(meshr-1,:,:);
end
else
    flow.U = griddata(datax0,datay0,dataz0,datau0,Xm,Ym,Zm);
    flow.V = griddata(datax0,datay0,dataz0,datav0,Xm,Ym,Zm);
    flow.W = griddata(datax0,datay0,dataz0,dataw0,Xm,Ym,Zm);
    flow.T = griddata(datax0,datay0,dataz0,datat0,Xm,Ym,Zm);
    
    %---------Dirichlet bc-------------
     flow.U(:,:,1) = 0;
     flow.V(:,:,1) = 0;
     flow.W(:,:,1) = 0;
     flow.T(:,:,1) = 0.5;

     flow.U(:,:,meshz) = 0;
     flow.V(:,:,meshz) = 0;
     flow.W(:,:,meshz) = 0;
     flow.T(:,:,meshz) = -0.5;
%-----------end--------------------
    flow.U(meshr,:,:)= flow.U(meshr-1,:,:);
    flow.V(meshr,:,:)= flow.V(meshr-1,:,:);
    flow.W(meshr,:,:)= flow.W(meshr-1,:,:);
    flow.T(meshr,:,:)= flow.T(meshr-1,:,:);
end
%dump the interpolated field into .mat files for subsequent processing
clear datau0 datav0 dataw0 datat0;

save('results/flow','flow');

save('results/ord','ord');

save('results/cylord','r','phi','z');


end