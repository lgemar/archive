function corner_tester(img)
% this function tests how well the "corner" function works on a set of
% images. This seems to be a promising way of extracting a set of features
% from a dog. 

C = corner(img);
imshow(img);
hold on
plot(C(:,1), C(:,2), 'r*');