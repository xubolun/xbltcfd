function[] = exctA1(fnameh,otname,n)

[datax,datay,dataz,meshr,meshphi,meshz,nel,np,Ra,Pr,Gr2,Ro1,r1,r2] = preset(otname);

[datau0,datav0,dataw0,datat0,time0] = serialread(fnameh,n,n,nel,np,otname);


[U,V,W,T,Xm,Ym,Zm,r] = intpnek(datax,datay,dataz,datau0,datav0,dataw0,datat0,r1,r2,meshr,meshphi,meshz);

fprintf('field data interpolation completed...\n');

[vtr,vtp,vtz]=curl(U,V,W,meshr,meshphi,meshz,r,r1,r2,n,n);

fprintf('vorticity field calculation completed...\n');

% calculate enstrophy budget
[enstrophy,stre,diff,dissi,visc,buoy,rot] = enstro(meshr,meshphi,meshz,r,r1,r2,U,V,W,vtr,vtp,vtz,T,Gr2,Ro1,n,n);

% calculate the volume-average of a certain field
[stre_intg,stre_avg] = glsc3(stre,r,r1,r2,meshr,meshphi,meshz,n,n);
[diff_intg,diff_avg] = glsc3(diff,r,r1,r2,meshr,meshphi,meshz,n,n);
[dissi_intg,dissi_avg] = glsc3(dissi,r,r1,r2,meshr,meshphi,meshz,n,n);
[visc_intg,visc_avg] = glsc3(visc,r,r1,r2,meshr,meshphi,meshz,n,n);
[buoy_intg,buoy_avg] = glsc3(buoy,r,r1,r2,meshr,meshphi,meshz,n,n);
[rot_intg,rot_avg] = glsc3(rot,r,r1,r2,meshr,meshphi,meshz,n,n);
clear U V W T vtr vtp vtz enstrophy stre diff dissi visc buoy rot; % release instant memory!
fprintf('volume-average field calculation completed...\n');

h1 = fopen('results/volAV.dat','a');
fprintf(h1,'%.8f  %.8f  %.8f  %.8f  %.8f   %.8f  %d\n', stre_avg, diff_avg ,dissi_avg, visc_avg, buoy_avg, rot_avg, n);
fprintf('data saving completed...\n');
end
