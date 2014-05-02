function [sobel1, sobel2] = entropy_sobel(img) 
% apply an entropy filter and then a sobel filter on the result.
% Didn't work very well. 

entropy = entropyfilt(img); 
[sobel1, sobel2] = sobel_edges(entropy); 
show_imgs(sobel1, sobel2)