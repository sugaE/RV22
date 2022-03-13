function re = dog(size, mu1, sigma1, mu2, sigma2)

arguments
    size (1,2) int32 
    mu1 double = 0.0
    sigma1 double = 1.0
    mu2 double = mu1
    % A difference of Gaussians of any scale is an approximation to the laplacian of the Gaussian
    % However, Marr and Hildreth recommend the ratio of 1.6 
    % because of design considerations balancing bandwidth and sensitivity.
    sigma2 double = 1.6 * sigma1
end


g1 = gaussian_mn(size, sigma1, mu1);
g2 = gaussian_mn(size, sigma2, mu2);

re = g1 - g2;
% re = re/sum(re(:))

end

