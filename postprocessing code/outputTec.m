function[]=outputTec(h1,fname,meshr,meshphi,meshz,Xm,Ym,Zm,a,b,c,d)

h1 = fopen(fname, 'w');

fprintf(h1,'TITLE = "data from MATLAB" \n');
fprintf(h1,'VARIABLES = "X" "Y" "Z" "U" "V" "W" "T"\n');
fprintf(h1,'ZONE T = "domain 0 "\n');
fprintf(h1,'I = %d, J = %d, K = %d, F= POINT\n ',meshr,meshphi,meshz );

for n = 1:meshz
    for m = 1:meshphi
       for l = 1:meshr
            fprintf(h1,'%f %f %f\n ', Xm(l,m,n),Ym(l,m,n),Zm(l,m,n) );
            fprintf(h1,'%f %f %f\n', a(l,m,n),b(l,m,n),c(l,m,n) );
            fprintf(h1,'%f\n',d(l,m,n) );


        end
    end
end
close all;

end
