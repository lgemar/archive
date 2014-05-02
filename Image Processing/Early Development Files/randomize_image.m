function img_out = randomize_image(img)

filter_size = 10; 
random_thresh = 0.5; 
h_bool = rand(filter_size) < random_thresh; 
h = double(h_bool); 
h = h ./ sum(h(:)); 

img_out = imfilter(img, h); 


