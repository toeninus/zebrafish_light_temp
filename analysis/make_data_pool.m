


rec_time = 900; % length of the recording in seconds
time = (0.04:0.04:rec_time);

frame_rate = 25;
frames = rec_time * frame_rate;

data = struct;

% inputs
query = struct('genotype','Tu','age',6,'raising','norm','temp_grad','rt','light_grad','gr1_dark_center');
%query = struct('genotype','Tu','age',6,'raising','norm','temp_grad','rt','light_grad','dark_proj');

temp_grad = {'rt','gr2','gr4','gr8'};
data = struct;
for l = temp_grad
     query.temp_grad = l{1};
     data.(query.temp_grad) = pool_data_per_query(query);
end    

% to add a query 
query = struct('genotype','Tu','age',6,'raising','norm','temp_grad','gr8','light_grad','dark_proj');
data.temp_only = pool_data_per_query(query);

% light_grad = {'dark_proj'};
% for l = light_grad
%      query.light_grad = l{1};
%      data.(query.light_grad) = pool_data_per_query(query);
% end    

% for age retest data without changing the arena position

query = struct('genotype','Tu','age',5,'raising','norm','temp_grad','gr8','light_grad','dark_proj');

age = [5 6 7];
raising = {'norm','tested_at_5dpf','tested_at_5a6dpf'}; 
data = struct;
for l = 1:length(age)
    
    query.age = age(l);
    query.raising = raising{l};
    data.(['dpf' num2str(query.age)]) = pool_data_per_query(query);
    
end    


%light_grad = {'full'; 'dark'; 'gr4_light_center'; 'gr5_light_center'; 'gr6_light_center'};
%light_grad = {'gr4_light_center'; 'gr5_light_center'; 'gr6_light_center'};
%light_grad = {'dark_wo_proj'; 'dark_bot_top_10min';
%'dark10min_topbot2min10x'}; 'light_center_2cm';
%light_grad = {'dark10min_topbot2min10x'};
%light_grad = {'dark_2minupdown'};