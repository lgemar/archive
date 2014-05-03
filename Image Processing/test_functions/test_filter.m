function mask = test_filter(image)
%test_filter poor image processing filter for testing
%   First filters by texture using an entropy filter
%   to calculate the randomness of pixel clusters,
%   then removes the common background color of green
%   and closes the holes to provide a sound mask

E = entropyfilt(image);
Eim = mat2gray(E);
BW1 = im2bw(Eim, .8);
BWao = bwareaopen(BW1,2000);
nhood = true(9);
closeBWao = imclose(BWao,nhood);
roughMask = imfill(closeBWao,'holes');
for i = 1:3
   new_image(:,:,i) = double(image(:,:,i)).*double(roughMask); 
end
r = new_image(:,:,1);
g = new_image(:,:,2);
b = new_image(:,:,3);
greeness = double(g) - max(double(r), double(b));
roughMask2 = greeness < 0 & 0 < greeness < 10;
BWao2 = bwareaopen(roughMask2, 2000);
closeBWao2 = imclose(BWao2, nhood);
mask = imfill(closeBWao2,'holes');
end

