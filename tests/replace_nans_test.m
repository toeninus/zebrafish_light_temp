
clc;
if(any(replace_nans([0 NaN NaN NaN 0]) ~= [0 0 0 0 0]))
    error('Oops');
end
    
replace_nans([0 0 0 0 0]);

% Test nans at beginning
replace_nans([NaN NaN NaN 4 5]); %== [4 4 4 4 5];
replace_nans([0 0 NaN NaN NaN]);
replace_nans([8 4 NaN 7 NaN 3]);
replace_nans([9 3 NaN NaN 5 NaN 4 6 NaN NaN NaN 2]);
replace_nans([NaN NaN NaN NaN NaN]);
