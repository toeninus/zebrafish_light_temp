function X = replace_nans(X)
% REPLACE_NANS 
% find all the NaNs in the array (x or y values of the trajectories)
% and replaces them with the next following value or in the case NaNs in
% the end of the data, replaces them with the last previous value

    L = bwlabel(isnan(X)); % finds all clusters of NaNs    
    n_fragm = max(L);

    for i = 1:n_fragm
        fragment = find(L == i);
                
        if(numel(X) >= (fragment(end) + 1))
            replacement_value = X(fragment(end) + 1);
        else
            if(fragment(1) > 1)
                replacement_value = X(fragment(1) - 1);
            else
                error('There is something horribly wrong with your file.');
            end                
        end
        
        X(fragment) = replacement_value;
    end
