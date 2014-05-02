function display_color(hsv_encoding)
% hsv_encoding = [theta, r, z]; This function simply displays an HSV color
% specified by the input parameters

image = ones(200, 200, 3); 
for i = 1:3 
    image(:,:,i) = image(:,:,i) * hsv_encoding(i); 
end

rgb_image = hsv2rgb(image); 
imshow(rgb_image)
pause(1.5); 
