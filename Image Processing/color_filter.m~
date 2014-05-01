function img_out = color_filter(img)

[rp, gp, bp] = color_cents(img); 

too_much_r = (rp - min(gp, bp)) > 0.4; 
too_much_g = (gp - min(rp, bp)) > 0.4; 
too_much_b = (bp - min(rp, gp)) > 0.4; 

color_mask = (not(too_much_r)) | (not(too_much_g)) | (not(too_much_b)); 
imshow(color_mask)
pause(1)
bw_img = rgb2gray(img); 
img_out = mat2gray(bw_img) .* double(color_mask); 