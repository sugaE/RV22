function out_logn = laplacian_of_gaussian_n(sigma,xs)
lenx = length(xs);
out_logn = zeros(lenx, lenx);
i=1;  
sumlog=0;
for x=xs
    j=1;
    for y=xs
        tmp = -(x^2+y^2)/(2*sigma^2);
        out_logn(i,j) = -1/(pi * sigma^4)*(1+tmp)*exp(tmp);
        sumlog = sumlog + out_logn(i,j);
        j=j+1;
    end
    i=i+1;
end
out_logn = out_logn / sumlog;

end