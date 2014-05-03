function processing_list = each_breed
%each_breed selects one image file from each breed
%   returns a list of file paths that represent one
%   image for each breed of dog

root_path = 'C:\Users\Ryan Meehan\Dropbox\finalproject\Image Processing\Images';
dirs = dir(root_path);
dirs = dirs(4:end);

processing_list = cell(length(dirs), 1);
for i = 1:length(dirs)
    full_folder_path = [root_path '/' dirs(i).name];
    file_names = dir(full_folder_path); 
    file_names = file_names(3:end); % get rid of '.' and '..' at the start 

    rand_floats = rand(1, 1); 
    rand_ints = ceil(length(file_names) * rand_floats); 

    file_names_oi = file_names(rand_ints);
    
    full_file_paths = cell(1,1); 
    for j = 1:length(file_names_oi)
        full_file_paths{j} = [full_folder_path '/' file_names_oi(j).name];
    end
    
     processing_list{i} = full_file_paths;
end

