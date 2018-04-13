function [vtranz_i,vstrez_i,vdiffz_i,vbuoyz_i,vrotz_i] = vbudget(meshr,meshphi,meshz,r,r1,r2,U,V,W,vtr,vtp,vtz,T,Ra,Pr,Ro1,id0,id1)
% calculate the bugdet of vorticity equation
zero = {[0 0 0]};
len = id1 - id0 +1;
vtran = repmat(zero,meshr,meshphi,meshz,len);
vstre = repmat(zero,meshr,meshphi,meshz,len);
vdiff = repmat(zero,meshr,meshphi,meshz,len);
vbuoy = repmat(zero,meshr,meshphi,meshz,len);
vrot = repmat(zero,meshr,meshphi,meshz,len);
tr = zeros(meshr,meshphi,meshz,len); 
tp = zeros(meshr,meshphi,meshz,len);
% vorticity/velocity related vector/tensor

[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz]=vgrad(vtr,vtp,vtz,r,r1,r2,meshr,meshphi,meshz,id0,id1); %the gradient of velocity

[vorr,vorp,vorz,vopr,vopp,vopz,vozr,vozp,vozz]=vgrad(vtr,vtp,vtz,r,r1,r2,meshr,meshphi,meshz,id0,id1); %the gradient of vorticity 

[Lvr,Lvp,Lvz]=laplaceV(vtr,vtp,vtz,r,r1,r2,meshr,meshphi,meshz,id0,id1);  % laplacian of vorticity vector

[tvr,tvp,tvz] = curl(tr,tp,T,meshr,meshphi,meshz,r,r1,r2,id0,id1);

vecz = [0;0;1];

if id0~=id1
    
else  
    
    for k = 1: meshz
        
      for j = 1: meshphi
          
          for i = 1:meshr
              
              vgra(i,j,k) =  {[grr(i,j,k),grp(i,j,k),grz(i,j,k); ...
                               gpr(i,j,k),gpp(i,j,k),gpz(i,j,k); ...
                               gzr(i,j,k),gzp(i,j,k),gzz(i,j,k)]}; 
              
              gvor(i,j,k) =   {[vorr(i,j,k),vorp(i,j,k),vorz(i,j,k); ...
                               vopr(i,j,k),vopp(i,j,k),vopz(i,j,k); ...
                               vozr(i,j,k),vozp(i,j,k),vozz(i,j,k)]}; 
              
              Vvec(i,j,k)  =   {[U(i,j,k); V(i,j,k); W(i,j,k)]};          
                           
              vor(i,j,k) = {[vtr(i,j,k); vtp(i,j,k); vtz(i,j,k)]};   
                           
              Lvor(i,j,k) = {[Lvr(i,j,k),Lvp(i,j,k),Lvz(i,j,k)]}; % convert it to a row vector
              
              curl_t(i,j,k) = {[tvr(i,j,k),tvp(i,j,k),tvz(i,j,k)]}; % convert it to a row vector
          end
      end
      
   end
    
end

if id0~=id1
    
else
    for k = 1: meshz
        
      for j = 1: meshphi
          
          for i = 1:meshr
              
              vtran{i,j,k} = - Vvec{i,j,k}'*gvor{i,j,k};
              
              vstre{i,j,k} = vor{i,j,k}'*vgra{i,j,k};
              
              vdiff{i,j,k} = Pr*Lvor{i,j,k};
              
              vbuoy{i,j,k} = Ra*Pr*curl_t{i,j,k};
              
              vrot{i,j,k} = sqrt(Ra * Pr)*Ro1*vecz'*vgra{i,j,k};
              
              % r- phi- z- vorticity budget
          end
      end
    end
    
    % focus on z- budget
    for k = 1: meshz
        
      for j = 1: meshphi
          
          for i = 1:meshr
              
              temp = zeros(1,3);
              
              temp = vtran{i,j,k};
              
              vtranz(i,j,k) = temp(1,3);
                            
              temp = vstre{i,j,k};
              
              vstrez(i,j,k) = temp(1,3);             
              
              temp = vdiff{i,j,k};
              
              vdiffz(i,j,k) = temp(1,3);
              
              
              temp = vbuoy{i,j,k};
              
              vbuoyz(i,j,k) = temp(1,3);
              
              
              temp = vrot{i,j,k};
              
              vrotz(i,j,k) = temp(1,3);
              
              
          end
      end
    end
   
    [vtranz_i,vtranz_a]=glsc3(vtranz,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    [vstrez_i,vstrez_a]=glsc3(vstrez,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    [vdiffz_i,vdiffz_a]=glsc3(vdiffz,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    [vbuoyz_i,vbuoyz_a]=glsc3(vbuoyz,r,r1,r2,meshr,meshphi,meshz,id0,id1);
    [vrotz_i, vrotz_a]=glsc3(vrotz,r,r1,r2,meshr,meshphi,meshz,id0,id1);
end


end
