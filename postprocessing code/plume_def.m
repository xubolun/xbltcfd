function[plume_area,m]=plume_def(rapr,Nu,c,W,T,T_rms,meshr,meshphi,meshz,Zm,z0,r,r1,r2)

plume_area=zeros(meshr,meshphi);

T_plane = [];

W_plane = [];

[T_plane_aver,T_plane,K] = z_plane_aver(T,meshr,meshphi,meshz,Zm,z0,r,r1,r2);

[W_plane_aver,W_plane,K] = z_plane_aver(W,meshr,meshphi,meshz,Zm,z0,r,r1,r2);

[T_rms_plane_aver,T_rms_plane,K] = z_plane_aver(T_rms,meshr,meshphi,meshz,Zm,z0,r,r1,r2);
% define plume area, where T(r,phi)-<T>_r,phi > c*T_rms and
% sqrt(ra*pr)W(r,phi) * T(r,phi) >c*Nu
m = 0;
for i =1:meshr
    for j =1:meshphi
        cri1 = T_plane(i,j)-T_plane_aver;
        cri2 = rapr* W_plane(i,j)* T_plane(i,j);
        rhs1 = c * T_rms_plane_aver;
        rhs2 = c * Nu;
        fprintf('cri1=%f\n cr2=%f\n rhs1=%f\n rhs2=%f\n',cri1,cri2,rhs1,rhs2);
        if (cri1 > rhs1 ) & ( cri2 > rhs2 )
            m = m + 1;
            plume_area(i,j) =1;
%             plume_x(i,j,m) = Xm(i,j,K);
%             plume_y(i,j,m) = Ym(i,j,K);
        else
            plume_area(i,j) =0;
        end
    end
end     

end