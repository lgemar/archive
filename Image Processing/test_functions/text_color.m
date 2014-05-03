function text_color(image)
imshow(image);
pause(1);
E = entropyfilt(image);
Eim = mat2gray(E);
BW1 = im2bw(Eim, .8);
BWao = bwareaopen(BW1,2000);
nhood = true(9);
closeBWao = imclose(BWao,nhood);
roughMask = imfill(closeBWao,'holes');
imshow(roughMask);
pause(1);
for i = 1:3
   new_image(:,:,i) = double(image(:,:,i)).*double(roughMask); 
end
r = new_image(:,:,1);
g = new_image(:,:,2);
b = new_image(:,:,3);
greeness = double(g) - max(double(r), double(b));
mask = greeness < 0 & 0 < greeness < 10;
imshow(mask);
pause(1);
BWao2 = bwareaopen(mask, 2000);
closeBWao2 = imclose(BWao2, nhood);
roughMask2 = imfill(closeBWao2,'holes');
imshow(roughMask2);
