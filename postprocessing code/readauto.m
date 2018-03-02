function[] = readauto(nel,N,meshr,meshphi,meshz,r1,r2,ifield)
%dump the information of flow field on uniform mesh into matrices for post process 
meshr1 = meshr - 1;
meshz1 = meshz - 1;
r = linspace(r1,r2,meshr);
phi = linspace(0,2*pi,meshphi);
z = linspace(0,1,meshz);
X1=r'*cos(phi);
Y1=r'*sin(phi);
for i=1:meshz
    Xm(:,:,i)=X1(:,:);
    Ym(:,:,i)=Y1(:,:);
end


% loop start
for p = 1 : ifield

fname1 = 'field/cylann_reg0.f';  
if p<10
    fname = [fname1,'0000',num2str(p)];
elseif p<100
    fname = [fname1,'000',num2str(p)];
elseif p<1000
    fname = [fname1,'00',num2str(p)];
elseif p<10000
    fname = [fname1,'0',num2str(p)];      
else
    fname = [fname1,num2str(p)];
end
[time,istep,nel,N,datax,datay,dataz,datau,datav,dataw,datat] = readnek(fname);    
mesh = zeros((N-1)*nelz+1,(N-1)*nely+1,(N-1)*nelx+1);   

end
% end loop
end