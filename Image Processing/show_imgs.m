function show_imgs(varargin)
% this function takes in any number of images and waits a specified period
% of time between each one 

for i = 1:size(varargin, 2)
    imshow(varargin{i})
    pause(1.5)
end