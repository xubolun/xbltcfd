function[]=PoutputTec(meshr,meshphi,meshz,Xm,Ym,Zm,a,b,c,d,fnameh,id0,id1)
% dump the temporal seires of flow fields into tec files in parallel
for i = id0:id1
    
fname(i).name = sprintf('%s%s%d%s','results/',fnameh,i,'.dat');

end
tic;
parfor i = id0:id1
    
    
    
    h(i) = fopen(fname(i).name, 'w');
    
    outputTec(h(i),fname(i).name,meshr,meshphi,meshz,Xm(:,:,:,i),Ym(:,:,:,i),Zm(:,:,:,i),a(:,:,:,i),b(:,:,:,i),c(:,:,:,i),d(:,:,:,i));
    
end
toc;
close all;
end