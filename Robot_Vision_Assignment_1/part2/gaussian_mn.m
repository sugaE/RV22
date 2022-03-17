function n_3x3 = gaussian_mn(mn, std, mu, show_surf)

arguments
    mn (1,2) double
    std double = 1.0
    mu double = 0.0
    show_surf logical = 0
end

m = mn(1);
n = mn(2);
i = (n - 1) / 2;
j = (m - 1) / 2;
n_3 = N(mu, std, -i:1:i);
m_3 = N(mu, std, -j:1:j);
n_3x3 = m_3' * n_3;

% if with_normalisation 
n_3x3 = n_3x3 / sum(n_3x3(:));
% end

% display graph
if show_surf
    figure;
    colormap("default");
    surf(n_3x3);
end

end

