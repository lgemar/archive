function map_functions(rand_files, varargin)
% This function applies a series of functions to a cell array of random files
% specified by rand_files. It ignores the return value of the series of
% functions passed in. The functions themselves should either return a
% function or unit. This is not useful in application but useful for
% testing. 

for i = 1:size(rand_files, 1)
    for j = 1:size(rand_files{i}, 2)
        current_image = imread(rand_files{i}{j}); 
        function_fold(current_image, varargin); 
    end
end