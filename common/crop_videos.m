% this is to crop all video from one recording day to the same length
% directory of all files from one recording day - as a string
% number_vid numgber of recordings that day - as a number
% vid_length in minutes
% example crop_videos('20150401',3,2)

function crop_videos(date,number_vid,vid_length)
        
        framerate = 25;
        direct = ['D:\data\' date];
        vid_sec = vid_length*60;
        vid_frames = vid_sec * framerate;
                
        for i = 1:number_vid
            trial = num2str(i);
            new_direct = [direct '\trial' trial];
            videofile = VideoReader([new_direct '\video_1.avi']);
        vw = VideoWriter([new_direct '\cropvid_1.avi']);
        vw.FrameRate = framerate;
        frames = videofile.read([1 vid_frames]);
        % frames = videofile.read([50 vid_frames+50]) ---- for comparison
        % with Bonsai
        open(vw);
        writeVideo(vw,frames);
        close(vw);    
        
        end       

end