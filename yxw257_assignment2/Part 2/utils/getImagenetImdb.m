% --------------------------------------------------------------------
function imdb = getImagenetImdb(net)
% --------------------------------------------------------------------
% % Preapre the imdb structure, returns image data with mean image subtracted

load("utils/constants.mat");
catogories = fetchLabels(train_dir);

% Obtain and preprocess training image.
[ims_re, labels_train] = getImageDir(train_dir, catogories, net);


% Obtain and preprocess val image.
[ ims_val, labels_val] = getImageDir(val_dir, catogories, net);
ims_re = cat(4, ims_re, ims_val);


set = [ones(1,numel(labels_train)), 2*ones(1,numel(labels_val))];
labels = [labels_train, labels_val];

% centre 0
ims_re = ims_re - mean(ims_re, 4);

% construct imdb
imdb.images.data = ims_re ;
% imdb.images.data_mean = dataMean;
imdb.images.labels = labels;
imdb.images.set = set;
imdb.meta.sets = {'train', 'val', 'test'};
% imdb.meta.classes = arrayfun(@(x)sprintf('%d',x),0:9,'uniformoutput',false) ;

