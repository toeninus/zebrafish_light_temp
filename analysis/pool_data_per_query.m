
function [data] = pool_data_per_query(query)
    
    function results = compare_var(var,query)
             
        
             if strcmp(var.genotype,query.genotype) ~= 1
                 results = false;
                 return
             end
        
        
             if var.age ~= query.age
                 results = false;
                 return
             end
             
             
             if strcmp(var.raising,query.raising) ~= 1
                  results = false;
                 return
             end
                 
             
             if strcmp(var.temp_grad,query.temp_grad) ~= 1
                  results = false;
                 return
             end
             
             if strcmp(var.light_grad,query.light_grad) ~= 1
                  results = false;
                 return
             end
             
             results = true;
    end
    
    data = struct;
    data.trial_ID = {};
    
    % go through all subfolders (data from different dates) and pool data
    % according to experimental conditions as proviced in each variables files
    % each subfolder should contain the clean_trajecteries and the var file for
    % each trial
    
    D = ('/Users/AG/Desktop/data');
    d = dir('/Users/AG/Desktop/data'); % directory
    isub = [d(:).isdir]; % returns logical vector of subfolders
    nameFolds = {d(isub).name}'; % returns name of subfolders
    nameFolds = nameFolds(3:end); % for some reason nameFolds has . and .. in the first two elements,
    % so here I am getting rid of them. double check is this always the case
    % and adjust accordingly if needed
    % loop through all data subfolders
    
    % add more if needed
    number_arenas = 8;
    sub = number_arenas -1;
    index = 1;
    
    for f = 1:length(nameFolds) % f for folder
        
        date = nameFolds{f}(11:end);
        new_dir = [D '/' nameFolds{f}];
        listing = dir(new_dir); % counts the numebr of files in the subfolder
        listing = listing(3:end);
        num_trials = length(listing)/2; % number of trials (because var and traj file for each)
        
        % loop through all trials per recording day
        
        for t = 1:num_trials % t for trials
            
            
            traj_file = [new_dir '/clean_mwtTR_trial' num2str(t)];
            var_file = [new_dir '/var_' date '_trial' num2str(t)];
            var = NaN;
            load(var_file)
            
            if compare_var(var.variables,query) 
                
                clean_tr = NaN;
                load(traj_file)
                
                dist_y = clean_tr(:,:,2) - 500;
                
                data.Y_dist(:,index:index+sub) = dist_y;
                data.move_dist(:,index:index+sub) = clean_tr(:,:,3);
                data.Ypos(:,index:index+sub) = clean_tr(:,:,2);
                data.Xpos(:,index:index+sub) = clean_tr(:,:,1);
                %data.wall_dist(:,index:index+sub) = clean_tr(:,:,4);
                index = index+number_arenas;
            
                data.trial_ID{end +1} = [date '_trial' num2str(t)];
            end
        end       
    end
end