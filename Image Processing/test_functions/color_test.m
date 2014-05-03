image = imread('dog5.jpg');
figure, imshow(image);
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);
greeness = double(g) - max(double(r), double(b));
mask = greeness < 20;
figure, imagesc(mask);