function write(rand_files, filter, function_list)
%write writes a matrix of extracted features to a csv file
%   write takes a number of files, filters each to get
%   a mask that represents the object of interest
%   and maps a list of extraction funtions over each
%   image and corresponding mask.  

%   The output from the extraction functions, floats between
%   0 and 1 are then written into a csv file with a matching
%   file name and folder as the image, but within a csv only
%   folder

for i = 1:size(rand_files, 1)
    for j = 1:size(rand_files{i}, 2)
        image = rand_files{i}{j};
        I = imread(image);
        mask = filter(I);
        output = map(image, mask, function_list);
        file = strrep(image,'Images','text'); 
        csvwrite(strcat(file(1:end-3), 'csv'),output);
    end
end
end

