% Quick demonstration script that shows how we called the functions to test
% and tweek our algorithms. It turns out that the human eyes are the best
% test for whether or not our algorithm is working, so we did our best to
% consolidate things in a way that would allow us to test our algorithms on
% many different dogs quickly. 

% During the color clustering development, this was most commonly run
% command. It takes a bunch of random files, and uses the map_functions
% file to fold each function over each image. 

% this creates a cluster object that can make color cluster masks of an
% image. It outputs num_clusts binary masks. 
my_clust1 = my_cluster(4, @rgb2hsv, @ranker.distance, true); 

% here we fold over each file returned by rand_files by using show_imgs,
% which displays the original image, then we apply the clustering
% algorithms which returns our masks, and the show_imgs is applied again so
% that we can view the masks. We can run this command many times to see how
% our algorithms are working on a number of different breeds of dogs and
% a bunch of dogs per breed. 
map_functions(rand_files(2,2), @show_imgs, @my_clust1.make_masks, @show_imgs);

% To get the final mask, we instantiate a my_cluster object with the last
% boolean flag set to false, so that we only get the top ranked mask
% returned. This output can be then applied to the image so that we get the
% dog pixels only. We can then do feature extraction on those pixels. 
my_clust2 = my_cluster(4, @rgb2hsv, @ranker.distance, false); 