function output = map(image, mask, function_list)
%map maps functions onto image

%   Applies a list of feature extracting function onto 
%   a image and a filtered mask of that image containing
%   the object of interest

I = imread(image);
output{1, 3} = [];
for i = 1:length(function_list)
    output{i} = function_list{i}(I, mask);
end  

end

