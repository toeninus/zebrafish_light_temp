% bring bonsai output csv files into trajecotry format
% make_bonsai_trajec('20150401',3,9,2)

function make_bonsai_trajec(date,number_vid,arenas,vid_length)
    
    direct = ['D:\data\' date];
    corr_x = [62 189 317 448 581 711 841 971 1101]; % array with start x position of each arena
    % corr_y = [52 52 52 52 52 52 52 52 52];% array with start y position of each arena
    arena_index = 1:arenas;
    arena_index = fliplr(arena_index);
    
    framerate = 25;
    vid_sec = vid_length*60;
    vid_frames = vid_sec * framerate;
            
    for i = 1:number_vid
        
        bonsai_traj = zeros(vid_frames,arenas,2);
        trial = num2str(i);
        new_direct = [direct '\trial' trial];

            for j = 1:arenas
            index = arena_index(j);    
            n = num2str(j);    
            raw = dlmread([new_direct '\arena' n '_' trial '.csv'], ' ');
            x = raw(1:vid_frames,1);
            x(x==0) = NaN; 
            x_cor = x + corr_x(index);
            y = raw(1:vid_frames,2);
            y(y==0) = NaN; 
            y_cor = y + 52;
            
            bonsai_traj(:,index,1) = x_cor;
            bonsai_traj(:,index,2) = y_cor;
            end
        save([new_direct '\bonsai_traj'],'bonsai_traj');    
         
    end

end