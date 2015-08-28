
names = fieldnames(data);
dim = size(data.(names{1}).Ypos); % dim(1) = total number of frames
% dim(2) = number of replicates for names{1} 


frames = dim(1);
time_sec = frames / 25; % frames rate = 25
time = (0.04:0.04:time_sec);



%% plot distance to center over time
figure
row = length(names);
cols = 1;

dim_n = zeros(2,length(names)); 

for n = 1:length(names)
   
       fieldname = names{n};
       dim_n(:,n) = size(data.(names{n}).Ypos);
       subplot(row,cols,n)
       plot(time,data.(fieldname).Y_dist)
       axis([0 time_sec -500 500])
       xlabel('time [sec]')
       ylabel('distance to center [pix]')
       title([fieldname ' N=' num2str(dim_n(2,n))])
end

num_replicates = dim_n(2,:);

%% total motion during the entire recording
figure
total_dist = NaN(max(num_replicates),length(names));

for n = 1:length(names)
       fieldname = names{n};
       total_dist(1:num_replicates(n),n) = sum(data.(fieldname).move_dist);
end

figure
boxplot(total_dist)
%subplot(1,2,1)
%plot(5:1:7,[total_dist(:,1),total_dist(:,2),total_dist(:,3)],'b o--','markersize',10)
ylabel('total distance swam')
%set(gca,'xtick',[5,6,7],'xticklabel',{'5dpf','6dpf','7dpf'})
%axis([4.8 7.2 0 8500])
set(gca,'xtick',[1,2,3],'xticklabel',{'light_only','temp&light','temp_only'})

% 
% figure
% wall_dist = NaN(max(num_replicates),length(names));
% 
% for n = 1:length(names)
%        fieldname = names{n};
%        wall_dist(1:num_replicates(n),n) = mean(data.(fieldname).wall_dist);
% end

%boxplot(wall_dist)
% subplot(1,2,2)
% plot(5:1:7,[wall_dist(:,1),wall_dist(:,2),wall_dist(:,3)],'b o--','markersize',10)
% set(gca,'xtick',[5,6,7],'xticklabel',{'5dpf','6dpf','7dpf'})
% ylabel('mean distance to the wall')
% axis([4.8 7.2 0 37])
%set(gca,'xtick',[1,2,3],'xticklabel',{'5dpf','6dpf','7dpf'})




%% plot mean and var of Y pos 

mean_Y = NaN(max(num_replicates),length(names));
std_Y = NaN(max(num_replicates),length(names));

for n = 1:length(names)
       fieldname = names{n};
       mean_Yn = mean(data.(fieldname).Ypos(:,:)); 
       mean_Y(1:num_replicates(n),n) = (mean_Yn);
       std_Yn = std(data.(fieldname).Ypos(:,:));
       std_Y(1:num_replicates(n),n) = (std_Yn);
end

figure
subplot(1,2,1)
boxplot(mean_Y)
%set(gca,'xtick',[1,2,3],'xticklabel',{'light_only','temp&light','temp_only'})
set(gca,'xtick',[1,2,3],'xticklabel',{'5dpf','6dpf','7dpf'})
ylabel('mean Y position per larva')

subplot(1,2,2)
boxplot(std_Y)
%set(gca,'xtick',[1,2,3],'xticklabel',{'light_only','temp&light','temp_only'})
set(gca,'xtick',[1,2,3],'xticklabel',{'5dpf','6dpf','7dpf'})
ylabel('std of Y positions per larva')


%% 

figure
subplot(1,2,1)
plot(5:1:7,[mean_Y(:,1),mean_Y(:,2),mean_Y(:,3)],'b o--','markersize',10)
set(gca,'xtick',[1,2,3],'xticklabel',{'5dpf','6dpf','7dpf'})
ylabel('mean Y position per larva')
axis([4.9 7.1 0 900])
set(gca,'xtick',[5,6,7],'xticklabel',{'5dpf','6dpf','7dpf'})

subplot(1,2,2)
plot(5:1:7,[std_Y(:,1),std_Y(:,2),std_Y(:,3)],'b o--','markersize',10)
set(gca,'xtick',[1,2,3],'xticklabel',{'5dpf','6dpf','7dpf'})
ylabel('std of Y positions per larva')
axis([4.9 7.1 0 350])
set(gca,'xtick',[5,6,7],'xticklabel',{'5dpf','6dpf','7dpf'})


%%
% std over time 
time_window = 4500; % 1500 frame = 1 min
bins = frames/time_window;
std_win = NaN(max(num_replicates),bins,length(names)); 

figure
for n = 1:length(names)
       fieldname = names{n};
       init = 1;
       
       for t = 1:bins
           std_Yn = std(data.(fieldname).Ypos(init:init+time_window-1,:));
           std_win(:,t,n) = std_Yn;
           init = init + time_window;
       end

       subplot(3,1,n)
       plot(std_win(:,:,n)')
       axis([1 5 0 350])
       ylabel('std of Y position per 3 min')
       xlabel('recording time [3 min bins]')
       title([fieldname ' N=' num2str(dim_n(2,n))])
end



% plots per arena

arena_reps = max(num_replicates) /8;
mean_arena = NaN(arena_reps,8,length(names));
std_arena = NaN(arena_reps,8,length(names));

for n = 1:length(names)
    arena_count = (1:8:num_replicates(n)-7);
    for a = 1:8
        
        mean_arena(:,a,n) = mean_Y(arena_count,n);
        std_arena(:,a,n) = std_Y(arena_count,n);
        
        arena_count = arena_count +1;
    end
    
end


figure
for n = 1:length(names)
    errorbar(mean(mean_arena(:,:,n)),std(mean_arena(:,:,n)))
    hold on
    ylabel('mean Y position per larva')
    xlabel('Arena position')
end


figure
for n = 1:length(names)
    errorbar(mean(std_arena(:,:,n)),std(std_arena(:,:,n)))
    hold on
    ylabel('std of Y positions per larva')
    xlabel('Arena position')
end



%% hist of y pos 
%figure
x_centers = (-500:50:500);
nelements = zeros(length(x_centers),length(names));
elem_per_arena = zeros(length(x_centers),max(num_replicates),length(names));

for n = 1:length(names)
        fieldname = names{n};
        Y_dist_stable = data.(fieldname).Y_dist(:,:); % 4500 frames = 3 min
        nelements(:,n) = hist(Y_dist_stable(:),x_centers);
        elem_per_arena(:,1:num_replicates(n),n) = hist(Y_dist_stable,x_centers);
        clear Y_dist_stable
end

% normalize nelements
sum_elements = sum(nelements);

for n = 1:length(names)
        nelements(:,n) = nelements(:,n)/ sum_elements(n) * 100;
end    

figure
bar(x_centers,nelements,1.5)
%legend({'light_only','temp&light','temp_only'})
legend({'5dpf','6dpf','7dpf'})
ylabel('data points (%)')
xlabel('distance to center [pix]')


% plot per arena 
for n = 1:length(names)
    arena_count = (1:8:num_replicates(n)-7);
    
    figure
    for a = 1:8
        
        arena_data = elem_per_arena(:,arena_count,n);
        
        subplot(2,4,a)
        plot(x_centers,arena_data)
        axis([-500 500 0 10000])
        title(['Arena ' num2str(a)])
        
        arena_count = arena_count +1;
    end

end

%%

% plot Y distance against distance swam per frame 
% make averages 

figure
subplot(1,3,1)
plot(data.rt.Y_dist,data.rt.move_dist,'.')

subplot(1,3,2)
plot(data.gr8.Y_dist,data.gr8.move_dist,'.')

subplot(1,3,3)
plot(data.temp_only.Y_dist,data.temp_only.move_dist,'.')





% %% light switches 
% 
% start_time = 4500; % onset of light switches in frames
% switch_length = 3000; % also in frames 
% 
% time_windows = (start_time:switch_length:frames); 
% number_switches = length(time_windows)-1;
% reps_per_side = number_switches /2;
% 
% start = time_windows(1:number_switches) +1; 
% finish = time_windows(2:number_switches+1); %for 2 min consideration of latency
% 
% top = (1:2:number_switches); % array of odd numbers for light switches DOWN
% bot = (2:2:number_switches+1); % array of even numbers for light switches UP
% thresUp = 300;
% thresDown = -300;
% 
% latencyUp = NaN(reps_per_side, max(num_replicates), length(names));
% latencyDown = NaN(reps_per_side, max(num_replicates), length(names));
% 
% initial_dist_UP = NaN(reps_per_side, max(num_replicates), length(names));
% initial_dist_DOWN = NaN(reps_per_side, max(num_replicates), length(names));
% 
% prop_time_light_UP = NaN(reps_per_side, max(num_replicates), length(names));
% prop_time_light_DOWN = NaN(reps_per_side, max(num_replicates), length(names));
% 
% for n = 1:length(names)
%     
%     for a = 1:num_replicates(n)
%         
%             fieldname = names{n};
%             
%         for z = 1:reps_per_side
%             % light down
%             index1 = bot(z);
%             Ydist1 = data.(fieldname).Y_dist(start(index1):finish(index1),a);
%             
%             initial_dist_DOWN(z,a,n) = data.(fieldname).Y_dist(start(index1),a);
%             
%             score1 = find(Ydist1 < thresDown);
%             
%                 if isempty(score1)
%                     latencyDown(z,a,n) = NaN;
%                 else
%                     latencyDown(z,a,n) = score1(1);
%                 end
%                 
%             % %of time spend in the light area
%             prop_time_light_DOWN(z,a,n) = length(score1)/switch_length * 100;
%                 
%                 
%             % light up
%             index2 = top(z);
%             Ydist2 = data.(fieldname).Y_dist(start(index2):finish(index2),a);
%             
%             initial_dist_UP(z,a,n) = data.(fieldname).Y_dist(start(index2),a);
%             
%             score2 = find(Ydist2 > thresUp);
%             
%             
%                 if isempty(score2)
%                     latencyUp(z,a,n) = NaN;
%                 else
%                     latencyUp(z,a,n) = score2(1);
%                 end
%             
%             prop_time_light_UP(z,a,n) = length(score2)/switch_length * 100;    
%             
%         end
%     end
% end
% 
% % plots 
% % hist of time proportion spent in light per larva
% 
% x_vals = (0:10:100);
% figure
% for n = 1:length(names)
%    
%     subplot(1,2,n)
%     for z = 1:reps_per_side
%         hist(prop_time_light_UP(z,:,n),x_vals)
%         axis([-5 105 0 80])
%         hold on
%     end
%     title(names{n})
% end
% 
% 
% figure
% for n = 1:length(names)
%     
%     subplot(1,2,n)
%     for z = 1:reps_per_side
%         hist(prop_time_light_DOWN(z,:,n),x_vals)
%         axis([-5 105 0 80])
%         hold on
%     end
%     title(names{n})
% end
% 
% 
% mean_time_UP = mean(prop_time_light_UP,1);
% mean_time_UP = squeeze(mean_time_UP);
% figure
% boxplot(mean_time_UP)
% 
% mean_time_DOWN = mean(prop_time_light_DOWN,1);
% mean_time_DOWN = squeeze(mean_time_DOWN);
% figure
% boxplot(mean_time_DOWN)

