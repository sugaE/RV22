function Y = processLabelsMNIST(filename)

dataFolder = fullfile(tempdir,'mnist');
gunzip(filename,dataFolder)

[~,name,~] = fileparts(filename);

[fileID,errmsg] = fopen(fullfile(dataFolder,name),'r','b');

if fileID < 0
    error(errmsg);
end

magicNum = fread(fileID,1,'int32',0,'b');
if magicNum == 2049
    fprintf('\nRead MNIST label data...\n')
end

numItems = fread(fileID,1,'int32',0,'b');
fprintf('Number of labels in the dataset: %6d ...\n',numItems);

Y = fread(fileID,inf,'uint8');

Y = categorical(Y);

fclose(fileID);
end