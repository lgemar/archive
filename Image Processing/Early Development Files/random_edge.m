function [s1, s2] = random_edge(img)
% randomize the image and then apply the edge detector algorithms 

rand_img = randomize_image(img); 

[s1, s2, a, o] = sobel_edges(rand_img); 

show_imgs(img,s1, s2, a, o)
