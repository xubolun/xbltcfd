function[ddar,ddaphi,ddaz]=deri2(a,r,r1,r2,meshr,meshphi,meshz)
%calculate the 2nd order spacial derivative in cynlindrical coordinate
meshr1 = meshr -1;
meshz1 = meshz -1;

[dar,daphi,daz] = deri(a,r,r1,r2,meshr,meshphi,meshz);
[ddar,ddarphi,ddarz] = deri(dar,r,r1,r2,meshr,meshphi,meshz);
[ddaphir,ddaphi,ddaphiz] = deri(daphi,r,r1,r2,meshr,meshphi,meshz);
[ddazr,ddazphi,ddaz] = deri(daz,r,r1,r2,meshr,meshphi,meshz);

end