function[inv1,inv2,inv3] = topo(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1)
% calculate three invariants of the velocity gradient tensor in parallel
inv1=[];
inv2=[];
inv3=[];
% velocity gradient tensor in cylindrical coordinate

[gur,gup,guz] = grad(u,r,r1,r2,meshr,meshphi,meshz,id0,id1);
[gvr,gvp,gvz] = grad(v,r,r1,r2,meshr,meshphi,meshz,id0,id1);
[gwr,gwp,gwz] = grad(w,r,r1,r2,meshr,meshphi,meshz,id0,id1);
tic;
for l = id0:id1
   for k = 1: meshz
       for j = 1: meshphi
           for i = 1:meshr
   
           % generate the local velocity gradient tensor matrix
           % create a cell to restore the matrix in every grid node
            G(i,j,k,l) =  {[gur(i,j,k,l),gvr(i,j,k,l),gwr(i,j,k,l); ...
                            gup(i,j,k,l),gvp(i,j,k,l),gwp(i,j,k,l); ...
                            guz(i,j,k,l),gvz(i,j,k,l),gwz(i,j,k,l)]};  
          
           end
       end
   end
end  

parfor l = id0:id1
    for k = 1 :meshz
        for j = 1: meshphi
            for i =1 : meshr

           % the first invariant : - tr(grad U) = - div U
           
             inv1(i,j,k,l) = -trace(G{i,j,k,l});
             
           % the second invariant : -1/2* tr((grad U)^2)  
              
             inv2(i,j,k,l) = -1/2 * trace (G{i,j,k,l}^2);
             
           % the third invariant : -det (grad U) = -1/3 * tr((grad U)^3) 
             
             inv3(i,j,k,l) = -det(G{i,j,k,l});
           
           end
       end
    end
end
toc;
end