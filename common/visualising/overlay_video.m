% to make overlay video of traces
% directory = folder in which both the video and the segm subfolder is
% videoname = name of the video to make the overlay without the .avi
function overlay_video(directory,trialname) 
videoname = ('cropvid_1.avi');
video = VideoReader([directory '\' videoname]);% opens the source video for the overlay; 

% load([directory '\segm\trayectorias.mat']);% this is for multiwelltracker trajectories
% trajectories = trayectorias;

 load([directory '\clean_tr.mat']);% this is for bonsai trajectories 
 trajectories = clean_tr;

frames = length(trajectories); % total number of frames
% finalvid = ([directory '\mwt_' videoname '.avi']);
 finalvid = ([directory '\bonsai_' trialname '.avi']);

%% with lines
a = 100; % number of frames to plot
aviobj = VideoWriter(finalvid);
aviobj.FrameRate = 25; %change here eventually to the correct frame rate 
open(aviobj);
for i=a+1:frames
h=figure;
imshow(rgb2gray(video.read(i)));
hold on
plot(trajectories(i-a:i,:,1),trajectories(i-a:i,:,2));
currFrame=getframe(h);
writeVideo(aviobj,currFrame);
close(h);
end
close(aviobj);

% figure 
% imshow(rgb2gray(video.read(1)));
% hold on
% plot(trajectories(:,:,1),trajectories(:,:,2))
%  savefig([directory '\mwt_traces' trialname '.fig'])
% savefig([directory '\bonsai_traces' trialname '.fig'])
%% with dots
% aviobj = VideoWriter(finalvid);
% open(aviobj);
% for i=2:4415
% h=figure;
% imshow(rgb2gray(video(i).cdata));
% hold on
% plot(trajectories(i,:,1),trajectories(i,:,2),'o')
% currFrame=getframe(h);
% writeVideo(aviobj,currFrame);
% close(h);
% end
end