function color_phases(img) 
% trial run to see if anything useful can be detected from the phases of
% the different color percent contributions of each pixel. Not much was
% found. Didn't really work very well. 

[rp, gp, bp] = color_cents(img); 
r_phase = phase_edges(rp); 
g_phase = phase_edges(gp); 
b_phase = phase_edges(bp); 
show_imgs(r_phase, g_phase, b_phase)

