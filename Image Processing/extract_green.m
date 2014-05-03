function green = extract_green(image, mask)
%extract_green returns average green values for filtered image
for i = 1:3
   dog_extract(:,:,i) = double(image(:,:,i)).*double(mask); 
end
green = sum(sum(dog_extract(:,:,2))) ./ sum(sum(mask)) ./ 255.0;
end

