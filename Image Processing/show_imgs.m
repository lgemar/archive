function show_imgs(varargin)
% this function takes in any number of images and waits a specified period
% of time between each one 

for i = 1:size(varargin, 2)
    if size(varargin{i}, 3) > 3
        imgs = varargin{i}; 
        for j = 1:size(varargin{i}, 3)
            imshow(imgs(:,:,j))
            pause(1.5)
        end
    else 
        imshow(varargin{i})
        pause(1.5)
    end
end