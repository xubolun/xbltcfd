function[datau0,datav0,dataw0,datat0,time0] = serialread(fnameh,id0,id1,nel,np,otname)

%read group of .fxxxx files by loop (from f%id0 ~ f%id1)

time0 = [];
istep0 = [];
datax0 = [];
datay0 = [];
dataz0 = [];
len = id1-id0+1;

datau0 = zeros(nel,np,len);
datav0 = zeros(nel,np,len);
dataw0 = zeros(nel,np,len);
datat0 = zeros(nel,np,len);

for i = id0:id1
    
    if(i<10)
        fname(i).name = sprintf('%s%s%s%d','fields/',fnameh,'0.f0000',i);
    elseif(i<100)
        fname(i).name = sprintf('%s%s%s%d','fields/',fnameh,'0.f000',i);
    elseif(i<1000)
        fname(i).name = sprintf('%s%s%s%d','fields/',fnameh,'0.f00',i);
    elseif(i<10000)
        fname(i).name = sprintf('%s%s%s%d','fields/',fnameh,'0.f0',i);
    else
        fname(i).name = sprintf('%s%s%s%d','fields/',fnameh,'0.f',i);
    end

end

%read the first file to dump the geometrical data (make sure there are mesh data in this file)
tic; 
if id0 == 1

    for i=id0:id1 % cannot use parfor here for function 'importdata' 
   
    [time,istep,nel,N,outnameu,outnamev,outnamew,outnamet] = readnek(fname(i).name,otname);

    datau0(:,:,i) = importdata(outnameu);
    datav0(:,:,i) = importdata(outnamev);
    dataw0(:,:,i) = importdata(outnamew);
    datat0(:,:,i) = importdata(outnamet);
    time0(i) = time;
    istep0(i) = istep;
  
    end
else
    for i=id0:id1 % cannot use parfor here for function 'importdata' and variable idex 'i-id0+1' 
   
    [time,istep,nel,N,outnameu,outnamev,outnamew,outnamet] = readnek(fname(i).name,otname);

    datau0(:,:,i-id0+1) = importdata(outnameu);
    datav0(:,:,i-id0+1) = importdata(outnamev);
    dataw0(:,:,i-id0+1) = importdata(outnamew);
    datat0(:,:,i-id0+1) = importdata(outnamet);
    time0(i) = time;
    istep0(i) = istep;
    end
   
end 

fprintf('serial reading completed....\n');
toc;
end
