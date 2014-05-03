function processing_list = entire_breed(index)
%   entire_breed selects all images for one breed
%   returns a list of file paths that represent all
%   the dogs of a certain breed

root_path = 'C:\Users\Ryan Meehan\Dropbox\';
local_path = 'finalproject\data\Images';
full_path = [root_path, local_path]; 
dirs = dir(full_path);
dirs = dirs(4:end);

full_folder_path = [full_path '/' dirs(index).name];
file_names = dir(full_folder_path); 
file_names = file_names(3:end); % get rid of '.' and '..' at the start 

processing_list = cell(length(file_names), 1);
     
full_file_paths = cell(length(file_names),1); 
    
for i = 1:length(file_names)
    full_file_paths{i} = [full_folder_path '/' file_names(i).name];
    
    processing_list{i} = full_file_paths;
end
    
     
end


