%
% yxw257@student.bham.ac.uk
%
% !!!!!!!!!!!!!!! Please run setup before run other codes

function setup
    disp('Adding subfolders to search path.')
     
    folder = fileparts( mfilename('fullpath') ); 
    addpath( fullfile(folder, "Part 2/utils") );
    addpath( fullfile(folder, "Part 2/yxw257_assignment2_part2_Q2_5") );

    disp('Finished. Can run code now.')

end
