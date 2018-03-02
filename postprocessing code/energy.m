function[WE,WP,WT,diff,dissi]=energy(meshr,meshphi,meshz,r,r1,r2,u,v,w,T,Gr2)
WE = [];
WP = [];
WT = [];
diff = [];
dissi = [];

%turbulent kinetic energy budget
E = 0.5 * (u^2 + v^2 + w^2);
for i =1:meshr
    for j=1:meshphi
        for k = 1:meshz
            WEt(i,j,k) = 
            
        end
    end
end
[drWE,dpWE,dzWE] = deri()
for i =1:meshr
    for j=1:meshphi
        for k = 1:meshz
            
            
        end
    end
end

end