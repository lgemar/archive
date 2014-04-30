function E1 = canny_edges(img)
% This function applies the canny edge detector to an image

if size(img, 3) == 3
    BWI = rgb2gray(img);
else 
    BWI = img; 
end

E1 = edge(BWI, 'canny');