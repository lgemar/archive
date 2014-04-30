function function_tester(f, rand_files)
% This function applies a function, f, to a cell array of random files
% specified by rand_files. It is assumed that the function f has no return
% value and is written to provide some sort of visualization of how well
% the function worked on an image. 

for i = 1:size(rand_files, 1)
    for j = 1:size(rand_files{i}, 2)
        current_image = imread(rand_files{i}{j}); 
        try 
            f(current_image); 
        catch 
            BW = rgb2gray(current_image);
            f(BW);
        end 
        pause(1); 
    end
end