function [time,istep] = readstep(fnameh,id0,id1)
% read the run time and time step from .fxxxxx files
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

%--------------------------------------------------------------------------
%  OPEN THE FILE
%--------------------------------------------------------------------------
parfor i = id0:id1
    
emode = 'le';

infile(i) = fopen(fname(i).name,'r',['ieee-' emode]);

% read header
header = fread(infile(i),132,'*char')';
%
% check endian
etag = round(fread(infile(i),1,'*float32')*1e5);

etag = etag * 1e-5;

%--------------------------------------------------------------------------
% READ DATA
%--------------------------------------------------------------------------
%

% time
time(i) = str2double(header(39:58));
%
% istep
istep(i) = str2double(header(60:68));
%
end
end