
%color_index = {[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[0,1,1],[0,0.5,1],[1,0.5,0]};
C = colormap;
ind = 4;

for n = 1:9

    color_index{n} = [C(ind,:)];
    ind = ind+7;
end

    date = '20150423';
    num_arena = 8;
    num_video = 6;
    direct = ['D:\data\' date];
    video = VideoReader([direct '\trial1\video_1.avi']);
    xvalues = (0:50:1000);
    
for j = 1:num_video
    
    trial = num2str(j);
    new_direct = [direct '\trial' trial];
    load([new_direct '\clean_tr.mat']);
    load([new_direct '\var_' date '_trial' trial]);
     
    figure 
    imshow(rgb2gray(video.read(1)));
    hold on
    
%     z = 10;
%     while variables.larvae_ID(2,2) > num
%    num = z*10;
%    if  
%        
%     
% end    
     %%
for i=1:num_arena
    col = variables.larvae_ID(2,i+1);
%     if col > num_arena
%         col = col-9;
%     end
    
    plot(clean_tr(:,i,1),clean_tr(:,i,2),'Color',color_index{col})
end
    savefig([new_direct '\traces_colorID.fig'])  
    
    
    figure
    [y]=hist(clean_tr(:,:,2),xvalues);
    bar(xvalues,y)

    savefig([new_direct '\histo_colorID.fig'])
    
end