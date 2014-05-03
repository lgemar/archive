function processing_list = rand_files(num_dirs, num_files)
% This function returns a cell array of files from the Image database. It
% returns num_files random files from num_dirs random directories in the
% database. Again, the processing_list is a cell array. It contains the
% full paths to these images, and its contents can be accessed by using the
% syntax, processing_list{i}{j} to access the i,j-th element of the cell
% array. The root_path needs to be specified for a given machine; it is the
% full path to the image database. 

%% get a list of all the folders in the Images directory 
root_path = '/Users/lukasgemar/Dropbox/';
local_path = 'final_project/data/Images';
full_path = [root_path, local_path]; 
dirs = dir(full_path);
dirs = dirs(4:end); 

%% choose num_dirs random directories
% grab random directory numbers 
rand_floats = rand(1,num_dirs);
rand_ints = ceil(length(dirs)* rand_floats); 

% select the directories of interest
dirs_oi = dirs(rand_ints); 

%% grab num_files random images from each directory 
processing_list = cell(num_dirs, 1); 
for i = 1:length(dirs_oi)
    full_folder_path = [full_path '/' dirs_oi(i).name];
    file_names = dir(full_folder_path); 
    file_names = file_names(3:end); % get rid of '.' and '..' at the start 
    
    % get random indices                                
    rand_floats = rand(1, num_files); 
    rand_ints = ceil(length(file_names) * rand_floats); 
    
    % only pull out files at indices of interest 
    file_names_oi = file_names(rand_ints); 
    
    % create full file paths and store them in 'files_to_process' array
    full_file_paths = cell(1,num_files); 
    for j = 1:length(file_names_oi)
        full_file_paths{j} = [full_folder_path '/' file_names_oi(j).name];
    end
    
    % this processing_list contains a 2-D cell array of files to process
    processing_list{i} = full_file_paths; 
end


