function[enstrophy,stre,diff,dissi,visc,buoy,rot]=enstro(meshr,meshphi,meshz,r,r1,r2,u,v,w,vort,T,Gr2,Ro1)

meshr1 = meshr - 1;
meshz1 = meshz - 1;
stre = [];
diff = [];
dissi = [];
visc=[];
buoy = [];
rot = [];

[Srr,Spp,Szz,Srp,Spz,Szr]=strain(u,v,w,r,r1,r2,meshr,meshphi,meshz);
vortr(:,:,:) = vort(:,:,:,1);
vortp(:,:,:) = vort(:,:,:,2);
vortz(:,:,:) = vort(:,:,:,3);
for i = 1:meshr
    for j = 1:meshphi
        for k = 1:meshz
             %enstrophy
            enstrophy (i,j,k) = 0.5*(vort(i,j,k,1)+vort(i,j,k,2)+vort(i,j,k,3));
        end
    end
end

[der,dep,dez]=deri(enstrophy,r,r1,r2,meshr,meshphi,meshz);
[dur,dup,duz]=deri(u,r,r1,r2,meshr,meshphi,meshz);
[dvr,dvp,dvz]=deri(v,r,r1,r2,meshr,meshphi,meshz);
[dwr,dwp,dwz]=deri(w,r,r1,r2,meshr,meshphi,meshz);
[dvrr,dvrp,dvrz]=deri(vortr,r,r1,r2,meshr,meshphi,meshz);
[dvpr,dvpp,dvpz]=deri(vortp,r,r1,r2,meshr,meshphi,meshz);
[dvzr,dvzp,dvzz]=deri(vortz,r,r1,r2,meshr,meshphi,meshz);
[dtr,dtp,dtz] = deri(T,r,r1,r2,meshr,meshphi,meshz);
[dder,ddep,ddez] = deri2(enstrophy,r,r1,r2,meshr,meshphi,meshz);
[ddvrr,ddvrp,ddvrz] = deri2(vortr,r,r1,r2,meshr,meshphi,meshz);
[ddvpr,ddvpp,ddvpz] = deri2(vortp,r,r1,r2,meshr,meshphi,meshz);
[ddvzr,ddvzp,ddvzz] = deri2(vortz,r,r1,r2,meshr,meshphi,meshz);
for i = 1:meshr
    for j =1: meshphi
        for k = 1: meshz
           
            %stretching term
            stre(i,j,k) = vort(i,j,k,1)*(vort(i,j,k,1)*Srr(i,j,k)+vort(i,j,k,2)*Srp(i,j,k)+vort(i,j,k,3)*Szr(i,j,k)) ...
                        + vort(i,j,k,2)*(vort(i,j,k,1)*Srp(i,j,k)+vort(i,j,k,2)*Spp(i,j,k)+vort(i,j,k,3)*Spz(i,j,k)) ...
                        + vort(i,j,k,3)*(vort(i,j,k,1)*Szr(i,j,k)+vort(i,j,k,2)*Spz(i,j,k)+vort(i,j,k,3)*Szz(i,j,k));
            %diffusion term
            diff(i,j,k) = Gr2*(1/r(i)*der(i,j,k) + dder(i,j,k) + 1/r(i)^2*ddep(i,j,k)+ddez(i,j,k));
            %dissipation term
            dissi(i,j,k) = -Gr2*(dvrr(i,j,k)^2 + dvpr(i,j,k)^2 + dvzr(i,j,k)^2 ...
                         + (1/r(i)*dvrp(i,j,k))^2 + (1/r(i)*dvpp(i,j,k))^2 + (1/r(i)*dvzp(i,j,k))^2 ...
                         + dvrz(i,j,k)^2 + dvpz(i,j,k)^2 + dvzz(i,j,k)^2);
            %viscous term = diffusionterm + dissipation term
            visc(i,j,k) = Gr2 * (vortr(i,j,k)*(ddvrr(i,j,k) + 1/r(i)^2*ddvrp(i,j,k) + ddvrz(i,j,k)) ...
                              +  vortp(i,j,k)*(ddvpr(i,j,k) + 1/r(i)^2*ddvpp(i,j,k) + ddvpz(i,j,k)) ...
                              +  vortz(i,j,k)*(ddvzr(i,j,k) + 1/r(i)^2*ddvzp(i,j,k) + ddvzz(i,j,k)) );
            %buoyancy term
            buoy(i,j,k) = 1/r(i)*dtp(i,j,k)*vortr(i,j,k) + (-dtr(i,j,k))*vortp(i,j,k);
            %rotating term
            rot(i,j,k) = Ro1*(duz(i,j,k)*vortr(i,j,k) + dvz(i,j,k)*vortp(i,j,k) + dwz(i,j,k)*vortz(i,j,k));
            
        end
    end
end

end