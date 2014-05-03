function folder
%folder creates a directory that matches the images one for csv files

root_path = 'C:\Users\Ryan Meehan\Dropbox\';
local_path = 'finalproject\data\Images';
full_path = [root_path, local_path]; 
dirs = dir(full_path);
for i = 1:length(dirs)
   mkdir('C:\Users\Ryan Meehan\Dropbox\finalproject\data\text', dirs(i).name);
end