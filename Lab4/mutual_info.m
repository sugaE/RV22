function mi = mutual_info(vis, cfp)

figure;
binlimit=[0, 256];
h_vis = histogram(vis, Normalization="probability", BinLimits=binlimit, BinWidth=1);
hvis_val=h_vis.Values;

h_cfp = histogram(cfp, Normalization="probability", BinLimits=binlimit, BinWidth=1);
hcfp_val=h_cfp.Values;

h2 = histogram2(vis,cfp, Normalization="probability", XBinLimits=binlimit,YBinLimits=binlimit, BinWidth=[1 1]);
h2_val=h2.Values;

mis = zeros(size(h2_val));
for i=1:255
    for j=1:255
        vis_i = vis(i, j)+1;
        cfp_i = cfp(i, j)+1;
        pipj = hvis_val(vis_i) * hcfp_val(cfp_i);
        pij = h2_val(vis_i,cfp_i);
        mis(i,j) = pij * log(pij/pipj);
    end
end
mi = nansum(mis(:));

end

