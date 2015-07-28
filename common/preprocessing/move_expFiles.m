
function move_expFiles(date,number)

    direct = ['D:\data\' date];
    for i = 1:number
    trial = num2str(i);
    
    new_direct = [direct '\datafiles_' date];
    if isempty(dir(new_direct))
        mkdir(new_direct) 
    end
    
    traj = [direct '\clean_mwtTR_trial' trial '.mat'];
    var = load([direct '\trial' trial '\var_' date '_trial' trial '.mat']);
    movefile(traj,new_direct)
    save([new_direct '\var_' date '_trial' trial],'var')
    
    end

end