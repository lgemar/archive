function folder
%folder creates a directory that matches the images one for csv files

root_path = 'C:\Users\Ryan Meehan\Dropbox\finalproject\Image Processing\Images';
dirs = dir(root_path);
for i = 1:length(dirs)
   mkdir('C:\Users\Ryan Meehan\Dropbox\finalproject\Image Processing\text', dirs(i).name);
end