function out = sobel_AND_canny_AND_phase(img)
% applies the logical AND of the sobel,canny, and phase edge detectors a
% filtering

sobel = double(sobel_edges(img)); 
canny = double(canny_edges(img)); 
phase = double(phase_edges(img)); 
out = sobel .* canny .* phase; 