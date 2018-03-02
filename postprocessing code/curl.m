function[curlval]=curl(U,V,W,meshr,meshphi,meshz,r)
curlval=zeros(meshr,meshphi,meshz,3);
for i=2:(meshr-1)
    for j=1:meshphi
        for k =2:(meshz-1)
            if j==1
            curlval(i,j,k,1)=1/r(i)*(W(i,j+1,k)-W(i,meshphi,k))/(2*2*pi/meshphi)-(V(i,j,k+1)-V(i,j,k-1))/(2*1/(meshz-1));
            curlval(i,j,k,2)=(U(i,j,k+1)-U(i,j,k-1))/(2*1/(meshz-1))-(W(i+1,j,k)-W(i-1,j,k))/(2*1/(meshr-1));
            curlval(i,j,k,3)=1/r(i)*(r(i+1)*V(i+1,j,k)-r(i-1)*V(i-1,j,k))/(2*1/(meshr-1))-1/r(i)*(U(i,j+1,k)-U(i,meshphi,k))/(2*2*pi/meshphi);
            elseif j==meshphi
            curlval(i,j,k,1)=1/r(i)*(W(i,1,k)-W(i,j-1,k))/(2*2*pi/meshphi)-(V(i,j,k+1)-V(i,j,k-1))/(2*1/(meshz-1));
            curlval(i,j,k,2)=(U(i,j,k+1)-U(i,j,k-1))/(2*1/(meshz-1))-(W(i+1,j,k)-W(i-1,j,k))/(2*1/(meshr-1));
            curlval(i,j,k,3)=1/r(i)*(r(i+1)*V(i+1,j,k)-r(i-1)*V(i-1,j,k))/(2*1/(meshr-1))-1/r(i)*(U(i,1,k)-U(i,j-1,k))/(2*2*pi/meshphi);
            else
            curlval(i,j,k,1)=1/r(i)*(W(i,j+1,k)-W(i,j-1,k))/(2*2*pi/meshphi)-(V(i,j,k+1)-V(i,j,k-1))/(2*1/(meshz-1));
            curlval(i,j,k,2)=(U(i,j,k+1)-U(i,j,k-1))/(2*1/(meshz-1))-(W(i+1,j,k)-W(i-1,j,k))/(2*1/(meshr-1));
            curlval(i,j,k,3)=1/r(i)*(r(i+1)*V(i+1,j,k)-r(i-1)*V(i-1,j,k))/(2*1/(meshr-1))-1/r(i)*(U(i,j+1,k)-U(i,j-1,k))/(2*2*pi/meshphi);
            end
            
        end
    end
end
for j=1:meshphi
    for k=2:(meshz-1)
        for m=1:3
            curlval(1,j,k,m)=curlval(2,j,k,m);
            curlval(meshr,j,k,m)=curlval(meshr-1,j,k,m);
        end
    end
end

for j=1:meshphi
    for i=1:meshr
        for m=1:3
            curlval(i,j,1,m)=curlval(i,j,2,m);
            curlval(i,j,meshz,m)=curlval(i,j,meshz-1,m);
        end
    end
end

end