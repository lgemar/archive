function blue = extract_blue(image, mask)
%extract_blue returns average blue values for filtered image
for i = 1:3
   dog_extract(:,:,i) = double(image(:,:,i)).*double(mask); 
end
blue = sum(sum(dog_extract(:,:,3))) ./ sum(sum(mask)) ./ 255.0;
end

