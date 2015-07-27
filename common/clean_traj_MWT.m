
function clean_traj_MWT(date,number_vid,arenas,vid_length)


framerate = 25; % change here!!
vid_sec = vid_length*60;
vid_frames = vid_sec * framerate;
step = 1/framerate;

direct = ['D:\data\' date];
video = VideoReader([direct '\trial1\video_1.avi']);
% 5.4 pix/ mm
pix = 5.4;

threshold = 15; % threshold for max motion to eliminate tracking jumps
time = (0.04:step:vid_sec);

for i = 1:number_vid
    
    trial = num2str(i);
    new_direct = [direct '\trial' trial];
    load([new_direct '\segm\trayectorias.mat']);% this is for mwt trajectories
    M = trayectorias;
    
    
    clean_tr = zeros(vid_frames,arenas,3);
    clean_tr(:,:,1) = M(1:vid_frames,:,1);
    clean_tr(:,:,2) = M(1:vid_frames,:,2);
    
    for j = 1:arenas
        clean_tr(:, j, 1) = replace_nans(clean_tr(:, j, 1)); % this calls replace_nans for y values
        clean_tr(:, j, 2) = replace_nans(clean_tr(:, j, 2)); % and for x values
        
        % compute distance
        for k = 2:vid_frames-1;
            
            deltax = clean_tr(k,j,1)-clean_tr(k-1,j,1);
            
            deltay = clean_tr(k,j,2)-clean_tr(k-1,j,2);
            
            dist_p = sqrt((deltax^2)+(deltay^2)); % distance in pixels
            dist = dist_p/ pix;
            clean_tr(k,j,3) = dist;
            
            if dist >= threshold
                clean_tr(k,j,1) = clean_tr(k-1,j,1);
                clean_tr(k,j,2) = clean_tr(k-1,j,2);
                clean_tr(k,j,3) = 0;

            end
            
        end
        %          keyboard
    end
    
    save([direct '\clean_mwtTR_trial' trial '.mat'],'clean_tr');
    
%% plot traces on image
figure
imshow(rgb2gray(video.read(1)));
hold on
plot(clean_tr(:,:,1),clean_tr(:,:,2))
savefig([direct '\mwt_traces_trial' trial '.fig'])
end
end