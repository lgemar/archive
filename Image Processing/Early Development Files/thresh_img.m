function out_img = thresh_img(img)
% this function is simple: it converts the image to grayscale, thresholds
% it automatically, and returns the result. 

if size(img, 3) == 3
    BW = rgb2gray(img); 
else 
    BW = img; 
end

level = graythresh(BW); 
out_img = im2bw(BW, level); 