classdef sobel_edges 
% applies a sobel edge-detecting filter to an image and shows the result 
    properties (Constant)
        h = fspecial('sobel'); 
    end
    methods (Static = true)
        function out_img = hor(img)
            out_img = imfilter(img, sobel_edges.h); 
        end
        function out_img = vert(img)
            out_img = imfilter(img, sobel_edges.h'); 
        end
    end
end
            