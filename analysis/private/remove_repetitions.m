function [A, indices] = remove_repetitions(data)
% REMOVE_REPETITIONS removes subsequent repeating numbers from the vector
%  leaving only one occurance. The indices matrix contains the first and
%  last indices of the removed sequences.
%
% Example:
%  remove_repetitions([1 1 1 5 5 1 1 2 3 4 4])
% would return:
%  [1 5 1 2 3 4]
% with original indices:
%  [1 3; 4 5; 6 7; 8 8; 9 9; 10 11]
%

    A = [];
    indices = [1 NaN];
    
    index = 1;
    
    for i = 2:numel(data)
        if data(i) ~= data(i - 1)
            A(index) = data(i - 1);
            
            indices(index, 2) = i - 1;
            indices(index + 1, 1) = i;
            
            index = index + 1;
        end
    end
    
    indices(index, 2) = i;
    A(index) = data(i);    
end

