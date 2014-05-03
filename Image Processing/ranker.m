classdef ranker 
% This class is designed to be like a module in OCaml. it takes in the
% output of a k-means analysis of the colors in an image. k-means outputs
% IDX, which assigns each row/"observation" (in this case each observation
% is a pixel with some 3 parameter color designation) to a cluster. The
% other parameter output by k-means is C, which has the centers for the
% centroids of each of the clusters. Each function in this module must take
% these two parameters and return a set of ranked binary masks.
% Additionally it must take the parameter "img_size" because some of the
% filters rely on knowing the spatial separation of the pixels in
% 2-dimensions. 
    
    properties (Constant)
        % If we had more time to work on this project, we would use a
        % clustering algorithm that can find this target_color much more
        % exactly. This value was taken from a supervised learning trial I
        % did in the HSV color space. 
        target_color = [0.22 0.65 0.51];
    end
     
    % These methods are static meaning they can be called without
    % instantiating a ranker object. In this way the ranker object acts
    % like an OCaml module. 
    methods (Static = true)
        % This function ranks color clusters based on their nearness to a 
        % target color cluster. 
        function sorted_clusters = color_rank(clust_group, goal_center)            
            distance_fun = @(x, y) sqrt((x(1) - y(1))^2 + (x(2) - y(2))^2 + (x(3) - y(3))^2);            
            distances = zeros(1,size(clust_group, 1)); 
            for i = 1:size(clust_group, 1)
                distances(i) = distance_fun(goal_center, clust_group(i, :));
            end            
            [~, I] = sort(distances);
            sorted_clusters = I;
        end
        
        % This function ranks the clusters based on their closeness to a
        % target color. 
        function masks_out = color(IDX, C, img_size)
            masks_array = zeros(img_size(1), img_size(2), size(C, 1)); 
            for i = 1:size(C, 1)
                region_i = (IDX == i);
                masks_array(:,:,i) = reshape(region_i, img_size(1), img_size(2));
            end
            sorted_IDX = ranker.color_rank(C, ranker.target_color);
            masks_out = masks_array(:,:,sorted_IDX); 
        end
        
        % This ranks the clusters based on their standard deviation. The
        % logic here is that the cluster that represents the dog in color
        % will also be clustered in space, since all the dog pixels are in
        % one pretty tight location. 
        function masks_out = distance(IDX, C, img_size)           
            masks_array = zeros(img_size(1), img_size(2), size(C, 1)); 
            for i = 1:size(C, 1)
                region_i = (IDX == i);
                masks_array(:,:,i) = reshape(region_i, img_size(1), img_size(2));
                masks_array(:,:,i) = medfilt2(masks_array(:,:,i), [8 8]); 
            end
            
            % takes the 2-dimensional standard deviation as the measure of
            % how close together in space are each color cluster's pixels
            distance_measure = zeros(1, size(C, 3));
            for i = 1:size(C, 1)
                mask = masks_array(:,:,i);
                non_zeros = find(mask);
                [rows, cols] = ind2sub(size(mask), non_zeros);
                total_var = var(rows) + var(cols);
                distance_measure(i) = sqrt(total_var); 
            end
            
            [~, I] = sort(distance_measure);
            
            % if the output mask does not include at least 10% of the
            % pixels, opt for the second best mask 
            total_pixels = img_size(1)*img_size(2); 
            num_dogpixels = sum(reshape(masks_array(:,:,1), 1, total_pixels));
            if (num_dogpixels / total_pixels < 0.2)
                downgrade = I(1); 
                I = [I(2:end) downgrade]; 
            end
            
            % this contains the sorted cluster masks
            masks_out = masks_array(:,:,I); 
        end
    end
    
end

    