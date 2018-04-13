function[enstrophy,stre,diff,dissi,visc,buoy,rot]=enstro(meshr,meshphi,meshz,r,r1,r2,U,V,W,vtr,vtp,vtz,T,Gr2,Ro1,id0,id1)
%calculate the enstrophy and budgets of enstrophy transport equation in
%parallel, Gr2 = sqrt(1/Gr), 1/Gr = Pr/Ra, Ro1 = 1/Ro
stre = zeros(meshr,meshphi,meshz,id1-id0+1);
diff = zeros(meshr,meshphi,meshz,id1-id0+1) ;
dissi =  zeros(meshr,meshphi,meshz,id1-id0+1);
visc= zeros(meshr,meshphi,meshz,id1-id0+1);
buoy =  zeros(meshr,meshphi,meshz,id1-id0+1);
rot =  zeros(meshr,meshphi,meshz,id1-id0+1);
tr = zeros(meshr,meshphi,meshz,id1-id0+1); 
tp = zeros(meshr,meshphi,meshz,id1-id0+1);
% curl of buoyancy vector (0 0 t)

    [tvr,tvp,tvz] = curl(tr,tp,T,meshr,meshphi,meshz,r,r1,r2,id0,id1);
tic;
if id0~=id1
  for m = id0:id1      %enstrophy
    enstrophy(:,:,:,m-id0+1)  = 0.5*(vtr(:,:,:,m-id0+1).^2 + vtp(:,:,:,m-id0+1).^2 + vtz(:,:,:,m-id0+1).^2);
  end
else
    enstrophy  = 0.5*(vtr.^2 + vtp.^2 + vtz.^2);
end

[Srr,Spp,Szz,Srp,Spz,Szr] = strain(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1); % strain rate tensor

[dur,dup,duz]=deri(U,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of U
[dvr,dvp,dvz]=deri(V,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of V
[dwr,dwp,dwz]=deri(W,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of W

Le=laplaceS(enstrophy,r,r1,r2,meshr,meshphi,meshz,id0,id1); % laplacian of enstrophy

[Lvr,Lvp,Lvz]=laplaceV(vtr,vtp,vtz,r,r1,r2,meshr,meshphi,meshz,id0,id1);  % laplacian of vorticity vector

[dtr,dtp,dtz] = deri(T,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of temperature

[dvtrr,dvtrp,dvtrz]=deri(vtr,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of vtr

[dvtpr,dvtpp,dvtpz]=deri(vtp,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of vtp

[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz]=vgrad(vtr,vtp,vtz,r,r1,r2,meshr,meshphi,meshz,id0,id1); %the gradient of vorticity 
toc;

fprintf('derivative calculation completed...\n');
if id0~= id1
for l = id0:id1
   for k = 1: meshz
       for j = 1: meshphi
           for i = 1:meshr
   
           % generate the local velocity gradient tensor matrix
           % create a cell to restore the matrix in every grid node
%             Gvor(i,j,k) =  {[grr(i,j,k,l-id0+1),grp(i,j,k,l-id0+1),grz(i,j,k,l-id0+1); ...
%                                   gpr(i,j,k,l-id0+1),gpp(i,j,k,l-id0+1),gpz(i,j,k,l-id0+1); ...
%                                   gzr(i,j,k,l-id0+1),gzp(i,j,k,l-id0+1),gzz(i,j,k,l-id0+1)]};  
           % generate the local strain rate tensor matrix             
%             Gstr(i,j,k)   =  {[Srr(i,j,k,l-id0+1),Srp(i,j,k,l-id0+1),Szr(i,j,k,l-id0+1); ...
%                                Srp(i,j,k,l-id0+1),Spp(i,j,k,l-id0+1),Spz(i,j,k,l-id0+1); ...
%                                Szr(i,j,k,l-id0+1),Spz(i,j,k,l-id0+1),Szz(i,j,k,l-id0+1)]}; 
%                            
%             vor(i,j,k) ={ [vtr(i,j,k,l-id0+1); vtp(i,j,k,l-id0+1); vtz(i,j,k,l-id0+1)]};
            
                        
           % laplacian of vorticity vector
           
%             Lvor(i,j,k) = {[Lvr(i,j,k,l-id0+1);Lvp(i,j,k,l-id0+1);Lvz(i,j,k,l-id0+1)]};
%                
%             curl_t(i,j,k) = {[tvr(i,j,k,l-id0+1);tvp(i,j,k,l-id0+1);tvz(i,j,k,l-id0+1)]};
            
            %stretching term
%            stre(i,j,k,l-id0+1) = vor{i,j,k}'*Gstr{i,j,k}*vor{i,j,k};
                     
            stre(i,j,k,l-id0+1) = (vtr(i,j,k,l-id0+1)*Srr(i,j,k,l-id0+1)+vtp(i,j,k,l-id0+1)*Srp(i,j,k,l-id0+1)+vtz(i,j,k,l-id0+1)*Szr(i,j,k,l-id0+1))*vtr(i,j,k,l-id0+1) ...
                                + (vtr(i,j,k,l-id0+1)*Srp(i,j,k,l-id0+1)+vtp(i,j,k,l-id0+1)*Spp(i,j,k,l-id0+1)+vtz(i,j,k,l-id0+1)*Spz(i,j,k,l-id0+1))*vtp(i,j,k,l-id0+1) ...
                                + (vtr(i,j,k,l-id0+1)*Szr(i,j,k,l-id0+1)+vtp(i,j,k,l-id0+1)*Spz(i,j,k,l-id0+1)+vtz(i,j,k,l-id0+1)*Szz(i,j,k,l-id0+1))*vtz(i,j,k,l-id0+1);
            %dissipation term
%             dissi(i,j,k,l-id0+1) = -Gr2*trace(Gvor{i,j,k}*Gvor{i,j,k}');
								
            dissi(i,j,k,l-id0+1) = -Gr2 * (grr(i,j,k,l-id0+1)^2+grp(i,j,k,l-id0+1)^2+grz(i,j,k,l-id0+1)^2 ...
                                        +  gpr(i,j,k,l-id0+1)^2+gpp(i,j,k,l-id0+1)^2+gpz(i,j,k,l-id0+1)^2 ...
                                        +  gzr(i,j,k,l-id0+1)^2+gzp(i,j,k,l-id0+1)^2+gzz(i,j,k,l-id0+1)^2);
            %viscous term = diffusionterm + dissipation term
%             visc(i,j,k,l-id0+1) =  Gr2 * vor{i,j,k}'*Lvor{i,j,k}; 

            visc(i,j,k,l-id0+1) = Gr2  * (vtr(i,j,k,l-id0+1)*Lvr(i,j,k,l-id0+1) ...
                                       +  vtp(i,j,k,l-id0+1)*Lvp(i,j,k,l-id0+1) ...
                                       +  vtz(i,j,k,l-id0+1)*Lvz(i,j,k,l-id0+1));
            
            %buoyancy term
%             buoy(i,j,k,l-id0+1) =  vor{i,j,k}'*curl_t{i,j,k};
            buoy(i,j,k,l-id0+1) = vtr(i,j,k,l-id0+1)*tvr(i,j,k,l-id0+1) ...
                                + vtp(i,j,k,l-id0+1)*tvp(i,j,k,l-id0+1) ...
                                + vtz(i,j,k,l-id0+1)*tvz(i,j,k,l-id0+1);
          
           end
       end
   end
    %diffusion term
      diff(:,:,:,l-id0+1) = Gr2.*Le(:,:,:,l-id0+1);
            
    %rotating term
      rot(:,:,:,l-id0+1) = Ro1.*(duz(:,:,:,l-id0+1).*vtr(:,:,:,l-id0+1) + dvz(:,:,:,l-id0+1).*vtp(:,:,:,l-id0+1) + dwz(:,:,:,l-id0+1).*vtz(:,:,:,l-id0+1));  
   
end  
else
    
    
   for k = 1: meshz
      for j = 1: meshphi
          for i = 1:meshr
           % generate the local vorticity gradient tensor matrix
           % create a cell to restore the matrix in every grid node
            Gvor(i,j,k)   =  {[grr(i,j,k),grp(i,j,k),grz(i,j,k); ...
                               gpr(i,j,k),gpp(i,j,k),gpz(i,j,k); ...
                               gzr(i,j,k),gzp(i,j,k),gzz(i,j,k)]}; 
           % generate the local strain rate tensor matrix             
            Gstr(i,j,k)    =  {[Srr(i,j,k),Srp(i,j,k),Szr(i,j,k); ...
                               Srp(i,j,k),Spp(i,j,k),Spz(i,j,k); ...
                               Szr(i,j,k),Spz(i,j,k),Szz(i,j,k)]}; 
              
           % vorticity vector                
            vor(i,j,k) = {[vtr(i,j,k); vtp(i,j,k); vtz(i,j,k)]}; 
            
           % laplacian of vorticity vector
           
            Lvor(i,j,k) = {[Lvr(i,j,k);Lvp(i,j,k);Lvz(i,j,k)]};
               
            curl_t(i,j,k) = {[tvr(i,j,k);tvp(i,j,k);tvz(i,j,k)]};
         end
      end
   end
            
end

tic;
if id0~=id1
else
  
    for k = 1: meshz 
        for j = 1 : meshphi
            for i =1 : meshr
                  %stretching term
                  stre(i,j,k) = vor{i,j,k}'*Gstr{i,j,k}*vor{i,j,k};
                  
                  %dissipation term
                  dissi(i,j,k) = -Gr2*trace(Gvor{i,j,k}*Gvor{i,j,k}');
                  
                   %viscous term = diffusionterm + dissipation term
                   
                  visc(i,j,k) = Gr2 * vor{i,j,k}'*Lvor{i,j,k}; 
                  
                  %buoyancy term
                  
                  buoy(i,j,k) = vor{i,j,k}'*curl_t{i,j,k};
            end
        end
    end
        
                     
            %diffusion term
            diff = Gr2*Le;
          
            
            %rotating term
            
            rot = Ro1*(duz.*vtr + dvz.*vtp + dwz.*vtz);
    
end

toc;

fprintf('enstrophy budget calculation completed...\n');
end
