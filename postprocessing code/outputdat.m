function[]=outputdat(mesh1,mesh2,Xm,Ym,U)
fname = '2dout.dat';
h1 = fopen(fname, 'w');

fprintf(h1,'TITLE = "data from MATLAB" \n');
fprintf(h1,'VARIABLES = "X" "Y" "U"\n');
fprintf(h1,'ZONE T = "domain 0 "\n');
fprintf(h1,'I = %d, J = %d,F= POINT\n ',mesh1,mesh2 );

    for m = 1:mesh2
       for l = 1:mesh1
            fprintf(h1,'%f %f %f\n ', Xm(l,m),Ym(l,m),U(l,m));
        end
    end

close all;
end