function img_out = roll_ball(img)

se = strel('ball',5,5);
img_out = imdilate(img,se);
