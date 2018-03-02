function[datax0,datay0,dataz0,datau0,datav0,dataw0,datat0] = serialread(fnamehead,id0,id1)

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
tic;
  parfor i=id0:id1
    if(i<10)
        fname = sprintf('%s%s%s%d','fields/',fnamehead,'0.f0000',i);
    elseif(i<100)
        fname =sprintf('%s%s%s%d','fields/',fnamehead,'0.f000',i);
    elseif(i<1000)
        fname =sprintf('%s%s%s%d','fields/',fnamehead,'0.f00',i);
    elseif(i<10000)
        fname =sprintf('%s%s%s%d','fields/',fnamehead,'0.f0',i);
    else
        fname =sprintf('%s%s%s%d','fields/',fnamehead,'0.f',i);
    end
    [time,istep,nel,N,data,datax,datay,dataz,datau,datav,dataw,datat] = readnek(fname);
%     if(~isempty(datax))
%         datax0(:,:) = datax(:,:);
%         datay0(:,:) = datay(:,:);
%         dataz0(:,:) = dataz(:,:);
%     end
    
%     time0(i) = time;
%     istep0(i) = istep;
    datau0(:,:,i) = datau(:,:);
    datav0(:,:,i) = datav(:,:);
    dataw0(:,:,i) = dataw(:,:);
    datat0(:,:,i) = datat(:,:);
end
toc;
end
