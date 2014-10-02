function data_array = generate_clusts(num_dirs, num_files, num_clusters)
% I used this function to find a cluster of colors that are common between
% a large number of images of dogs. This function specifically 
% generates a large array of cluster centers that might be useful for
% further clustering to determine which centers seem to pop up in many
% images. This could be used to find the optimal algorithm for the color
% ranker. Alas, we did not get far enough to implement this. 

% number of images to be processed 
num_images = num_dirs * num_files; 

% create the array of files to be processed 
file_array = rand_files(num_dirs, num_files); 

% creates a data array of kmeans cluster center locations
data_array = zeros(num_images * num_clusters, 3); 
for i = 1:num_images 
    current_dir = idivide(i, num_dirs + 1) + 1; 
    current_file = idivide(i, num_dirs + 1) + 1;  
    current_img = file_array{current_dir}{current_file}; 
    img = imread(current_img); 
    centers = cluster_centers(img, num_clusters); 
    data_array(((i-1)*num_clusters + 1):(num_clusters*i), :) = centers; 
end