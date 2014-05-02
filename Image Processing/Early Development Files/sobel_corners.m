function sobel_corners(img) 
% this function applies a sobel edge detector and then finds the corners in
% the resultant image. The hope is that the corners will lie mostly on the
% dog since its furr is very high frequency and has lots of bends and turns
% in it. 

sobel_img = sobel_edges(img); 
corner_tester(sobel_img); 