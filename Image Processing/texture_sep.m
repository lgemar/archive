function texture_sep(image) 
% quantifies the texture of an image by using the entropy filter that finds
% a measure of randomness in the 9x9 region of every pixel 

imshow(image);
pause(1);
E = entropyfilt(image);
Eim = mat2gray(E);
imshow(Eim);
BW1 = im2bw(Eim, .8);
BWao = bwareaopen(BW1,2000);
nhood = true(9);
closeBWao = imclose(BWao,nhood);
roughMask = imfill(closeBWao,'holes');
imshow(roughMask);