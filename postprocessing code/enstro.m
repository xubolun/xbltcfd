function[enstrophy,stre,diff,dissi,visc,buoy,rot]=enstro(meshr,meshphi,meshz,r,r1,r2,U,V,W,vtr,vtp,vtz,T,Gr2,Ro1,id0,id1)
%calculate the enstrophy and budgets of enstrophy transport equation in
%parallel, Gr2 = sqrt(1/Gr), 1/Gr = Pr/Ra, Ro1 = 1/Ro
stre = [];
diff = [];
dissi = [];
visc=[];
buoy = [];
rot = [];
tic;
parfor l = id0:id1     
    %enstrophy
    enstrophy(:,:,:,l)  = 0.5*(vtr(:,:,:,l).^2 + vtp(:,:,:,l).^2 + vtz(:,:,:,l).^2);
end

[Srr,Spp,Szz,Srp,Spz,Szr] = strain(U,V,W,r,r1,r2,meshr,meshphi,meshz,id0,id1); % strain rate tensor

[der,dep,dez] = deri(enstrophy,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of enstrophy

[dur,dup,duz]=deri(U,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of U
[dvr,dvp,dvz]=deri(V,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of V
[dwr,dwp,dwz]=deri(W,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of W

[dvrr,dvrp,dvrz]=deri(vtr,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of r- vorticity
[dvpr,dvpp,dvpz]=deri(vtp,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of phi- vorticity
[dvzr,dvzp,dvzz]=deri(vtz,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of z- vorticity

[dtr,dtp,dtz] = deri(T,r1,r2,meshr,meshphi,meshz,id0,id1); % derivative of temperature

[dder,ddep,ddez] = deri2(enstrophy,r1,r2,meshr,meshphi,meshz,id0,id1); % 2nd order derivative of enstrophy

[ddvrr,ddvrp,ddvrz] = deri2(vtr,r1,r2,meshr,meshphi,meshz,id0,id1); % 2nd order derivative of r- vorticity
[ddvpr,ddvpp,ddvpz] = deri2(vtp,r1,r2,meshr,meshphi,meshz,id0,id1); % 2nd order derivative of phi- vorticity
[ddvzr,ddvzp,ddvzz] = deri2(vtz,r1,r2,meshr,meshphi,meshz,id0,id1); % 2nd order derivative of z- vorticity

for l = id0:id1
    
     for i = 1:meshr
 
           
            %stretching term
            stre(i,:,:,l) = vtr(i,:,:,l).*(vtr(i,:,:,l).*Srr(i,:,:,l)+vtp(i,:,:,l).*Srp(i,:,:,l)+vtz(i,:,:,l).*Szr(i,:,:,l)) ...
                          + vtp(i,:,:,l).*(vtr(i,:,:,l).*Srp(i,:,:,l)+vtp(i,:,:,l).*Spp(i,:,:,l)+vtz(i,:,:,l).*Spz(i,:,:,l)) ...
                          + vtz(i,:,:,l).*(vtr(i,:,:,l).*Szr(i,:,:,l)+vtp(i,:,:,l).*Spz(i,:,:,l)+vtz(i,:,:,l).*Szz(i,:,:,l));
                     
            %diffusion term
            diff(i,:,:,l) = Gr2*(1/r(i)*der(i,:,:,l) + dder(i,:,:,l) + 1/r(i)^2*ddep(i,:,:,l)+ddez(i,:,:,l));
            
            %dissipation term
            dissi(i,:,:,l) = -Gr2*(dvrr(i,:,:,l).^2 + dvpr(i,:,:,l).^2 + dvzr(i,:,:,l).^2 ...
                                + (1/r(i)*dvrp(i,:,:,l)).^2 + (1/r(i)*dvpp(i,:,:,l)).^2 + (1/r(i)*dvzp(i,:,:,l)).^2 ...
                                + dvrz(i,:,:,l).^2 + dvpz(i,:,:,l).^2 + dvzz(i,:,:,l).^2);
                     
            %viscous term = diffusionterm + dissipation term
            visc(i,:,:,l) = Gr2 * (vtr(i,:,:,l).*(ddvrr(i,:,:,l) + 1/r(i)^2*ddvrp(i,:,:,l) + ddvrz(i,:,:,l)) ...
                                +  vtp(i,:,:,l).*(ddvpr(i,:,:,l) + 1/r(i)^2*ddvpp(i,:,:,l) + ddvpz(i,:,:,l)) ...
                                +  vtz(i,:,:,l).*(ddvzr(i,:,:,l) + 1/r(i)^2*ddvzp(i,:,:,l) + ddvzz(i,:,:,l)) );
                          
            %buoyancy term
            buoy(i,:,:,l) = 1/r(i)*dtp(i,:,:,l).*vtr(i,:,:,l) + (-dtr(i,:,:,l)).*vtp(i,:,:,l);
            
            %rotating term
            rot(i,:,:,l) = Ro1*(duz(i,:,:,l).*vtr(i,:,:,l) + dvz(i,:,:,l).*vtp(i,:,:,l) + dwz(i,:,:,l).*vtz(i,:,:,l));
            
     end

end
toc;
end