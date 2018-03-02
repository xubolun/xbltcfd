function[U_aver,V_aver,W_aver,T_aver]=phiaver(U,V,W,T,meshr,meshphi,meshz)
U_aver=[];
V_aver=[];
W_aver=[];
T_aver=[];
%------------------------------------------
% calculate azimuthal average of flow field
for i=1:meshr
    for k=1:meshz
        U_aver(i,k)=0;
        V_aver(i,k)=0;
        W_aver(i,k)=0;
        T_aver(i,k)=0;
        for j=1:meshphi
           U_aver(i,k)=U_aver(i,k)+U(i,j,k);
           V_aver(i,k)=V_aver(i,k)+V(i,j,k);
           W_aver(i,k)=W_aver(i,k)+W(i,j,k);
           T_aver(i,k)=T_aver(i,k)+T(i,j,k);
        end
        U_aver(i,k)=U_aver(i,k)/j;
        V_aver(i,k)=V_aver(i,k)/j;
        W_aver(i,k)=W_aver(i,k)/j;
        T_aver(i,k)=T_aver(i,k)/j;
    end
end

end
