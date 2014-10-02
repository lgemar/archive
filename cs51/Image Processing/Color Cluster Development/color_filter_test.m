function output = color_filter_test(img)
% This function displays binary images that represent pixels grouped into 
% color clustersThis function alerted us to the possibilites of using color 
% to separate the dog's pixels into a cluster separate from the rest of the 
% pixels in the image. 

% number of color separations to try 
number_of_iterations = 100; 

% returns a random range between zero and one 
random_range = @() sort(rand(1,2)); 

% displays a bunch of random masks that have been created based on whether
% a given pixel fits in the color range specifed by the random inputs to
% color filter. 
mask_matrix = zeros(size(img, 1), size(img, 2), number_of_iterations); 
for i = 1:number_of_iterations
    mask = color_filter(img, random_range(), random_range(), random_range());
    imshow(mask)
    pause(0.005); 
    mask_matrix(:,:,i) = mask; 
end


output = fitness_apply2(mask_matrix, @ranker.distance); 

