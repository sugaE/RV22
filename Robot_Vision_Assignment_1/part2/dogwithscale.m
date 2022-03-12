function re = dogwithscale(im, size_kernel, mu1, sigma1, ss)

arguments
    im 
    size_kernel (1,2) int32 
    mu1 double = 0.0
    sigma1 double = 1.0
    ss (1, :) double = [1.6]
end

% n_scales = size(ss)
re = []
i = 1

if size(ss, 2) < 2
    ss = [1, ss(1,:)]
end

ss
pre_s = ss(1)

for s = ss(2:end)
    g1 = dog(size_kernel,  mu1, sigma1 * pre_s, mu1, sigma1 * s)
    img = conv2(im, g1, 'same')
    show_image(img)
    re(i, :, :) = img;
    i = i + 1;
    pre_s = s;
end
% re = g1 - g2;

% g3 = dog([3,3], 0, 1.6, 0, 5);
% g3_re = conv2(blue_marble, g3);
% show_image(g3_re);

end

