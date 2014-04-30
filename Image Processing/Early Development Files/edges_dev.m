% This file tests a number of edge detection methods in hopes that one of
% them will help us extract a dog from an image

%% grab a cell array of random files to process
num_dirs = 3; 
num_files = 3; 
foi = rand_files(num_dirs, num_files); % foi = files of interest 

%% write and test canny edge detector on a group of random files 
fHandle = @canny_edges; 
function_tester(fHandle, foi); 
% Notes: there are many edges detected in the background and its not clear
% how to extract the dog from these. 

%% write and test a phase congruency edge detector 
fHandle = @phase_edges; 
function_tester(fHandle, foi); 
% Notes: the edges here are not as clean as the canny detector. You can
% make out some of the outlines of dogs but it is quite difficult, again,
% to see how we can draw something useful for it. 

%% write and test a sobel edge detector 
fHandle = @sobel_edges; 
function_tester(fHandle, foi); 
% Notes: this seems to be the best edge detection algorithm yet. We can
% clearly see the dog, and by using some kind of smoothing filter on the
% result we may be able to extract the dog. 

%% apply sobel, smooth the result, then apply canny
fHandle = @sobel_smooth_canny; 
function_tester(fHandle, foi); 
% Notes: this fell flat. The smoothing function just doesn't do a good
% enough job separating the spatial frequencies before the canny detector
% comes through. The output looks very garbled -- much worse that any of
% the edge detectors by themselves. 

%% convolve the output of sobel with the output of canny
fHandle = @sobel_conv_canny; 
function_tester(fHandle, foi); 
% Notes: this method gives really blurry images but it seems to have the
% location right; that is, it is brightest where the dog is located. Maybe
%I can use this result somehow. 








