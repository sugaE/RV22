function  re = save_image(fig,  name, dir)
exportgraphics(fig, fullfile(dir, name), BackgroundColor="none", Resolution=600);

