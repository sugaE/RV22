function [ims_train,labels_train] = getImageDir(train_dir, catogories, net)

% Obtain and preprocess training image.
ims_train = [];
labels_train = [];

for label_i=1:length(catogories)
%     l_ind = find(strcmp(net.meta.classes.name , label_i));
%     read image in folder
    ims = dir(fullfile(train_dir, catogories(label_i), '*.JPEG'));
    
    for i = 1 : length(ims) 
        im = imread(fullfile(ims(i).folder, ims(i).name)); 
        im = single(im);
        if size(im, 3) == 1
            im = cat(3, im, im, im);
        end
%         ims_train{end+1} = im; % note: 255 range 
        ims_re = cat(4, ims_re, ...
            imresize(im, net.meta.normalization.imageSize(1:2), ...
            net.meta.normalization.interpolation));
        labels_train = [labels_train, label_i];
    end
end


