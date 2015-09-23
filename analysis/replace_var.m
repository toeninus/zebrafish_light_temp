% replace a variable in var file

prev_str = 'dark_w/_proj';
new_str = 'dark_proj';

D = ('/Users/AG/Desktop/data');
d = dir('/Users/AG/Desktop/data'); % directory 
isub = [d(:).isdir]; % returns logical vector of subfolders
nameFolds = {d(isub).name}'; % returns name of subfolders 
nameFolds = nameFolds(3:end); % for some reason nameFolds has . and .. in the first two elements,
% so here I am getting rid of them. double check is this always the case
% and adjust accordingly if needed 

for f = 1:length(nameFolds) % f for folder
    
    date = nameFolds{f}(11:end);
    new_dir = [D '/' nameFolds{f}];
    listing = dir(new_dir); % counts the numebr of files in the subfolder
    listing = listing(3:end);
    num_trials = length(listing)/2; % number of trials (because var and traj file for each)
    
    % loop through all trials per recording day
    
    for t = 1:num_trials % t for trials
        var_file = [new_dir '/var_' date '_trial' num2str(t)];
        load(var_file)
        
        if strcmp(var.variables.light_grad,prev_str) == 1
            var.variables.light_grad = new_str;
            save(var_file,'var');
        end
        
    end
    
end

