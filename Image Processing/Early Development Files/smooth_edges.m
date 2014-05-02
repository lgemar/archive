function [dilated_img1, dilated_img2, dilated_img3] = smooth_edges(img)
% this function applies the combined sobel edge detectors and then smooths
% the result 

% apply sobel filters 
[s1, s2, c] = sobel_edges(img); 

%Dilate a grayscale image with a rolling ball structuring element.
se = strel('ball',5,5);
dilated_img1 = imdilate(s1,se);
dilated_img2 = imdilate(s2, se); 
dilated_img3 = imdilate(c, se); 

show_imgs(dilated_img1, dilated_img2, dilated_img3)