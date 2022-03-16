function setup
    disp('Adding subfolders to search path.')
     
    folder = fileparts( mfilename('fullpath') ); 
    addpath( folder );
    addpath( fullfile(folder, 'part2') );
    addpath( fullfile(folder, 'part3') );
    addpath( fullfile(folder, 'part4') ); 

    disp('Finished. Can run code now.')

end
