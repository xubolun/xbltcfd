function[U_aver]=phiaverS(U,meshr,meshphi,meshz)
U_aver=[];

%------------------------------------------
% calculate azimuthal average of one property in flow field
for i=1:meshr
    for k=1:meshz
        U_aver(i,k)=0;

        for j=1:meshphi
           U_aver(i,k)=U_aver(i,k)+U(i,j,k);
    
        end
        U_aver(i,k)=U_aver(i,k)/j;

    end
end

end
