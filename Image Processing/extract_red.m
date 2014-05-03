function red = extract_red(image, mask)
%extract_red returns average red values for filtered image
for i = 1:3
   dog_extract(:,:,i) = double(image(:,:,i)).*double(mask); 
end
red = sum(sum(dog_extract(:,:,1))) ./ sum(sum(mask)) ./ 255.0;
end