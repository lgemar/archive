function img_out = conv3(img, conv_matrix)
% convolves two dimensional images with a convolution matrix that acts over
% its third dimension. This outdated function was used to apply fitness
% algorithms to the random output of color_filter_test. 

reshaped_img = reshape(img, size(img, 2)*size(img, 1), size(img, 3));
prelim_out = conv2(reshaped_img, conv_matrix, 'same');
img_out = reshape(prelim_out, size(img));