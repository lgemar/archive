function output = sobel_smooth_canny(img)
% try applying a sobel edge-detector, smooth the result using an averaging
% filter, and then do canny edge detection on the result. The reasoning
% behind this strategy is that sobel does the best job of contrasting the
% dog from its background, but sometimes the background has higher
% frequency and sometimes the background has lower frequency. Smoothing the
% output of sobel will further separate the spatial frequencies, hopefully
% just enough so that canny can draw outlines directly where one frequency
% meets the other: at the edges of the dog. Let's give it a try! 

sobel_img = sobel_edges(img); 

% create a low pass filter of size 2% of the width of the image
radius = double(uint8(0.05 * size(sobel_img, 2))); 
h = fspecial('average', radius); 
smoothed_img = imfilter(sobel_img, h); 
imshow(smoothed_img); 

% compute canny edge detection on the result
canny_img = canny_edges(smoothed_img); 

output = canny_img; 