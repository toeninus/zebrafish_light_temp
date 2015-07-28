% directory of all files from one recording day - as a string
% number_vid numgber of recordings that day - as a number
% example sort_datafiles('20150401',4,9)

function sort_datafiles(date,number_vid,arenas)

    direct = ['D:\data\' date];
    
    for i = 1:number_vid
    trial = num2str(i);
    new_direct = [direct '\trial' trial];
    videofile = [direct '\trial_' trial '.avi']; % changes test to the output name from bonsai!
    varfile = [direct '\var_' date '_trial' trial '.mat'];
        
    if isempty(dir(new_direct))
        mkdir(new_direct) 
    end
        
     movefile(videofile,new_direct)
     movefile([new_direct '\trial_' trial '.avi'],[new_direct '\video_1.avi'])
     movefile(varfile,new_direct)
    
    cd(direct);

    for j = 1:arenas
        arenafile = ['arena' num2str(j) '_' trial '.csv'];
        movefile(arenafile,new_direct)
    end
    
    end
    cd(['C:\Users\User\Documents\MATLAB\traces']);
end