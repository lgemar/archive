% try different combinations of filters 
function_list_1 = {@randomize_image, @sobel_edges.vert, @thresh_img, @sobel_edges.hor, @show_imgs};
map_functions(rand_files(2,2), function_list);

function_list1 = {@randomize_image, @sobel_edges.vert, @show_imgs};
function_list2 = {@randomize_image, @sobel_edges.hor, @show_imgs};
map_functions(rand_files(4,2), @show_imgs, function_list1, function_list2);

function_list1 = {@randomize_image, @sobel_edges.vert, @rgb2gray, @median_filt, @show_imgs};
map_functions(rand_files(4,2), @show_imgs, function_list1);

function_list1_1 = {@randomize_image, @rgb2gray, @median_filt, @sobel_edges.vert, @show_imgs};
map_functions(rand_files(4,2), @show_imgs, function_list1_1);
% Notes: this one looks pretty promising! There are few positives, but much
% not many FALSE positives, which is the quantity we really want to
% minimize. 

% try the same filter from above except using a horizontal sobel 
function_list1 = {@randomize_image, @rgb2gray, @median_filt, @sobel_edges.hor, @show_imgs};
map_functions(rand_files(4,2), @show_imgs, function_list1);

% try the same filter from above except using a horizontal sobel 
function_list1 = {@randomize_image, @rgb2gray, @median_filt, @sobel_edges.hor, @show_imgs};
map_functions(rand_files(4,2), @show_imgs, function_list1);

% try entropy filtering for the first time! 
entropy_filts = {@entropy_filt, @mat2gray};
map_functions(rand_files(4,2), @show_imgs, entropy_filts, @show_imgs);

% try entropy filtering paired with some of the previous filters 
function_list1 = {@randomize_image, @rgb2gray, @median_filt, @sobel_edges.vert, @show_imgs};
entropy_filts = {@entropy_filt, @mat2gray};
map_functions(rand_files(4,2), @show_imgs, function_list1, entropy_filts, @show_imgs);

% try combining horizontal and vertical edge detection 
combined_edges = @(img) function_fold(img, @sobel_edges.vert, @mat2gray) .* function_fold(img, @sobel_edges.hor, @mat2gray); 
map_functions(rand_files(4,2), @show_imgs, combined_edges, @show_imgs); 

% try just randomizing the image and then applying a threshold 
function_list1 = {@randomize_image, @thresh_img}; 
map_functions(rand_files(4,2), @show_imgs, function_list1, @show_imgs); 

% try enhancing contrast before applying filters 
function_list1_2 = {@randomize_image, @median_filt, @sobel_edges.vert, @show_imgs};
map_functions(rand_files(4,2), @rgb2gray, @show_imgs, @imadjust, @show_imgs, function_list1_2);

% try standard deviation filtering  
map_functions(rand_files(4,2), @rgb2gray, @mat2gray, @show_imgs, @stdfilt, @show_imgs); 

% try a color filter 
map_functions(rand_files(4,2), @show_imgs, @color_filter, @show_imgs); 




