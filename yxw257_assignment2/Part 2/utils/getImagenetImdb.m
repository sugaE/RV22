% --------------------------------------------------------------------
function imdb = getImagenetImdb(net)
% --------------------------------------------------------------------
% % Preapre the imdb structure, returns image data with mean image subtracted
% files = {'train-images-idx3-ubyte', ...
%          'train-labels-idx1-ubyte', ...
%          't10k-images-idx3-ubyte', ...
%          't10k-labels-idx1-ubyte'} ;
% 
% if ~exist(opts.dataDir, 'dir')
%   mkdir(opts.dataDir) ;
% end
% 
% for i=1:4
%   if ~exist(fullfile(opts.dataDir, files{i}), 'file')
%     url = sprintf('http://yann.lecun.com/exdb/mnist/%s.gz',files{i}) ;
%     fprintf('downloading %s\n', url) ;
%     gunzip(url, opts.dataDir) ;
%   end
% end

% f=fopen(fullfile(opts.dataDir, 'train-images-idx3-ubyte'),'r') ;
% x1=fread(f,inf,'uint8');
% fclose(f) ;
% x1=permute(reshape(x1(17:end),28,28,60e3),[2 1 3]) ;
% 
% f=fopen(fullfile(opts.dataDir, 't10k-images-idx3-ubyte'),'r') ;
% x2=fread(f,inf,'uint8');
% fclose(f) ;
% x2=permute(reshape(x2(17:end),28,28,10e3),[2 1 3]) ;
% 
% f=fopen(fullfile(opts.dataDir, 'train-labels-idx1-ubyte'),'r') ;
% y1=fread(f,inf,'uint8');
% fclose(f) ;
% y1=double(y1(9:end)')+1 ;
% 
% f=fopen(fullfile(opts.dataDir, 't10k-labels-idx1-ubyte'),'r') ;
% y2=fread(f,inf,'uint8');
% fclose(f) ;
% y2=double(y2(9:end)')+1 ;
% 
% 
% set = [ones(1,numel(y1)) 3*ones(1,numel(y2))];
% data = single(reshape(cat(3, x1, x2),28,28,1,[]));
% dataMean = mean(data(:,:,:,set == 1), 4);
% data = bsxfun(@minus, data, dataMean) ;

load("utils/constants.mat");
catogories = fetchLabels(train_dir);


% Obtain and preprocess training image.

labels_train = [];
ims_re=[];

for label_i=1:length(catogories) 
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


% Obtain and preprocess val image.
labels_val = [];

for label_i=1:length(catogories) 
%     read image in folder
    ims = dir(fullfile(val_dir, catogories(label_i), '*.JPEG'));
    
    for i = 1 : length(ims) 
        im = imread(fullfile(ims(i).folder, ims(i).name)); 
        im = single(im);
        if size(im, 3) == 1
            im = cat(3, im, im, im);
        end
%         ims_val{end+1} = im; % note: 255 range 
        ims_re = cat(4, ims_re, ...
            imresize(im, net.meta.normalization.imageSize(1:2), ...
            net.meta.normalization.interpolation));
        labels_val = [labels_val, label_i];
    end
end

set = [ones(1,numel(labels_train)), 2*ones(1,numel(labels_val))];
labels = [labels_train, labels_val];

% centre 0
ims_re = ims_re - net.meta.normalization.averageImage;

% construct imdb
imdb.images.data = ims_re ;
% imdb.images.data_mean = dataMean;
imdb.images.labels = labels;
imdb.images.set = set ;
imdb.meta.sets = {'train', 'val', 'test'};
% imdb.meta.classes = arrayfun(@(x)sprintf('%d',x),0:9,'uniformoutput',false) ;

