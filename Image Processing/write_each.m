clust = my_cluster(4, @rgb2hsv, @ranker.distance, false);
write(each_breed, @clust.make_masks, {@extract_red, @extract_green, @extract_blue, @extract_text});