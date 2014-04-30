function BW = phase_edges(img)
% tries to find edges using phase congruency 

%% grab edges by using phase congruency 
if size(img, 3) == 3
    BWI = rgb2gray(img);
else 
    BWI = img; 
end

img_spect = fft(BWI);
img_phases = angle(img_spect); 
phase_spectrum = exp(complex(0, img_phases)); 
phase_img = ifft(phase_spectrum); 
phase_img_mag = abs(phase_img); 

%% threshold the image automatically 
level = graythresh(phase_img_mag); 
BW = im2bw(phase_img_mag, level); 

%% show the image 
imshow(BW); 
