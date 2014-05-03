% This file writes the features to a CSV file of the same name 

% create a cluster object that can extract the features from an image
clust = my_cluster(4, @rgb2hsv, @ranker.distance, false);

% use the write function to write the feature outputs to the csv files
write(each_breed, @clust.make_masks, {@extract_red, @extract_green, @extract_blue, @extract_text});