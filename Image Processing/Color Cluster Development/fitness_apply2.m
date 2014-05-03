function mask_out = fitness_apply2(mask_array, f)
% applies a filter to the output of the color_filter_test. It tries to use
% random color clusters and figure out which one contains the dog. This is
% the old implementation of what is now encapsulated in the ranker object.

fit_matrix = zeros(size(mask_array)); 
for i = 1:size(mask_array, 3)
    mask = mask_array(:,:,i); 
    fit_matrix(:,:,i) = f(mask); 
end 

mask_out = mean(fit_matrix, 3); 
mask_out = imadjust(mask_out); 
    