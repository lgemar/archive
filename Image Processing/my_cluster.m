classdef my_cluster
% The object applies a tranformation to an image of a dog and then clusters
% the transformed data into a specified number of clusters by using the
% k-means algorithm. Essentially, it is parameterized by three values: the
% number of clusters, the transformation function, and the ranking
% function. Ideally the transformation function would separate the dog as
% far as possible from the rest of the pixels in the image. The two most
% successful implementations we have tried transform based on color and
% texture. The ranking function then has to decide which cluster is most
% likely tl be the dog. 
    properties 
        % specify the number of clusters to use 
        num_clusts; 
        
        % specify a transformation function whose output will be clustered
        % according to the k-means clustering algorithm
        transform_function; 
        
        % specify a ranking function of type "ranker" that takes the binary
        % image outputs of the k-means clustering algorithm and tries to
        % predict which binary image contains the highest percentage of the
        % dog 
        ranking_function; 
        
        % Tell the create function whether to output all of the clustered
        % binary images
        output_all; 
    end
    
    methods 
        % This function builds an object, setting the properties fields of
        % the function equal to the parameters based into 
        function CLUST = my_cluster(n, transform, ranker, output)
            CLUST.num_clusts = n; 
            CLUST.transform_function = transform; 
            CLUST.ranking_function = ranker; 
            CLUST.output_all = output; 
        end
        
        % This function takes an image and creates masks that are most
        % likely to contain the dog. If output_all field of the object is
        % set to true, the function will output all of the masks. If
        % out_put all is set to false only the winner will is output. 
        function ranked_masks = make_masks(CLUST, img_in)
            % get image transformation 
            transformed_image = CLUST.transform_function(img_in);
            
            % do a quick gaussian filter to smooth the transformed space
            h = fspecial('gaussian', [10, 10], 0.5);
            filtered_image = zeros(size(transformed_image)); 
            for i = 1:3
                filtered_image(:,:,i) = imfilter(transformed_image(:,:,i), h); 
            end
            
            % rows of data_mat correspond to points and columns to variables
            data_mat = reshape(filtered_image, size(img_in, 1)*size(img_in, 2), 3);
            
            % compute k-means objects
            [IDX, C] = kmeans(data_mat, CLUST.num_clusts, 'dist', 'sqeuclidean');
            
            % apply the ranking function to the clustered output 
            ranked_masks = CLUST.ranking_function(IDX, C, [size(img_in, 1) size(img_in, 2)]);
            
            % decide whether to output all clustered binary images or just
            % top choice 
            if not(CLUST.output_all)
                ranked_masks = ranked_masks(:,:,1);
            end 
        end
    end
end