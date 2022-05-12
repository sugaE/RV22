function [images, labels] = getBatch(imdb, batch)
images = imdb.images.data(:,:,:,batch) ;
% im = 256 * reshape(im, 32, 32, 1, []) ;
labels = imdb.images.labels(1,batch) ;
end

 