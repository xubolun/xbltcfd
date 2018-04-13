function [A] = getStr1Data(a,id0,id1)

%------------------------------------------------------------------------------%
%
%get the matrices in a structure type data, while there is only ONE
%
%variable in this structre
%
%------------------------------------------------------------------------------%
name = fieldnames(a); %get the names of variables in structure data "a" 

Vname = {};

strtname = char(who('a'));

for i = id0:id1


nstr = char(name);
        
Vname(i).name = sprintf('%s%s%d%s%s%s',strtname,'(', i,')', '.', nstr);
            
A(:,:,:,i) = eval([Vname(i).name]);
    
end

end