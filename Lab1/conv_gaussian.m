function conv = conv_gaussian(size, sigma)
%CONV_GAUSSIAN Summary of this function goes here
%   Detailed explanation goes here
    conv = zeros(size);
    k = (size-1) / 2;
    for i = 1:size
        for j = 1:size
            conv(i,j)=1/2/pi/(sigma^2)*exp(-((i-k-1)^2+(j-k-1)^2)/(2*sigma^2));
        end
    end 
    conv = conv / sum(conv(:)); 
end
