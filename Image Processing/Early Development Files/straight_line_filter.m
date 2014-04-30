function [out1, out2] = straight_line_filter(img)

filter_size = 20; 
h_linewidth = 5; 
v_linewidth = 5; 

h = ones(filter_size, filter_size);
h((filter_size - v_linewidth):(filter_size + v_linewidth), :) = 0; 
h(:, (filter_size - h_linewidth):(filter_size + h_linewidth)) = 0; 
h = h ./ sum(h(:)); 

[s1, s2, a, o] = sobel_edges(img); 

out1 = imfilter(s1, h); 
out2 = imfilter(s2, h); 

show_imgs(out1, out2); 
