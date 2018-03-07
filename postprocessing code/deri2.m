function[ddar,ddap,ddaz]=deri2(a,r1,r2,meshr,meshphi,meshz,id0,id1)
%calculate the 2nd order spacial derivative in cynlindrical coordinate in
%parallel

meshr1 = meshr - 1;
meshz1 = meshz - 1;

[dar,daphi,daz] = deri(a,r1,r2,meshr,meshphi,meshz,id0,id1); % 1st order derivative

[ddar,ddarp,ddarz] = deri(dar,r1,r2,meshr,meshphi,meshz,id0,id1);
[ddapr,ddap,ddapz] = deri(daphi,r1,r2,meshr,meshphi,meshz,id0,id1);
[ddazr,ddazp,ddaz] = deri(daz,r1,r2,meshr,meshphi,meshz,id0,id1);

end