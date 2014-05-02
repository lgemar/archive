function [r_percent, g_percent, b_percent] = color_cents(img)

% normalize each pixel against the total pixel intensities at a point
[r,g,b] = extract_color(img);

percent = @(color) double(color) ./ sum(img, 3);
r_percent = percent(r);
g_percent = percent(g); 
b_percent = percent(b); 
