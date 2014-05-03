function reverse(image)
imshow(image);
pause(1);
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);
greeness = double(g) - max(double(r), double(b));
mask = greeness < 10;
for i = 1:3
   new_image(:,:,i) = double(image(:,:,i)).*double(mask); 
end
imshow(mask);
pause(1);
E = entropyfilt(new_image);
Eim = mat2gray(E);
BW1 = im2bw(Eim, .8);
BWao = bwareaopen(BW1,2000);
nhood = true(9);
closeBWao = imclose(BWao,nhood);
roughMask = imfill(closeBWao,'holes');
imshow(roughMask);