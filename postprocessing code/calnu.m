function [Nu] = calnu(flag,U,V,W,T,Ra,Pr,r,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the instantaneous Nu by several means
% if flag = 1 , then Nu = sqrt(RaPr)<wT>_{A}-\partial_z T_{A}
% else if flag = 2, then Nu = sqrt(RaPr)<wT>_{V}+1
% else if flag = 3, then Nu = <(\partial_i T)^2>_{V}
% else if flag = 4, then Nu = Pr <(\partial_i u_j)^2>_{V}+1

len = id1-id0+1;

flux = zeros(meshr,meshphi,meshz,len);

z_flux = zeros(meshr,meshphi,meshz,len);

flux = W.*T;

[grT,gpT,gzT] =  grad(T,r,r1,r2,meshr,meshphi,meshz,id0,id1);

[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz]=vgrad(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1);
  for k = 1: meshz
      for j = 1: meshphi
          for i = 1:meshr
              
            Gv(i,j,k)   =  {[grr(i,j,k),grp(i,j,k),grz(i,j,k); ...
                               gpr(i,j,k),gpp(i,j,k),gpz(i,j,k); ...
                               gzr(i,j,k),gzp(i,j,k),gzz(i,j,k)]};  % velocity gradient tensor
          end
      end
  end
  
z_flux = sqrt(Ra*Pr).* W.*T - gzT;

if id0 ~=id1
    
else
if flag == 1
    Nu = zeros(meshz);
    
    [a_avg] = zaverS(z_flux,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    
    Nu = a_avg;
elseif flag == 2
    
    [v_intg,v_avg]=glsc3(flux,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    
    Nu = sqrt(Ra*Pr)*v_avg + 1;
    
elseif flag == 3

     gtnorm = grT.^2 + gpT.^2 + gzT.^2;
     
     [v_intg,v_avg]=glsc3(gtnorm,r,r1,r2,meshr,meshphi,meshz,id0,id1);
     
     Nu = v_avg;
    
elseif flag == 4
 for k = 1: meshz
      for j = 1: meshphi
          for i = 1:meshr    
           dissi(i,j,k) = trace(Gv{i,j,k}*Gv{i,j,k}');
          end
      end
 end
    [v_intg,v_avg]=glsc3(dissi,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    
    Nu = Pr * v_avg + 1;
end
end

end