function [r, g, b] = extract_color(img)
% Try to exclude common background colors from the image 

r = img(:,:,1); 
g = img(:,:,2); 
b = img(:,:,3); 