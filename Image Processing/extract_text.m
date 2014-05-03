function text = extract_text(image, mask)
%extract_text returns normalized randomness of pixels
%   this is a method of capturing texture
for i = 1:3
   dog_extract(:,:,i) = double(image(:,:,i)).*double(mask); 
end

t_mask = entropyfilt(dog_extract);
avgval = mean2(t_mask);
text = normpdf(avgval);

end
