function[] = exctA(fnameh,otname,id0,id1,istp)
%-------------------------------------------------------------------------%
% Execute the whole process from reading a group of fields to calculating %
% the averaged fields, in parallel partially.                             %
%                                                                         %
% Assumimg that we have 'x' flow fields, 'x' is so large that we may meet %
% 'out of memory' error if runing the process in whole from '1' to 'x'.   %
% So we run the process from '1' to 'x/n' firstly, then clear the cache to% 
% assure enough instant memory, and then do 'x/n +1' to '2x/n', etc.      %
%                                                                         %
% input: id0 & id1 ----  start & end of field files                       %
%        istp      ----  files executed in every outside loop             %
%                                                                         %
% output:   time/volume-averaged fields (dump in data files)              %
%                                                                         %
%-------------------------------------------------------------------------%
fstart = id0;
fend = istp;
n = 0;
% preset flow field
[datax,datay,dataz,meshr,meshphi,meshz,nel,np,Ra,Pr,Gr2,Ro1,r1,r2] = preset(otname);

% if mod(fend,4*istp) == 0
if (mod(fend,istp) == 0) && (id0 ~=1)  
      
    
    h1 = fopen('results/val_tot.dat','rt');
    
    [tot,count] = fscanf(h1,'%f%f%f%f%f%f ',6);
    
    stre_avg_tot = tot(1);      
    diff_avg_tot = tot(2); 
    dissi_avg_tot = tot(3);
    visc_avg_tot = tot(4);
    buoy_avg_tot = tot(5);
    rot_avg_tot = tot(6) ;
    disp(tot);
    
    pack;
    
    fprintf('reading temporal integration from .dat file completed...\n');
end

if id0 == 1
    
    stre_tot(1:meshr,1:meshphi,1:meshz) = 0;
    diff_tot(1:meshr,1:meshphi,1:meshz) = 0;
    dissi_tot(1:meshr,1:meshphi,1:meshz) = 0;
    visc_tot(1:meshr,1:meshphi,1:meshz) = 0;
    buoy_tot(1:meshr,1:meshphi,1:meshz) = 0;
    rot_tot(1:meshr,1:meshphi,1:meshz) = 0;

    stre_avg_tot = 0;
    diff_avg_tot = 0;
    dissi_avg_tot = 0;
    visc_avg_tot = 0;
    buoy_avg_tot = 0;
    rot_avg_tot = 0;
    

end    
while (fend <= id1)
  
n = n + 1;
% read files 

[datau,datav,dataw,datat,time0] = serialread(fnameh,fstart,fend,nel,np,otname);

fprintf('field data reading completed...\n');

% interpolate flow fields 
tic;
[flow,ord,r,phi,z] = serialintp(r1,r2,meshr,meshphi,meshz,datax,datay,dataz,datau,datav,dataw,datat,1,istp);
toc;

% dump data in 'flow' structure into 4-D matices
[U,V,W,T] = getStrData(flow,1,istp);
fprintf('field data interpolation completed...\n');
clear flow; % release instant memory!

% calculate vorticity field
[vtr,vtp,vtz]=curl(U,V,W,meshr,meshphi,meshz,r,r1,r2,1,istp);
fprintf('vorticity field calculation completed...\n');

% calculate enstrophy budget
[enstrophy,stre,diff,dissi,visc,buoy,rot] = enstro(meshr,meshphi,meshz,r,r1,r2,U,V,W,vtr,vtp,vtz,T,Gr2,Ro1,1,istp);

% calculate the volume-average of a certain field
[stre_intg,stre_avg]=glsc3(stre,r,r1,r2,meshr,meshphi,meshz,1,istp);
[diff_intg,diff_avg]=glsc3(diff,r,r1,r2,meshr,meshphi,meshz,1,istp);
[dissi_intg,dissi_avg]=glsc3(dissi,r,r1,r2,meshr,meshphi,meshz,1,istp);
[visc_intg,visc_avg]=glsc3(visc,r,r1,r2,meshr,meshphi,meshz,1,istp);
[buoy_intg,buoy_avg]=glsc3(buoy,r,r1,r2,meshr,meshphi,meshz,1,istp);
[rot_intg,rot_avg]=glsc3(rot,r,r1,r2,meshr,meshphi,meshz,1,istp);
clear U V W T vtr vtp vtz enstrophy stre diff dissi visc buoy rot; % release instant memory!
fprintf('volume-average field calculation completed...\n');
% calculate temporal integration of a certain field or a volume-averaged field, as a preparation for
% time-average
disp(['fstart = ',num2str(fstart)]);
disp(['fend = ',num2str(fend)]);
parfor l = fstart:fend-1

      stre_avg_tot = stre_avg_tot + 1/2*( stre_avg(l-(n-1)*istp) + stre_avg(l+1-(n-1)*istp) ).* (time0(l+1) - time0(l));
      
      diff_avg_tot = diff_avg_tot + 1/2*( diff_avg(l-(n-1)*istp) + diff_avg(l+1-(n-1)*istp) ).* (time0(l+1) - time0(l));
      
      dissi_avg_tot = dissi_avg_tot + 1/2*( dissi_avg(l-(n-1)*istp) + dissi_avg(l+1-(n-1)*istp) ).* (time0(l+1) - time0(l));
      
      visc_avg_tot = visc_avg_tot + 1/2*( visc_avg(l-(n-1)*istp) + visc_avg(l+1-(n-1)*istp) ).*(time0(l+1) - time0(l));
      
      buoy_avg_tot = buoy_avg_tot + 1/2*( buoy_avg(l-(n-1)*istp) + buoy_avg(l+1-(n-1)*istp) ).*(time0(l+1) - time0(l));
      
      rot_avg_tot = rot_avg_tot + 1/2*( rot_avg(l-(n-1)*istp) + rot_avg(l+1-(n-1)*istp) ).*(time0(l+1) - time0(l));
      
end

h1 = fopen('results/val_tot.dat','wt');
fprintf(h1,'%.8f %.8f %.8f %.8f %.8f %.8f\n',stre_avg_tot,diff_avg_tot,dissi_avg_tot,visc_avg_tot,buoy_avg_tot,rot_avg_tot);
clc;

disp([num2str(fend),' flow files have been executed...']);

fstart = fend + 1;
fend = fend + istp;
% cache cleared automatically

end

fprintf('temporal integration completed...\n');

stre_VTaver = stre_avg_tot/(time0(id1) - time0(id0));
diff_VTaver = diff_avg_tot/(time0(id1) - time0(id0));
dissi_VTaver = dissi_avg_tot/(time0(id1) - time0(id0));
visc_VTaver = visc_avg_tot/(time0(id1) - time0(id0));
buoy_VTaver = buoy_avg_tot/(time0(id1) - time0(id0));
rot_VTaver = rot_avg_tot/(time0(id1) - time0(id0));

h2 = fopen('results/val_aver.dat','a');
fprintf(h2,'%.8f %.8f %.8f %.8f %.8f %.8f\n',stre_VTaver,diff_VTaver,dissi_VTaver,visc_VTaver,buoy_VTaver,rot_VTaver);
fprintf('temporal average completed...\n');
clear all;
end