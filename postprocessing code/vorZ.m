function[vort,vortz]=vorZ(U,V,W,meshr,meshphi,meshz,r)

vort=[];

vortz=[];

vort = curl(U,V,W,meshr,meshphi,meshz,r);
            
vortz(:,:,:)=vort(:,:,:,3);

end
