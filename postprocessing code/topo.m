function[inv1,inv2,inv3] = topo(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1)
% calculate three invariants of the velocity gradient tensor 
len = id1 - id0 +1;
inv1=zeros(meshr,meshphi,meshz,len);
inv2=zeros(meshr,meshphi,meshz,len);
inv3=zeros(meshr,meshphi,meshz,len);
% velocity gradient tensor in cylindrical coordinate

[grr,grp,grz,gpr,gpp,gpz,gzr,gzp,gzz]=vgrad(u,v,w,r,r1,r2,meshr,meshphi,meshz,id0,id1);
tic;
for l = id0:id1
   for k = 1: meshz
       for j = 1: meshphi
           for i = 1:meshr
   
           % generate the local velocity gradient tensor matrix
           % create a cell to restore the matrix in every grid node
            G(i,j,k,l-id0+1) =  {[grr(i,j,k,l-id0+1),grp(i,j,k,l-id0+1),grz(i,j,k,l-id0+1); ...
                                  gpr(i,j,k,l-id0+1),gpp(i,j,k,l-id0+1),gpz(i,j,k,l-id0+1); ...
                                  gzr(i,j,k,l-id0+1),gzp(i,j,k,l-id0+1),gzz(i,j,k,l-id0+1)]};  
          
           end
       end
   end
end  

for l = id0:id1
    for k = 1 :meshz
        for j = 1: meshphi
            for i =1 : meshr

           % the first invariant : - tr(grad U) = - div U
           
             inv1(i,j,k,l-id0+1) = -trace(G{i,j,k,l-id0+1});
             
           % the second invariant : -1/2* tr((grad U)^2)  
              
             inv2(i,j,k,l-id0+1) = -1/2 * trace (G{i,j,k,l-id0+1}^2);
             
           % the third invariant : -det (grad U) = -1/3 * tr((grad U)^3) 
             
             inv3(i,j,k,l-id0+1) = -det(G{i,j,k,l-id0+1});
           
           end
       end
    end
end
toc;
end