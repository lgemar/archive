function [sh_thresh, sv_thresh, AND_thresh, OR_thresh] = sobel_thresholds(img)

[sh, sv, AND, OR] = sobel_edges(img); 
sh_thresh = thresh_img(sh); 
sv_thresh = thresh_img(sv); 
AND_thresh = sh_thresh & sv_thresh; 
OR_thresh = sh_thresh | sv_thresh; 

show_imgs(sh_thresh, sv_thresh, AND_thresh, OR_thresh)