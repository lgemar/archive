function [sobel_img1, sobel_img2, AND, OR] = sobel_edges(img)
% applies a sobel edge-detecting filter to an image and shows the result 

if size(img, 3) == 3
    BWI = rgb2gray(img);
else 
    BWI = img; 
end

h = fspecial('sobel'); 
sobel_img1 = imfilter(BWI, h);
sobel_img2 = imfilter(BWI, h'); 
OR = sobel_img1 + sobel_img2; 
AND = sobel_img2 .* sobel_img2; 

% show_imgs(sobel_img1, sobel_img2, OR, AND); 

