function background_pixels = color_thresh(img)

% show the grayscale percent images 
[r_percent, g_percent, b_percent] = color_cents(img);

create_mask = @(percents) percents > 0.4; 
r_percent = create_mask(r_percent); 
g_percent = create_mask(g_percent); 
b_percent = create_mask(b_percent); 

background_pixels = r_percent | g_percent | b_percent; 

% show background image 
% show_imgs(background_pixels)