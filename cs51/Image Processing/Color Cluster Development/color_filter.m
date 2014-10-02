function img_out = color_filter(img, r_range, theta_range, z_range)
% This function takes in an image and filters out all colors that aren't in
% the HSV range specified by the given parameters. 

    % define clusters of acceptible pixel values
    function cluster_mask = define_cluster(img, r_range, theta_range, z_range)
        in_range = @(x, range) (x > range(1)) & (x < range(2)); 
        
        % see picture hsv color palat as a cylinder in three dimensions specified by
        % cylindrical coordinates. See HSV wikipedia page for diagram.        
        [r, theta, z] = hsv_extract(img); 
        
        r_clust = in_range(r, r_range); 
        theta_clust = in_range(theta, theta_range);
        z_clust = in_range(z, z_range); 
        
        cluster_mask = r_clust & theta_clust & z_clust;
    end

    function mask = apply_clusters(varargin)
        mask = varargin{1}; 
        for i = size(varargin, 2)
            mask = varargin{i} | mask; 
        end
    end

cmask = define_cluster(img, r_range, theta_range, z_range); 
mask = apply_clusters(cmask); 

img_out = mask; 
end
