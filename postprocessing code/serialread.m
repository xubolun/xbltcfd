function[datax0,datay0,dataz0,datau0,datav0,dataw0,datat0,time0,istep0] = serialread(fnameh,id0,id1)

%read group of .fxxxx files by loop (from f%id0 ~ f%id1)

time0 = [];
istep0 = [];
data0 = [];
datax0 = [];
datay0 = [];
dataz0 = [];
datau0 = [];
datav0 = [];
dataw0 = [];
datat0 = [];

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

[time,istep,nel,N,data,datax,datay,dataz,datau,datav,dataw,datat] = readnek(fname(id0).name);

datau0(:,:,id0) = datau(:,:);
datav0(:,:,id0) = datav(:,:);
dataw0(:,:,id0) = dataw(:,:);
datat0(:,:,id0) = datat(:,:);
time0(id0) = time;
istep0(id0) = istep;

for i = id0:id1
    
datax0(:,:,i) = datax(:,:);
datay0(:,:,i) = datay(:,:);
dataz0(:,:,i) = dataz(:,:);

end

tic; 

parfor i=(id0+1):id1
   
    [time,istep,nel,N,data,datax,datay,dataz,datau,datav,dataw,datat] = readnek(fname(i).name);

    datau0(:,:,i) = datau(:,:);
    datav0(:,:,i) = datav(:,:);
    dataw0(:,:,i) = dataw(:,:);
    datat0(:,:,i) = datat(:,:);
    time0(i) = time;
    istep0(i) = istep;
  
end
toc;
end
