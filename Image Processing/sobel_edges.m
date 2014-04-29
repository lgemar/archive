function sobel_img = sobel_edges(img)
% applies a sobel edge-detecting filter to an image and shows the result 

if size(img, 3) == 3
    BWI = rgb2gray(img);
else 
    BWI = img; 
end

h = fspecial('sobel'); 
sobel_img = imfilter(BWI, h);
imshow(sobel_img); 
