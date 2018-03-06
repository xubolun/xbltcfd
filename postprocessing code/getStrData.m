function [U,V,W,T] = getStrData(a,id1)
%get the matrices in a structure type data

name = fieldnames(a(1)); %get the names of variables in structure data "a", the names are the same for all "a" members 

[lid st] = size(name);

Vname = {};

strtname = char(who('a'));

for i = 1:id1
    
    for p = 1:lid
    
        nstr = char(name(p));
        
        if p == 1
                    
            Vname(i).name1 = sprintf('%s%s%d%s%s%s',strtname,'(', i,')', '.', nstr);
            
        elseif p == 2
            
            Vname(i).name2 = sprintf('%s%s%d%s%s%s',strtname,'(', i,')', '.', nstr);
            
        elseif p == 3
            
            Vname(i).name3 = sprintf('%s%s%d%s%s%s',strtname,'(', i,')', '.', nstr);
            
        elseif p == 4
            
            Vname(i).name4 = sprintf('%s%s%d%s%s%s',strtname,'(', i,')', '.', nstr);
            
        end
  
    end
    
    U(i).val = eval([Vname(i).name1]);
    
    V(i).val = eval([Vname(i).name2]);
    
    if lid == 3  % if 2D
        
        T(i).val = eval([Vname(i).name3]);
        
    elseif lid == 4 %if 3D
        
        W(i).val = eval([Vname(i).name3]);
        
        T(i).val = eval([Vname(i).name4]);
        
    end
    
end


end