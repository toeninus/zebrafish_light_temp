% to save recording variables into a matlab variable
% date = '20150402' year-month-date
% recording number, number of the trial for that day, should be consitent
% with the bonsai recording number, so starting from 1 (Bonsai trial0 is
% used for camera set up) NEEDS TO BE A STRING!
% genotype: 'Tu', 'AB', '5D', ... String
% age: 5, 6 or 7 ... Number
% light: 'none' no light; 'full' equal light (intensity?); 'grad1',
% 'grad2'... String
% temp: 'RT', 'grad1', 'grad2', 'grad3'
% example: enter_variables('20150402',1,'Tu',6,'none','RT')

function enter_variables(date,rec_num)
    
    geno = input('What is the genotype? ');
    age = input('How old are the larvae in dpf? ');
    raising_cond = input('How were the larvae raised? ');
    % normal = 28deg, regular LD cycle. 
    % add others here....
    
    light = input('Which light gradient is used? ');
    % dark, full (homogenous full light, intensity?), gradient1, gradient2
    
    temp = input('Which temperature gradient is used? ');
    % RT, gradient1, gradient2, gradient3... 
    
    
    order = input('Larva ID per arena - type in from arena 1 -> 9 ');
    order = cat(1,1:9,order)
    
    corr = input('Is the shown order correct?'); % 1 yes, 0 no
    
    if corr == 0
        order = input('Larva ID per arena - type in from arena 1 -> 9 ');
    end 
      
    test_num = input('How many times have the larvae been tested before? ');
    if test_num == 0
        previous = 0;
    else 
        previous = input('Which is the most recent corresponding trial? ');
    end    
    % i.e. '\20150415\trial1' 
    
     
    variables = struct('genotype',geno,'age',age,'raising',raising_cond,'light_grad'...
        ,light,'temp_grad',temp,'test_number',test_num,'previous_file', previous, 'larvae_ID', order);
       
    direct = ['D:\data\' date];
    if isempty(dir(direct))
        mkdir(direct)
    end
    
    save([direct '\var_' date '_trial' num2str(rec_num) '.mat'],'variables')
end