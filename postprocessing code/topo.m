function[inv1,inv2,inv3] = topo(u,v,w,r,r1,r2,meshr,meshphi,meshz)
% calculate three invariants of the velocity gradient tensor
inv1=[];
inv2=[];
inv3=[];
% velocity gradient tensor

[dur,duphi,duz] = deri(u,r,r1,r2,meshr,meshphi,meshz);
[dvr,dvphi,dvz] = deri(v,r,r1,r2,meshr,meshphi,meshz);
[dwr,dwphi,dwz] = deri(w,r,r1,r2,meshr,meshphi,meshz);

for i = 1:meshr
    for j = 1:meshphi
        for k = 1:meshz
           % generate the local velocity gradient tensor matrix
            G = [dur(i,j,k),dvr(i,j,k),dwr(i,j,k); ...
              1/r(i)*duphi(i,j,k),1/r(i)*dvphi(i,j,k),1/r(i)*dwphi(i,j,k); ...
              duz(i,j,k),dvz(i,j,k),dwz(i,j,k)]; 
          
           % the first invariant : - tr(grad U) = - div U
            inv1(i,j,k) = -trace(G);
            
           % the second invariant : -1/2* tr((grad U)^2)
            inv2(i,j,k) = -1/2 * trace (G^2);
            
           % the third invariant : -det (grad U) = -1/3 * tr((grad U)^3)
            inv3(i,j,k) = -det(G);
        end
    end
end

end