function [prewitt1, prewitt2] = prewitt_edges(img)
% test the prewitt edge detectors 

h = fspecial('prewitt'); 
prewitt1 = imfilter(img, h); 

h = fspecial('prewitt')'; 
prewitt2 = imfilter(img, h); 

show_imgs(prewitt1); 
show_imgs(prewitt2); 
