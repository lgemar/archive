% next step: try to apply k-means clustering to find the colors common to
% all images of dogs. Hopefully I can use this color-cluster information to
% set appropriate thresholds to get rid of colors in an image that
% definitely aren't from a dog. 

img1 = rand_files(1,1); 
img1 = img1{1}{1}; 
img1 = imread(img1); 

% get hsv color transform
[r, theta, z] = hsv_extract(img1); 

% rows of color_mat correspond to points and columns to variables 
color_mat = reshape([r, theta, z], 3, size(img1, 1)*size(img1, 2)); 

% compute k-means objects
[IDX, C] = kmeans(color_mat, 3); 

% create clustered image
clustered_img = reshape(C, size(img1)); 