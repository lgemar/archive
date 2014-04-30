function img_out = function_fold(img, varargin)
% This function applies a series of functions to an image. Each function should 
% either return an image or unit. 

% deal with case that fun_combine was passed the variable # of args from
% another function (as from multiple_function_tester)


% This flattens the input array of functions so that the leftmost function
% in the nested array structure is the leftmost element in the flattened
% array. 
    function fun_list = unwrap(args)
        if size(args, 2) == 1
            if iscell(args{1})
                fun_list = unwrap(args{1});
            else
                fun_list = args(1);
            end
        else
            if iscell(args{1})
                fun_list = [unwrap(args{1}), unwrap(args(2:end))];
            else
                fun_list = [args(1), unwrap(args(2:end))];
            end
        end
    end



% pull out the next function for application     
fun_list = unwrap(varargin); 
f = fun_list{1}; 

% recursively apply each of the functions to the image 
if size(fun_list, 2) == 1 % base case; this is the last function to apply
    if nargout(f) == 0
        img_out = img; 
        f(img); 
    else 
        img_out = f(img);
    end
else % recursively apply the remaining functions 
    if nargout(f) == 0
        f(img);
        img_out = function_fold(img, fun_list(2:end)); 
    else % deal with case where function returns unit 
        img_out = function_fold(f(img), fun_list(2:end));
    end 
end
end

    