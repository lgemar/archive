function output = sobel_conv_canny(img)
% This function hopes to locate the dog by convolving the output of the
% sobel filter with the output of the canny filter. 

sobel_img = sobel_edges(img); 
imshow(sobel_img)

canny_img = canny_edges(img); 
imshow(canny_img)

conv_img = conv2(double(sobel_img), double(canny_img), 'same');
conv_img = conv_img ./ max(conv_img(:)); 
imshow(conv_img); 

level = graythresh(conv_img); 
output = im2bw(conv_img, level); 