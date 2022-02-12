function im2 = task2(im1, conv, thre)

m = conv2(im1, conv, "same"); 

mm = mean(m(:))
 
show_image(abs(m) > thre) 

im2=abs(m);


end

