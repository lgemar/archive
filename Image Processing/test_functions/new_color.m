function new_color(image)
imshow(image);
pause(1);
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);
greeness = double(g) - max(double(r), double(b));
mask = greeness < 10;
imshow(mask);
