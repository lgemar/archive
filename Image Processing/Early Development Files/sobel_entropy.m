function [entropy1, entropy2] = sobel_entropy(img) 
% apply a sobel filter and then apply an entropy filter on the result.
% Didn't work very well. 

[horiz, vertical] = sobel_edges(img); 
entropy1 = entropyfilt(horiz); 
entropy2 = entropyfilt(vertical); 
show_imgs(entropy1, entropy2)