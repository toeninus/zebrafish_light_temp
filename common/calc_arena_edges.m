
threshold = 23;
video = VideoReader('D:\data\20150722\trial1\video_1.avi');

% function clusters = blah(I, threshold)

I = rgb2gray(video.read(1));
%imshow(I);
It = I > threshold;
[Il, N] = bwlabel(It);
imagesc(bwlabel(It))

clusters = NaN(2,2,9);
index = 1;

for i = 1:N
    
    s = sum(Il(:)==i);
    if s < 30000, continue; end
    
    [y,x] = find(Il==i);
    
    top_l = [min(x), min(y)];
    bot_r = [max(x), max(y)];
    
    clusters(:,1,index) = top_l;
    clusters(:,2,index) = bot_r;
    index = index +1;
end

dim = clusters(:,2,:) - clusters(:,1,:);

%
image(I);
hold on
for j = 1:size(clusters,3)
    text(clusters(1, 1, j), clusters(2, 1, j), num2str(j), 'Color', 'r');
    rectangle('Position',[clusters(:,1,j), dim(:,1,j)],'edgecolor','r')
end