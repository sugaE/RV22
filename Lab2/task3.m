function edge_log7_2 = task3(img, sigma, size)

k = round((size - 1) / 2);
log7_2=laplacian_of_gaussian_n(sigma, -k:1:k);
surf(log7_2);
colormap("default");

conv_log7_2 = conv2(img, log7_2);
edge_log7_2 = edge(conv_log7_2, "zerocross");
show_image(edge_log7_2, "edge_log"+size+"_"+sigma);

end

