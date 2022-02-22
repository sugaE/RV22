function n_3x3 = gaussian_n(n, std, with_normalisation)

i = (n - 1) / 2;
n_3 = N(0, std, -i:1:i);
n_3x3 = n_3' * n_3;

if with_normalisation 
    n_3x3 = n_3x3 / sum(n_3x3(:));
end

% display graph
colormap("default");
surf(n_3x3);

end

