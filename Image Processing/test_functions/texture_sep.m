function texture_sep(image) 
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
