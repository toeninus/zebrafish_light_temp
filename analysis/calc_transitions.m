
% count transitions from one side of the arena to the other

thres_up = 150;
thres_down = -150;

names = fieldnames(data);

dim_n = zeros(2,length(names)); 

for n = 1:length(names)
       %fieldname = names{n};
       dim_n(:,n) = size(data.(names{n}).Ypos);
end

num_replicates = dim_n(2,:);

frames = dim_n(1,1);
time_sec = frames / 25; % frames rate = 25
time = (0.04:0.04:time_sec);

position_score = struct;
transition_score = NaN(max(num_replicates),length(names));

for n = 1:length(names)
    fieldname = names{n};
    
    for a = 1:num_replicates(n)
    
        [ transitions, labels ] = ...
            find_transitions( ...
                data.(fieldname).Y_dist(:, a), ...
                [thres_down, thres_up], ...
                {[1 2 3], [3 2 1]});
            
        position_score.(fieldname)(:, a) = labels;
        transition_score(a, n) = numel(transitions);
    end       
end

figure
hist(transition_score)